import pool from '../config/db.js';
import Order from '../models/Order.js';
import Cart from '../models/Cart.js';
import generateOrderId from '../utils/generateOrderId.js';
import razorpayService from './razorpayService.js';

export const orderService = {
  async createCheckoutOrder({ userId, items, address, paymentMethod = 'razorpay', couponCode = null }) {
    if (!Array.isArray(items) || items.length === 0) {
      throw new Error('At least one cart item is required.');
    }

    if (
      !address?.full_name ||
      !address?.phone ||
      !address?.address_line1 ||
      !address?.city ||
      !address?.state ||
      !address?.postal_code
    ) {
      throw new Error('A complete delivery address (name, phone, street, city, state, pincode) is required.');
    }

    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      let subtotal = 0;
      const verifiedItems = [];

      for (const item of items) {
        // Lock product row to verify inventory
        const [pRows] = await connection.query(
          'SELECT id, name, sku, price, stock_quantity, is_active FROM products WHERE id = ? FOR UPDATE',
          [item.product_id]
        );

        const product = pRows[0];
        if (!product || !product.is_active) {
          throw new Error(`Product "${product?.name || item.product_id}" is no longer available.`);
        }

        let variant = null;
        let effectivePrice = Number(product.price);
        let availableStock = Number(product.stock_quantity);

        if (item.variant_id) {
          const [vRows] = await connection.query(
            'SELECT id, variant_name, color_name, size, price, stock_quantity FROM product_variants WHERE id = ? AND product_id = ? FOR UPDATE',
            [item.variant_id, item.product_id]
          );
          variant = vRows[0];
          if (!variant) {
            throw new Error(`Requested variant for "${product.name}" does not exist.`);
          }
          if (variant.price) effectivePrice = Number(variant.price);
          availableStock = Number(variant.stock_quantity);
        }

        const qty = Number(item.quantity);
        if (qty <= 0) {
          throw new Error(`Invalid quantity for ${product.name}.`);
        }

        if (availableStock < qty) {
          throw new Error(`Insufficient stock for "${product.name}${variant ? ` (${variant.color_name || variant.size})` : ''}". Available: ${availableStock}.`);
        }

        const itemTotal = effectivePrice * qty;
        subtotal += itemTotal;

        verifiedItems.push({
          productId: product.id,
          variantId: variant?.id || null,
          productName: product.name,
          variantName: variant ? `${variant.color_name || ''} ${variant.size || ''}`.trim() : null,
          sku: product.sku,
          quantity: qty,
          unitPrice: effectivePrice,
          totalPrice: itemTotal
        });
      }

      // Verify promotional launch coupon
      let discountAmount = 0;
      if (couponCode) {
        const normalized = String(couponCode).trim().toUpperCase();
        if (normalized === 'MYSTERY4499') {
          discountAmount = Math.min(500, subtotal);
        } else if (normalized === 'LAUNCH10' || normalized === 'BETHANY10') {
          discountAmount = Math.round((subtotal * 0.1) * 100) / 100;
        } else if (normalized === 'WELCOME500') {
          discountAmount = Math.min(500, subtotal);
        }
      }

      // Exact shipping calculation (Threshold: ₹1,499)
      const discountedSubtotal = Math.max(0, subtotal - discountAmount);
      const shippingAmount = discountedSubtotal >= 1499 ? 0 : 99;
      const totalAmount = Math.max(1, discountedSubtotal + shippingAmount);
      const orderNumber = generateOrderId();

      // Insert Order record with verified discount
      const orderId = await Order.create(
        {
          userId,
          orderNumber,
          subtotal,
          discountAmount,
          shippingAmount,
          totalAmount,
          address,
          paymentMethod
        },
        connection
      );

      // Insert line items
      for (const item of verifiedItems) {
        await Order.addOrderItem(
          {
            orderId,
            productId: item.productId,
            variantId: item.variantId,
            productName: item.productName,
            variantName: item.variantName,
            sku: item.sku,
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            totalPrice: item.totalPrice
          },
          connection
        );
      }

      // Create Razorpay Gateway Order or COD
      let razorpayOrder = null;
      if (paymentMethod === 'razorpay') {
        razorpayOrder = await razorpayService.createRazorpayOrder({
          amount: totalAmount,
          currency: 'INR',
          receipt: orderNumber
        });

        await connection.query(
          `INSERT INTO payments (order_id, provider, razorpay_order_id, amount, status)
           VALUES (?, 'razorpay', ?, ?, 'created')`,
          [orderId, razorpayOrder.id, totalAmount]
        );
      } else if (paymentMethod === 'cod') {
        await connection.query(
          `INSERT INTO payments (order_id, provider, amount, status)
           VALUES (?, 'cod', ?, 'pending')`,
          [orderId, totalAmount]
        );

        // Deduct inventory immediately for confirmed COD orders
        for (const item of verifiedItems) {
          if (item.variantId) {
            await connection.query(
              'UPDATE product_variants SET stock_quantity = stock_quantity - ? WHERE id = ?',
              [item.quantity, item.variantId]
            );
          }
          await connection.query(
            'UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ?',
            [item.quantity, item.productId]
          );
        }

        await Cart.clearCart(userId, connection);
      }

      await connection.commit();

      return {
        orderId,
        orderNumber,
        subtotal,
        shippingAmount,
        totalAmount,
        razorpayOrder,
        keyId: process.env.RAZORPAY_KEY_ID || ''
      };
    } catch (err) {
      await connection.rollback();
      throw err;
    } finally {
      connection.release();
    }
  },

  async verifyAndConfirmPayment({ orderId, userId, razorpayOrderId, razorpayPaymentId, razorpaySignature }) {
    const isValid = razorpayService.verifySignature({
      razorpayOrderId,
      razorpayPaymentId,
      razorpaySignature
    });

    if (!isValid) {
      throw new Error('Payment verification failed: invalid signature.');
    }

    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      // Find order and lock
      const [orderRows] = await connection.query(
        'SELECT id, user_id, status, payment_status FROM orders WHERE id = ? FOR UPDATE',
        [orderId]
      );

      const order = orderRows[0];
      if (!order || order.user_id !== userId) {
        throw new Error('Order not found or authorization failed.');
      }

      if (order.payment_status === 'paid') {
        await connection.commit();
        return { verified: true, orderId, message: 'Order was already confirmed.' };
      }

      // Update payment record
      await connection.query(
        `UPDATE payments SET
          razorpay_payment_id = ?,
          razorpay_signature = ?,
          status = 'captured'
         WHERE order_id = ?`,
        [razorpayPaymentId, razorpaySignature, orderId]
      );

      // Update order status
      await connection.query(
        "UPDATE orders SET payment_status = 'paid', status = 'confirmed' WHERE id = ?",
        [orderId]
      );

      // CRITICAL INVENTORY FIX: Decrement stock atomically
      const [items] = await connection.query(
        'SELECT product_id, variant_id, quantity FROM order_items WHERE order_id = ?',
        [orderId]
      );

      for (const item of items) {
        // Decrement product base stock
        await connection.query(
          'UPDATE products SET stock_quantity = GREATEST(0, stock_quantity - ?) WHERE id = ?',
          [item.quantity, item.product_id]
        );

        // Decrement variant stock if applicable
        if (item.variant_id) {
          await connection.query(
            'UPDATE product_variants SET stock_quantity = GREATEST(0, stock_quantity - ?) WHERE id = ?',
            [item.quantity, item.variant_id]
          );
        }
      }

      // Clear the user's database cart
      await Cart.clearCart(userId, connection);

      await connection.commit();

      return { verified: true, orderId };
    } catch (err) {
      await connection.rollback();
      throw err;
    } finally {
      connection.release();
    }
  }
};

export default orderService;

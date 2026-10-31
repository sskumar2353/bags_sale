import pool from '../config/db.js';

export const Order = {
  async create({
    userId,
    orderNumber,
    subtotal,
    shippingAmount,
    totalAmount,
    address,
    paymentMethod = 'razorpay'
  }, connection = pool) {
    const [result] = await connection.query(
      `INSERT INTO orders (
        user_id, order_number, status, payment_status, payment_method,
        subtotal, shipping_amount, total_amount,
        shipping_name, shipping_phone, shipping_address_line1,
        shipping_address_line2, shipping_city, shipping_state,
        shipping_postal_code, shipping_country
      ) VALUES (?, ?, 'pending', 'pending', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        userId,
        orderNumber,
        paymentMethod,
        subtotal,
        shippingAmount,
        totalAmount,
        address.full_name,
        address.phone,
        address.address_line1,
        address.address_line2 || null,
        address.city,
        address.state,
        address.postal_code,
        address.country || 'India'
      ]
    );

    return result.insertId;
  },

  async addOrderItem({
    orderId,
    productId,
    variantId = null,
    productName,
    variantName = null,
    sku,
    quantity,
    unitPrice,
    totalPrice
  }, connection = pool) {
    await connection.query(
      `INSERT INTO order_items (
        order_id, product_id, variant_id, product_name, variant_name,
        sku, quantity, unit_price, total_price
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [orderId, productId, variantId, productName, variantName, sku, quantity, unitPrice, totalPrice]
    );
  },

  async findByUserId(userId) {
    // Strictly show only orders where payment was completed successfully
    const [orders] = await pool.query(
      "SELECT * FROM orders WHERE user_id = ? AND payment_status = 'paid' ORDER BY created_at DESC",
      [userId]
    );

    for (const order of orders) {
      const [items] = await pool.query(
        'SELECT * FROM order_items WHERE order_id = ?',
        [order.id]
      );
      order.items = items;
    }

    return orders;
  },

  async findById(orderId, userId = null) {
    const where = ['id = ?'];
    const args = [orderId];
    if (userId) {
      where.push('user_id = ?');
      args.push(userId);
    }

    const [orders] = await pool.query(`SELECT * FROM orders WHERE ${where.join(' AND ')}`, args);
    const order = orders[0] || null;
    if (!order) return null;

    const [items] = await pool.query('SELECT * FROM order_items WHERE order_id = ?', [order.id]);
    order.items = items;
    return order;
  },

  async findAll() {
    const [orders] = await pool.query(
      `SELECT o.*, u.email AS customer_email, u.first_name, u.last_name 
       FROM orders o 
       JOIN users u ON u.id = o.user_id 
       ORDER BY o.created_at DESC`
    );

    for (const order of orders) {
      const [items] = await pool.query('SELECT * FROM order_items WHERE order_id = ?', [order.id]);
      order.items = items;
    }

    return orders;
  },

  async updateStatus(orderId, status) {
    await pool.query('UPDATE orders SET status = ? WHERE id = ?', [status, orderId]);
  },

  async updatePaymentStatus(orderId, paymentStatus, connection = pool) {
    await connection.query('UPDATE orders SET payment_status = ? WHERE id = ?', [paymentStatus, orderId]);
  },

  async getAdminStats() {
    const [orderStats] = await pool.query(`
      SELECT 
        COUNT(*) AS total_orders,
        COALESCE(SUM(CASE WHEN payment_status = 'paid' THEN total_amount ELSE 0 END), 0) AS total_revenue,
        COUNT(CASE WHEN status = 'pending' THEN 1 END) AS pending_orders
      FROM orders
    `);

    return {
      totalOrders: Number(orderStats[0]?.total_orders || 0),
      totalRevenue: Number(orderStats[0]?.total_revenue || 0),
      pendingOrders: Number(orderStats[0]?.pending_orders || 0)
    };
  }
};

export default Order;

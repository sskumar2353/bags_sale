import orderService from '../services/orderService.js';
import razorpayService from '../services/razorpayService.js';

export const createDonationOrder = async (req, res, next) => {
  try {
    const { amount = 1000 } = req.body;
    const numAmount = Math.max(1, Number(amount) || 1000);
    const receipt = `don_${Date.now()}`;

    let razorpayOrder = null;
    try {
      razorpayOrder = await razorpayService.createRazorpayOrder({
        amount: numAmount,
        currency: 'INR',
        receipt
      });
    } catch (rzpErr) {
      console.warn('Backend Razorpay order creation for donation failed:', rzpErr.message);
    }

    res.json({
      razorpayOrder,
      keyId: process.env.RAZORPAY_KEY_ID || '',
      amount: numAmount
    });
  } catch (err) {
    next(err);
  }
};

export const validateCoupon = async (req, res) => {
  try {
    const { code, subtotal = 0 } = req.body;
    if (!code) {
      return res.status(400).json({ valid: false, message: 'Coupon code is required.' });
    }

    const normalized = String(code).trim().toUpperCase();
    const numSubtotal = Number(subtotal) || 0;

    if (normalized === 'MYSTERY4499') {
      const discount = Math.min(500, numSubtotal);
      return res.json({
        valid: true,
        code: 'MYSTERY4499',
        discountAmount: discount,
        description: 'Application Launch Special: ₹500 OFF + Free Mystery Gift',
        hasMysteryGift: numSubtotal >= 4499
      });
    }

    if (normalized === 'LAUNCH10' || normalized === 'BETHANY10') {
      const discount = Math.round((numSubtotal * 0.1) * 100) / 100;
      return res.json({
        valid: true,
        code: normalized,
        discountAmount: discount,
        description: 'Launch Celebration: 10% OFF'
      });
    }

    if (normalized === 'WELCOME500') {
      const discount = Math.min(500, numSubtotal);
      return res.json({
        valid: true,
        code: 'WELCOME500',
        discountAmount: discount,
        description: 'Welcome Offer: ₹500 OFF'
      });
    }

    return res.status(404).json({
      valid: false,
      message: 'Invalid coupon code. Try MYSTERY4499 to save ₹500!'
    });
  } catch {
    res.status(500).json({ valid: false, message: 'Failed to validate coupon.' });
  }
};

export const createOrder = async (req, res, next) => {
  try {
    const { items, address, paymentMethod, couponCode } = req.body;
    const result = await orderService.createCheckoutOrder({
      userId: req.user.id,
      items,
      address,
      paymentMethod,
      couponCode
    });
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
};

export const verifyPayment = async (req, res, next) => {
  try {
    const { order_id, razorpay_order_id, razorpay_payment_id, razorpay_signature } = req.body;
    const result = await orderService.verifyAndConfirmPayment({
      orderId: order_id,
      userId: req.user.id,
      razorpayOrderId: razorpay_order_id,
      razorpayPaymentId: razorpay_payment_id,
      razorpaySignature: razorpay_signature
    });
    res.json(result);
  } catch (err) {
    next(err);
  }
};

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

export const createOrder = async (req, res, next) => {
  try {
    const { items, address, paymentMethod } = req.body;
    const result = await orderService.createCheckoutOrder({
      userId: req.user.id,
      items,
      address,
      paymentMethod
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

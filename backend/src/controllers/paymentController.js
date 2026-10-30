import orderService from '../services/orderService.js';

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

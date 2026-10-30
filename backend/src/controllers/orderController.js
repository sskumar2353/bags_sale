import Order from '../models/Order.js';

export const getOrders = async (req, res, next) => {
  try {
    const orders = await Order.findByUserId(req.user.id);
    res.json(orders);
  } catch (err) {
    next(err);
  }
};

export const getOrderById = async (req, res, next) => {
  try {
    const order = await Order.findById(req.params.id, req.user.role === 'admin' ? null : req.user.id);
    if (!order) {
      return res.status(404).json({ message: 'Order not found.' });
    }
    res.json(order);
  } catch (err) {
    next(err);
  }
};

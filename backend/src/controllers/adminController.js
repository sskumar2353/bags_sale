import Product from '../models/Product.js';
import Category from '../models/Category.js';
import Order from '../models/Order.js';
import User from '../models/User.js';

export const getDashboardStats = async (req, res, next) => {
  try {
    const [totalProducts, totalUsers, lowStockCount, orderStats] = await Promise.all([
      Product.count(),
      User.count(),
      Product.countLowStock(5),
      Order.getAdminStats()
    ]);

    res.json({
      totalProducts,
      totalUsers,
      lowStockCount,
      ...orderStats
    });
  } catch (err) {
    next(err);
  }
};

export const getProducts = async (req, res, next) => {
  try {
    // Admin gets all products including inactive ones if desired
    const products = await Product.findAll();
    res.json(products);
  } catch (err) {
    next(err);
  }
};

export const createProduct = async (req, res, next) => {
  try {
    const productId = await Product.create(req.body);
    const product = await Product.findById(productId);
    res.status(201).json(product);
  } catch (err) {
    next(err);
  }
};

export const updateProduct = async (req, res, next) => {
  try {
    await Product.update(req.params.id, req.body);
    const product = await Product.findById(req.params.id);
    res.json(product);
  } catch (err) {
    next(err);
  }
};

export const deleteProduct = async (req, res, next) => {
  try {
    await Product.delete(req.params.id);
    res.json({ message: 'Product deactivated successfully.' });
  } catch (err) {
    next(err);
  }
};

export const createCategory = async (req, res, next) => {
  try {
    const catId = await Category.create(req.body);
    const category = await Category.findById(catId);
    res.status(201).json(category);
  } catch (err) {
    next(err);
  }
};

export const updateCategory = async (req, res, next) => {
  try {
    await Category.update(req.params.id, req.body);
    const category = await Category.findById(req.params.id);
    res.json(category);
  } catch (err) {
    next(err);
  }
};

export const getOrders = async (req, res, next) => {
  try {
    const orders = await Order.findAll();
    res.json(orders);
  } catch (err) {
    next(err);
  }
};

export const updateOrderStatus = async (req, res, next) => {
  try {
    const { status } = req.body;
    await Order.updateStatus(req.params.id, status);
    res.json({ message: `Order status updated to ${status}.` });
  } catch (err) {
    next(err);
  }
};

export const getUsers = async (req, res, next) => {
  try {
    const users = await User.findAll();
    res.json(users);
  } catch (err) {
    next(err);
  }
};

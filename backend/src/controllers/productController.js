import Product from '../models/Product.js';

export const getProducts = async (req, res, next) => {
  try {
    const { category, search, featured, newest, inStock, sort } = req.query;
    const products = await Product.findAll({
      category,
      search,
      featured,
      newest,
      inStock,
      sort
    });
    res.json(products);
  } catch (err) {
    next(err);
  }
};

export const getProductBySlug = async (req, res, next) => {
  try {
    const product = await Product.findBySlug(req.params.slug);
    if (!product) {
      return res.status(404).json({ message: 'Product not found.' });
    }
    res.json(product);
  } catch (err) {
    next(err);
  }
};

export const getProductById = async (req, res, next) => {
  try {
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ message: 'Product not found.' });
    }
    res.json(product);
  } catch (err) {
    next(err);
  }
};

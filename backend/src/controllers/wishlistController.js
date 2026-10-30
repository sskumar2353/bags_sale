import Wishlist from '../models/Wishlist.js';

export const getWishlist = async (req, res, next) => {
  try {
    const items = await Wishlist.getItems(req.user.id);
    res.json(items);
  } catch (err) {
    next(err);
  }
};

export const addItem = async (req, res, next) => {
  try {
    const { product_id } = req.body;
    if (!product_id) {
      return res.status(400).json({ message: 'product_id is required.' });
    }
    await Wishlist.addItem(req.user.id, product_id);
    const items = await Wishlist.getItems(req.user.id);
    res.status(201).json(items);
  } catch (err) {
    next(err);
  }
};

export const removeItem = async (req, res, next) => {
  try {
    await Wishlist.removeItem(req.user.id, req.params.productId);
    const items = await Wishlist.getItems(req.user.id);
    res.json(items);
  } catch (err) {
    next(err);
  }
};

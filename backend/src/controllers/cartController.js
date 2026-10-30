import Cart from '../models/Cart.js';

export const getCart = async (req, res, next) => {
  try {
    const items = await Cart.getItems(req.user.id);
    res.json(items);
  } catch (err) {
    next(err);
  }
};

export const addItem = async (req, res, next) => {
  try {
    const { product_id, variant_id, quantity } = req.body;
    if (!product_id) {
      return res.status(400).json({ message: 'product_id is required.' });
    }

    const qty = Number(quantity) || 1;
    const itemId = await Cart.addItem(req.user.id, {
      productId: product_id,
      variantId: variant_id || null,
      quantity: qty
    });

    const items = await Cart.getItems(req.user.id);
    res.status(201).json(items);
  } catch (err) {
    next(err);
  }
};

export const updateQuantity = async (req, res, next) => {
  try {
    const { quantity } = req.body;
    const itemId = req.params.id;
    await Cart.updateItemQuantity(req.user.id, itemId, Number(quantity));
    const items = await Cart.getItems(req.user.id);
    res.json(items);
  } catch (err) {
    next(err);
  }
};

export const removeItem = async (req, res, next) => {
  try {
    await Cart.removeItem(req.user.id, req.params.id);
    const items = await Cart.getItems(req.user.id);
    res.json(items);
  } catch (err) {
    next(err);
  }
};

export const clearCart = async (req, res, next) => {
  try {
    await Cart.clearCart(req.user.id);
    res.json({ message: 'Cart cleared successfully.' });
  } catch (err) {
    next(err);
  }
};

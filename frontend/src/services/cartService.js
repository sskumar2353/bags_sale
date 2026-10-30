import api from './api';

export const cartService = {
  async getCart() {
    const res = await api.get('/cart');
    return res.data;
  },

  async addToCart({ productId, variantId = null, quantity = 1 }) {
    const res = await api.post('/cart/items', {
      product_id: productId,
      variant_id: variantId,
      quantity
    });
    return res.data;
  },

  async updateQuantity(itemId, quantity) {
    const res = await api.put(`/cart/items/${itemId}`, { quantity });
    return res.data;
  },

  async removeFromCart(itemId) {
    const res = await api.delete(`/cart/items/${itemId}`);
    return res.data;
  },

  async clearCart() {
    const res = await api.delete('/cart');
    return res.data;
  }
};

export default cartService;

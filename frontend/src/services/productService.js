import api from './api';

export const productService = {
  async getProducts(params = {}) {
    const res = await api.get('/products', { params });
    return res.data;
  },

  async getProductBySlug(slug) {
    const res = await api.get(`/products/${encodeURIComponent(slug)}`);
    return res.data;
  },

  async getCategories() {
    const res = await api.get('/categories');
    return res.data;
  },

  // Admin endpoints
  async adminGetProducts() {
    const res = await api.get('/admin/products');
    return res.data;
  },

  async adminCreateProduct(data) {
    const res = await api.post('/admin/products', data);
    return res.data;
  },

  async adminUpdateProduct(id, data) {
    const res = await api.put(`/admin/products/${id}`, data);
    return res.data;
  },

  async adminDeleteProduct(id) {
    const res = await api.delete(`/admin/products/${id}`);
    return res.data;
  },

  async adminCreateCategory(data) {
    const res = await api.post('/admin/categories', data);
    return res.data;
  },

  async adminUpdateCategory(id, data) {
    const res = await api.put(`/admin/categories/${id}`, data);
    return res.data;
  },

  async adminGetDashboardStats() {
    const res = await api.get('/admin/dashboard');
    return res.data;
  },

  async adminGetUsers() {
    const res = await api.get('/admin/users');
    return res.data;
  }
};

export default productService;

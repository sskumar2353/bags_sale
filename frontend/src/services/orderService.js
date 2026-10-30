import api from './api';

export const orderService = {
  async getOrders() {
    const res = await api.get('/orders');
    return res.data;
  },

  async getOrderById(id) {
    const res = await api.get(`/orders/${id}`);
    return res.data;
  },

  async adminGetOrders() {
    const res = await api.get('/admin/orders');
    return res.data;
  },

  async adminUpdateOrderStatus(orderId, status) {
    const res = await api.put(`/admin/orders/${orderId}/status`, { status });
    return res.data;
  }
};

export default orderService;

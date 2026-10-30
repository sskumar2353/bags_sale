import api from './api';

export const authService = {
  async register(data) {
    const res = await api.post('/auth/register', data);
    return res.data;
  },

  async login(data) {
    const res = await api.post('/auth/login', data);
    return res.data;
  },

  async logout() {
    const res = await api.post('/auth/logout');
    return res.data;
  },

  async forgotPassword(email) {
    const res = await api.post('/auth/forgot-password', { email });
    return res.data;
  },

  async resetPassword({ token, newPassword }) {
    const res = await api.post('/auth/reset-password', { token, newPassword });
    return res.data;
  },

  async getCurrentUser() {
    const res = await api.get('/auth/me');
    return res.data;
  },

  async getAddresses() {
    const res = await api.get('/auth/addresses');
    return res.data;
  },

  async addAddress(address) {
    const res = await api.post('/auth/addresses', address);
    return res.data;
  },

  async updateAddress(id, address) {
    const res = await api.put(`/auth/addresses/${id}`, address);
    return res.data;
  },

  async deleteAddress(id) {
    const res = await api.delete(`/auth/addresses/${id}`);
    return res.data;
  }
};

export default authService;

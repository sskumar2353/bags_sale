import api from './api';

export const paymentService = {
  async createOrder({ items, address, paymentMethod = 'razorpay' }) {
    const res = await api.post('/payments/create-order', {
      items,
      address,
      paymentMethod
    });
    return res.data;
  },

  async verifyPayment(paymentData) {
    const res = await api.post('/payments/verify', paymentData);
    return res.data;
  }
};

export default paymentService;

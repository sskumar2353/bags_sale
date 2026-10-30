import crypto from 'node:crypto';
import { getRazorpayInstance } from '../config/razorpay.js';

export const razorpayService = {
  async createRazorpayOrder({ amount, currency = 'INR', receipt }) {
    const razorpay = getRazorpayInstance();
    const amountInPaise = Math.round(Number(amount) * 100);

    const order = await razorpay.orders.create({
      amount: amountInPaise,
      currency,
      receipt
    });

    return order;
  },

  verifySignature({ razorpayOrderId, razorpayPaymentId, razorpaySignature }) {
    const secret = process.env.RAZORPAY_KEY_SECRET;
    if (!secret) {
      throw new Error('RAZORPAY_KEY_SECRET is not configured.');
    }

    if (!razorpayOrderId || !razorpayPaymentId || !razorpaySignature) {
      return false;
    }

    const payload = `${razorpayOrderId}|${razorpayPaymentId}`;
    const expectedSignature = crypto
      .createHmac('sha256', secret)
      .update(payload)
      .digest('hex');

    const expectedBuffer = Buffer.from(expectedSignature, 'utf8');
    const signatureBuffer = Buffer.from(razorpaySignature, 'utf8');

    // CRITICAL SECURITY FIX: prevent crypto.timingSafeEqual RangeError when lengths differ
    if (expectedBuffer.length !== signatureBuffer.length) {
      return false;
    }

    return crypto.timingSafeEqual(expectedBuffer, signatureBuffer);
  }
};

export default razorpayService;

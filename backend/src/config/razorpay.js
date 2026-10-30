import Razorpay from 'razorpay';
import dotenv from 'dotenv';
dotenv.config();

export const getRazorpayInstance = () => {
  const key_id = process.env.RAZORPAY_KEY_ID;
  const key_secret = process.env.RAZORPAY_KEY_SECRET;

  if (!key_id || !key_secret) {
    throw new Error('Razorpay credentials (RAZORPAY_KEY_ID & RAZORPAY_KEY_SECRET) are not configured in environment.');
  }

  return new Razorpay({
    key_id,
    key_secret
  });
};

export default getRazorpayInstance;

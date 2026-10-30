import crypto from 'node:crypto';

export const generateOrderId = () => {
  const timestamp = Date.now().toString().slice(-8);
  const random = crypto.randomBytes(2).toString('hex').toUpperCase();
  return `DO-${timestamp}-${random}`;
};

export default generateOrderId;

export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000/api';
export const RAZORPAY_KEY_ID = import.meta.env.VITE_RAZORPAY_KEY_ID || '';

export const CATEGORIES = [
  'Tote Bags',
  'Crossbody Bags',
  'Backpacks',
  'Messenger / Laptop Bags',
  'Phone Bags',
  'Wallets',
  'Duffle Bags',
  'Pouches',
  'Bag Accessories'
];

export const NAV_LINKS = [
  { label: 'TECH', to: '/category/tech' },
  { label: 'WORK ESSENTIALS', to: '/category/work-essentials' },
  { label: 'GIFTING', to: '/gifting', hasGiftBow: true },
  { label: 'COLLECTIONS', to: '/shop' },
  { label: 'NEW ARRIVALS', to: '/shop?sort=newest' }
];

export const ORDER_STATUSES = [
  'pending',
  'confirmed',
  'processing',
  'shipped',
  'delivered',
  'cancelled',
  'returned'
];

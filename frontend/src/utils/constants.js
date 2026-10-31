const rawApiUrl = (import.meta.env.VITE_API_URL || 'http://localhost:5000/api')
  .trim()
  .replace(/\/$/, '');

export const API_URL = rawApiUrl.endsWith('/api') ? rawApiUrl : `${rawApiUrl}/api`;
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
  { label: 'Shop', to: '/shop' },
  { label: 'Our Story', to: '/#our-story' },
  { label: 'Your Impact', to: '/#impact' },
  { label: 'Gifting', to: '/gifting' },
  { label: 'Contact', to: '/pages/contact-us' }
];

export const NAV_LINKS_TE = [
  { label: 'షాప్ (Shop)', to: '/shop' },
  { label: 'మా కథ (Our Story)', to: '/#our-story' },
  { label: 'ప్రభావం (Impact)', to: '/#impact' },
  { label: 'బహుమతులు (Gifting)', to: '/gifting' },
  { label: 'సంప్రదించండి (Contact)', to: '/pages/contact-us' }
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

export const isValidEmail = (email) => {
  return typeof email === 'string' && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());
};

export const isValidPhone = (phone) => {
  if (!phone) return true; // optional
  const clean = phone.replace(/[\s\-\+]/g, '');
  return clean.length >= 10 && clean.length <= 15;
};

export const isValidPostalCode = (code) => {
  if (!code) return false;
  return /^[1-9][0-9]{5}$/.test(code.trim()); // standard 6-digit Indian PIN
};

export const formatPrice = (amount) => {
  const n = Number(amount || 0);
  return `₹${n.toLocaleString('en-IN')}`;
};

export default formatPrice;

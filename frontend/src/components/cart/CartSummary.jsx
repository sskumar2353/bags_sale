import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, Tag, Check, X, Sparkles } from 'lucide-react';
import formatPrice from '../../utils/formatPrice';

export default function CartSummary({
  subtotal,
  discount = 0,
  coupon = null,
  onApplyCoupon,
  onRemoveCoupon,
  shipping,
  total,
  itemCount,
  checkoutLink = '/checkout'
}) {
  const [couponInput, setCouponInput] = useState('');
  const [applying, setApplying] = useState(false);
  const [couponMsg, setCouponMsg] = useState(null);

  const freeShippingThreshold = 1499;
  const effectiveSubtotal = Math.max(0, subtotal - discount);
  const neededForFreeShipping = Math.max(0, freeShippingThreshold - effectiveSubtotal);

  const handleSubmitCoupon = async (e) => {
    e.preventDefault();
    if (!couponInput.trim() || !onApplyCoupon) return;
    setApplying(true);
    setCouponMsg(null);
    const res = await onApplyCoupon(couponInput.trim());
    setApplying(false);
    if (!res.success) {
      setCouponMsg({ type: 'error', text: res.message || 'Invalid coupon code.' });
    } else {
      setCouponInput('');
      setCouponMsg({ type: 'success', text: `Saved ${formatPrice(res.coupon.discountAmount)}!` });
      setTimeout(() => setCouponMsg(null), 3000);
    }
  };

  const handleQuickApply = async (code) => {
    if (!onApplyCoupon) return;
    setApplying(true);
    setCouponMsg(null);
    const res = await onApplyCoupon(code);
    setApplying(false);
    if (!res.success) {
      setCouponMsg({ type: 'error', text: res.message });
    } else {
      setCouponMsg({ type: 'success', text: `Saved ${formatPrice(res.coupon.discountAmount)}!` });
      setTimeout(() => setCouponMsg(null), 3000);
    }
  };

  return (
    <aside className="summary">
      <h2>Order Summary</h2>
      <div>
        <span>Subtotal ({itemCount} items)</span>
        <b>{formatPrice(subtotal)}</b>
      </div>

      {/* Coupon Application Box in Cart */}
      <div style={{ margin: '12px 0 16px', padding: '12px 14px', background: '#faf8f2', border: '1px dashed #d5cfc1', borderRadius: '8px' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '8px' }}>
          <span style={{ fontSize: '11px', fontWeight: 700, color: 'var(--navy, #1e2d4a)', letterSpacing: '0.04em', textTransform: 'uppercase', display: 'flex', alignItems: 'center', gap: '5px' }}>
            <Tag size={13} color="var(--bethany-ochre, #e5ad42)" /> Have a coupon code?
          </span>
        </div>

        {coupon ? (
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: '#f0fdf4', border: '1px solid #bbf7d0', padding: '8px 10px', borderRadius: '6px' }}>
            <div>
              <strong style={{ fontSize: '12px', color: '#166534', display: 'flex', alignItems: 'center', gap: '5px' }}>
                <Check size={14} /> {coupon.code}
              </strong>
              <span style={{ fontSize: '11px', color: '#15803d', display: 'block' }}>
                {coupon.description || '₹500 OFF Applied'}
              </span>
            </div>
            <button
              type="button"
              onClick={onRemoveCoupon}
              style={{ background: 'transparent', border: 'none', color: '#991b1b', cursor: 'pointer', padding: '4px' }}
              title="Remove coupon"
            >
              <X size={15} />
            </button>
          </div>
        ) : (
          <div>
            <form onSubmit={handleSubmitCoupon} style={{ display: 'flex', gap: '6px' }}>
              <input
                type="text"
                value={couponInput}
                onChange={(e) => setCouponInput(e.target.value.toUpperCase())}
                placeholder="MYSTERY4499"
                style={{
                  flex: 1,
                  height: '34px',
                  padding: '0 8px',
                  fontSize: '12px',
                  border: '1px solid #d5cfc1',
                  borderRadius: '4px',
                  background: '#fff',
                  textTransform: 'uppercase',
                  fontWeight: 600
                }}
              />
              <button
                type="submit"
                disabled={applying || !couponInput.trim()}
                style={{
                  background: 'var(--navy, #1e2d4a)',
                  color: '#fff',
                  border: 'none',
                  padding: '0 12px',
                  borderRadius: '4px',
                  fontSize: '11px',
                  fontWeight: 700,
                  cursor: 'pointer'
                }}
              >
                {applying ? '…' : 'APPLY'}
              </button>
            </form>

            {couponMsg && (
              <p style={{ margin: '5px 0 0', fontSize: '11px', color: couponMsg.type === 'error' ? '#dc2626' : '#166534' }}>
                {couponMsg.text}
              </p>
            )}

            <div style={{ marginTop: '8px', padding: '5px 8px', background: '#fff', borderRadius: '4px', border: '1px solid #eee', display: 'flex', alignItems: 'center', justifyContent: 'space-between', fontSize: '11px' }}>
              <span style={{ color: '#555', display: 'flex', alignItems: 'center', gap: '4px' }}>
                <Sparkles size={12} color="#e5ad42" /> Launch code: <strong>MYSTERY4499</strong>
              </span>
              <button
                type="button"
                onClick={() => handleQuickApply('MYSTERY4499')}
                disabled={applying}
                style={{ background: 'transparent', border: 'none', color: '#b45309', fontWeight: 700, fontSize: '10.5px', cursor: 'pointer', textDecoration: 'underline' }}
              >
                APPLY ₹500 OFF
              </button>
            </div>
          </div>
        )}
      </div>

      {discount > 0 && (
        <div style={{ color: '#166534' }}>
          <span>Coupon Discount ({coupon?.code})</span>
          <b>- {formatPrice(discount)}</b>
        </div>
      )}

      <div>
        <span>Estimated Delivery</span>
        <b>{shipping === 0 ? 'FREE' : formatPrice(shipping)}</b>
      </div>

      {neededForFreeShipping > 0 && (
        <div style={{ fontSize: '11px', color: '#a98761', margin: '4px 0' }}>
          Add {formatPrice(neededForFreeShipping)} more for complimentary shipping.
        </div>
      )}

      <div className="summary-total">
        <span>Total Amount</span>
        <b>{formatPrice(total)}</b>
      </div>

      {checkoutLink && (
        <Link className="button button-dark full" to={checkoutLink}>
          Proceed to Checkout <ArrowRight size={17} />
        </Link>
      )}
      <p style={{ marginTop: '12px', fontSize: '11px', color: 'var(--muted)' }}>
        Prices are inclusive of all applicable taxes.
      </p>
    </aside>
  );
}

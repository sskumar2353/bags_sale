import { useState } from 'react';
import { Tag, Check, X, Sparkles } from 'lucide-react';
import formatPrice from '../../utils/formatPrice';

export default function OrderSummary({
  items = [],
  subtotal = 0,
  discount = 0,
  coupon = null,
  shipping = 0,
  total = 0,
  onApplyCoupon,
  onRemoveCoupon
}) {
  const [couponInput, setCouponInput] = useState('');
  const [applying, setApplying] = useState(false);
  const [couponMsg, setCouponMsg] = useState(null);

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
      setCouponMsg({ type: 'success', text: `Saved ${formatPrice(res.coupon.discountAmount)} with ${res.coupon.code}!` });
      setTimeout(() => setCouponMsg(null), 3500);
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
      setCouponMsg({ type: 'success', text: `Saved ${formatPrice(res.coupon.discountAmount)} with ${res.coupon.code}!` });
      setTimeout(() => setCouponMsg(null), 3500);
    }
  };

  return (
    <aside className="summary">
      <h2>Your Order Summary</h2>

      <div style={{ maxHeight: '260px', overflowY: 'auto', marginBottom: '14px', borderBottom: '1px solid var(--line)', paddingBottom: '10px' }}>
        {items.map((x) => {
          const itemPrice = Number(x.price || 0);
          const itemQty = Number(x.quantity || 1);
          return (
            <div key={`${x.product_id || x.id}-${x.variant_id || 'base'}`} style={{ display: 'flex', justifyContent: 'space-between', margin: '8px 0', fontSize: '12px' }}>
              <div>
                <strong>{x.name}</strong> × {itemQty}
                {x.variant_name && <small style={{ display: 'block', color: 'var(--muted)' }}>{x.variant_name}</small>}
              </div>
              <b>{formatPrice(itemPrice * itemQty)}</b>
            </div>
          );
        })}
      </div>

      {/* Coupon Application Box */}
      <div style={{ margin: '14px 0 18px', padding: '12px 14px', background: '#faf8f2', border: '1px dashed #d5cfc1', borderRadius: '8px' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '8px' }}>
          <span style={{ fontSize: '11px', fontWeight: 700, color: 'var(--navy)', letterSpacing: '0.04em', textTransform: 'uppercase', display: 'flex', alignItems: 'center', gap: '5px' }}>
            <Tag size={13} color="var(--bethany-ochre, #e5ad42)" /> Have a coupon code?
          </span>
        </div>

        {coupon ? (
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: '#f0fdf4', border: '1px solid #bbf7d0', padding: '8px 10px', borderRadius: '6px' }}>
            <div>
              <strong style={{ fontSize: '12.5px', color: '#166534', display: 'flex', alignItems: 'center', gap: '5px' }}>
                <Check size={14} /> {coupon.code}
              </strong>
              <span style={{ fontSize: '11px', color: '#15803d', display: 'block' }}>
                {coupon.description || 'Discount Applied'}
              </span>
            </div>
            <button
              type="button"
              onClick={onRemoveCoupon}
              style={{ background: 'transparent', border: 'none', color: '#991b1b', fontSize: '12px', fontWeight: 600, cursor: 'pointer', padding: '4px' }}
              title="Remove coupon"
            >
              <X size={16} />
            </button>
          </div>
        ) : (
          <div>
            <form onSubmit={handleSubmitCoupon} style={{ display: 'flex', gap: '6px' }}>
              <input
                type="text"
                value={couponInput}
                onChange={(e) => setCouponInput(e.target.value.toUpperCase())}
                placeholder="Enter coupon (e.g. MYSTERY4499)"
                aria-label="Enter coupon code"
                style={{
                  flex: 1,
                  height: '36px',
                  padding: '0 10px',
                  fontSize: '12.5px',
                  border: '1px solid #d5cfc1',
                  borderRadius: '4px',
                  background: '#fff',
                  textTransform: 'uppercase',
                  fontWeight: 600,
                  letterSpacing: '0.5px'
                }}
              />
              <button
                type="submit"
                disabled={applying || !couponInput.trim()}
                style={{
                  background: 'var(--navy, #1e2d4a)',
                  color: '#fff',
                  border: 'none',
                  padding: '0 14px',
                  borderRadius: '4px',
                  fontSize: '11px',
                  fontWeight: 700,
                  cursor: 'pointer',
                  letterSpacing: '0.5px'
                }}
              >
                {applying ? '…' : 'APPLY'}
              </button>
            </form>

            {couponMsg && (
              <p style={{ margin: '6px 0 0', fontSize: '11px', color: couponMsg.type === 'error' ? '#dc2626' : '#166534' }}>
                {couponMsg.text}
              </p>
            )}

            {/* Quick 1-click launch code trigger */}
            <div style={{ marginTop: '8px', padding: '6px 8px', background: '#ffffff', borderRadius: '4px', border: '1px solid #eee', display: 'flex', alignItems: 'center', justifyContent: 'space-between', fontSize: '11px' }}>
              <span style={{ color: '#555', display: 'flex', alignItems: 'center', gap: '4px' }}>
                <Sparkles size={12} color="#e5ad42" /> Launch: <strong>MYSTERY4499</strong> (Save ₹500)
              </span>
              <button
                type="button"
                onClick={() => handleQuickApply('MYSTERY4499')}
                disabled={applying}
                style={{ background: 'transparent', border: 'none', color: '#b45309', fontWeight: 700, fontSize: '10.5px', cursor: 'pointer', textDecoration: 'underline' }}
              >
                APPLY
              </button>
            </div>
          </div>
        )}
      </div>

      <div>
        <span>Subtotal</span>
        <b>{formatPrice(subtotal)}</b>
      </div>

      {discount > 0 && (
        <div style={{ color: '#166534' }}>
          <span>Coupon Discount ({coupon?.code})</span>
          <b>- {formatPrice(discount)}</b>
        </div>
      )}

      {coupon?.hasMysteryGift && (
        <div style={{ color: '#b45309', fontSize: '11.5px', margin: '4px 0' }}>
          <span>🎁 Free Mystery Gift</span>
          <b>UNLOCKED</b>
        </div>
      )}

      <div>
        <span>Shipping & Handling</span>
        <b>{shipping === 0 ? 'FREE' : formatPrice(shipping)}</b>
      </div>

      <div className="summary-total">
        <span>Total Payable</span>
        <b>{formatPrice(total)}</b>
      </div>

      <p style={{ marginTop: '12px', fontSize: '11px', color: 'var(--muted)' }}>
        Zero surprise fees. Amount payable is verified and locked with 256-bit encryption.
      </p>
    </aside>
  );
}

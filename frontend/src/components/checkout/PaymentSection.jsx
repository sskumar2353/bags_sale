import { Check, Tag, Sparkles } from 'lucide-react';
import formatPrice from '../../utils/formatPrice';

export default function PaymentSection({
  paymentMethod = 'razorpay',
  onChangePaymentMethod,
  total = 0,
  discount = 0,
  coupon = null,
  onApplyCoupon,
  busy = false
}) {
  return (
    <div className="checkout-payment-section" style={{ marginTop: '24px' }}>
      <h2>Payment Method</h2>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px', margin: '14px 0' }}>
        <label
          className="payment-option"
          style={{
            border: paymentMethod === 'razorpay' ? '2px solid var(--navy, #1e2d4a)' : '1px solid var(--line)',
            borderRadius: '6px',
            padding: '14px',
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
            cursor: 'pointer',
            background: paymentMethod === 'razorpay' ? '#fcfbf8' : '#ffffff'
          }}
        >
          <input
            type="radio"
            name="payment"
            value="razorpay"
            checked={paymentMethod === 'razorpay'}
            onChange={(e) => onChangePaymentMethod(e.target.value)}
          />
          <div>
            <strong style={{ color: 'var(--navy, #1e2d4a)' }}>Razorpay Secure Checkout</strong>
            <span style={{ display: 'block', fontSize: '11px', color: 'var(--muted)' }}>
              Supports UPI (Google Pay, PhonePe, Paytm, QR), Credit/Debit Cards, Netbanking
            </span>
          </div>
        </label>
      </div>

      {/* Applied Coupon / Launch Offer Banner right before payment */}
      {coupon ? (
        <div
          style={{
            margin: '12px 0 16px',
            padding: '10px 14px',
            background: '#f0fdf4',
            border: '1px solid #bbf7d0',
            borderRadius: '6px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            fontSize: '12.5px',
            color: '#166534'
          }}
        >
          <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <Check size={15} /> <strong>{coupon.code}</strong> Applied: You save {formatPrice(discount)}!
          </span>
          <span style={{ fontSize: '11px', fontWeight: 700, color: '#15803d' }}>
            Amount to Pay: {formatPrice(total)}
          </span>
        </div>
      ) : onApplyCoupon ? (
        <div
          style={{
            margin: '12px 0 16px',
            padding: '10px 14px',
            background: '#faf8f2',
            border: '1px dashed #d5cfc1',
            borderRadius: '6px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            fontSize: '12px'
          }}
        >
          <span style={{ color: '#444', display: 'flex', alignItems: 'center', gap: '6px' }}>
            <Sparkles size={14} color="#e5ad42" /> Launch coupon <strong>MYSTERY4499</strong> available!
          </span>
          <button
            type="button"
            onClick={() => onApplyCoupon('MYSTERY4499')}
            style={{
              background: 'var(--navy, #1e2d4a)',
              color: '#ffffff',
              border: 'none',
              padding: '4px 10px',
              borderRadius: '4px',
              fontSize: '11px',
              fontWeight: 700,
              cursor: 'pointer'
            }}
          >
            Apply ₹500 Off
          </button>
        </div>
      ) : null}

      <p className="payment-note" style={{ fontSize: '11px', color: 'var(--muted)', margin: '14px 0' }}>
        Payments are secured via 256-bit SSL encryption. Official receipt and order details will be confirmed upon successful transaction.
      </p>

      <button
        type="submit"
        className="button button-dark full"
        disabled={busy}
        style={{ minHeight: '52px', fontWeight: 600, fontSize: '15px' }}
      >
        {busy ? 'Connecting to Razorpay…' : `Pay Securely with Razorpay · ${formatPrice(total)}`}
      </button>
    </div>
  );
}

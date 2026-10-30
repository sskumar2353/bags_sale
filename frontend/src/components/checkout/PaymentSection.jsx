import formatPrice from '../../utils/formatPrice';

export default function PaymentSection({
  paymentMethod = 'razorpay',
  onChangePaymentMethod,
  total = 0,
  busy = false
}) {
  return (
    <div className="checkout-payment-section" style={{ marginTop: '24px' }}>
      <h2>Payment Method</h2>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px', margin: '14px 0' }}>
        <label
          className="payment-option"
          style={{
            border: paymentMethod === 'razorpay' ? '2px solid var(--ink)' : '1px solid var(--line)',
            borderRadius: '4px',
            padding: '14px',
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
            cursor: 'pointer'
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
            <strong>Razorpay Secure Checkout</strong>
            <span style={{ display: 'block', fontSize: '11px', color: 'var(--muted)' }}>
              Supports UPI (Google Pay, PhonePe, Paytm), Credit/Debit Cards, Netbanking
            </span>
          </div>
        </label>

        <label
          className="payment-option"
          style={{
            border: paymentMethod === 'cod' ? '2px solid var(--ink)' : '1px solid var(--line)',
            borderRadius: '4px',
            padding: '14px',
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
            cursor: 'pointer'
          }}
        >
          <input
            type="radio"
            name="payment"
            value="cod"
            checked={paymentMethod === 'cod'}
            onChange={(e) => onChangePaymentMethod(e.target.value)}
          />
          <div>
            <strong>Cash on Delivery (Pay upon delivery)</strong>
            <span style={{ display: 'block', fontSize: '11px', color: 'var(--muted)' }}>
              Pay via cash or UPI directly when your bag is delivered
            </span>
          </div>
        </label>
      </div>

      <p className="payment-note" style={{ fontSize: '11px', color: 'var(--muted)', margin: '14px 0' }}>
        Payments are secured via 256-bit encryption. Orders are officially confirmed upon server-side cryptographic signature verification.
      </p>

      <button
        type="submit"
        className="button button-dark full"
        disabled={busy}
        style={{ minHeight: '52px' }}
      >
        {busy ? 'Securing your order…' : `Pay Securely · ${formatPrice(total)}`}
      </button>
    </div>
  );
}

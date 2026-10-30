import { useSearchParams, Link } from 'react-router-dom';
import { CheckCircle2, ArrowRight } from 'lucide-react';

export default function OrderSuccess() {
  const [params] = useSearchParams();
  const orderNumber = params.get('orderNumber') || '';

  return (
    <main className="page" style={{ textAlign: 'center', padding: '60px 20px' }}>
      <div style={{ maxWidth: '520px', margin: '0 auto' }}>
        <CheckCircle2 size={54} color="#2e7d32" style={{ margin: '0 auto 20px' }} />
        <span className="eyebrow">ORDER CONFIRMED</span>
        <h1 style={{ margin: '10px 0 16px', fontSize: '32px' }}>
          Thank you for your order.
        </h1>
        {orderNumber && (
          <p style={{ fontSize: '15px', fontWeight: '600', color: 'var(--ink)' }}>
            Order ID: {orderNumber}
          </p>
        )}
        <p style={{ color: 'var(--muted)', fontSize: '14px', lineHeight: '1.6', margin: '14px 0 28px' }}>
          We've received your order and are preparing it with care. You can track its progress anytime from your account.
        </p>

        <div style={{ display: 'flex', gap: '14px', justifyContent: 'center' }}>
          <Link to="/orders" className="button button-dark">
            View My Orders <ArrowRight size={16} />
          </Link>
          <Link to="/shop" className="button button-outline">
            Continue Shopping
          </Link>
        </div>
      </div>
    </main>
  );
}

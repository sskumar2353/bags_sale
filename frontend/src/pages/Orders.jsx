import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import orderService from '../services/orderService';
import formatPrice from '../utils/formatPrice';
import Loading from '../components/common/Loading';
import EmptyState from '../components/common/EmptyState';
import { ShoppingBag } from 'lucide-react';

export default function Orders() {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchOrders() {
      try {
        setLoading(true);
        setError(null);
        const data = await orderService.getOrders();
        setOrders(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    fetchOrders();
  }, []);

  if (loading) {
    return <Loading message="Loading your orders…" />;
  }

  return (
    <main className="page">
      <div className="listing-heading" style={{ marginTop: '24px' }}>
        <div>
          <span className="eyebrow">YOUR HISTORY</span>
          <h1>My Orders</h1>
        </div>
      </div>

      {error ? (
        <div className="empty">
          <p>{error}</p>
        </div>
      ) : orders.length === 0 ? (
        <EmptyState
          icon={ShoppingBag}
          title="No orders yet"
          message="Once you place an order, you'll be able to track delivery here."
          actionText="Start Shopping"
          actionTo="/shop"
        />
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '20px', maxWidth: '820px' }}>
          {orders.map((o) => (
            <div
              key={o.id}
              style={{
                border: '1px solid var(--line)',
                borderRadius: '6px',
                padding: '20px',
                background: '#fff'
              }}
            >
              <div
                style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'flex-start',
                  borderBottom: '1px solid var(--line)',
                  paddingBottom: '14px',
                  marginBottom: '14px',
                  flexWrap: 'wrap',
                  gap: '10px'
                }}
              >
                <div>
                  <strong style={{ fontSize: '15px' }}>{o.order_number}</strong>
                  <div style={{ fontSize: '12px', color: 'var(--muted)', marginTop: '4px' }}>
                    Placed on{' '}
                    {new Date(o.created_at).toLocaleDateString('en-IN', {
                      day: 'numeric',
                      month: 'long',
                      year: 'numeric'
                    })}
                  </div>
                </div>

                <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
                  <span
                    style={{
                      padding: '4px 10px',
                      borderRadius: '12px',
                      fontSize: '11px',
                      fontWeight: '600',
                      textTransform: 'uppercase',
                      background: o.payment_status === 'paid' ? '#e8f5e9' : '#fff3e0',
                      color: o.payment_status === 'paid' ? '#2e7d32' : '#e65100'
                    }}
                  >
                    {o.payment_status}
                  </span>
                  <span
                    style={{
                      padding: '4px 10px',
                      borderRadius: '12px',
                      fontSize: '11px',
                      fontWeight: '600',
                      textTransform: 'uppercase',
                      background: '#f5f5f5',
                      color: 'var(--ink)'
                    }}
                  >
                    {o.status}
                  </span>
                </div>
              </div>

              {o.items && o.items.length > 0 && (
                <div style={{ marginBottom: '16px' }}>
                  {o.items.map((item, idx) => (
                    <div
                      key={idx}
                      style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        padding: '6px 0',
                        fontSize: '13px'
                      }}
                    >
                      <span>
                        {item.product_name} {item.variant_name ? `(${item.variant_name})` : ''} × {item.quantity}
                      </span>
                      <b>{formatPrice(item.total_price)}</b>
                    </div>
                  ))}
                </div>
              )}

              <div
                style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                  paddingTop: '12px',
                  borderTop: '1px solid var(--line)',
                  fontSize: '14px'
                }}
              >
                <span style={{ color: 'var(--muted)', fontSize: '12px' }}>
                  Shipping to: {o.shipping_city}, {o.shipping_state}
                </span>
                <div>
                  Total: <strong>{formatPrice(o.total_amount)}</strong>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </main>
  );
}

import formatPrice from '../../utils/formatPrice';
import { ORDER_STATUSES } from '../../utils/constants';

export default function OrderTable({ orders = [], onUpdateStatus }) {
  if (!orders.length) {
    return <p style={{ padding: '24px 0', color: 'var(--muted)' }}>No orders placed yet.</p>;
  }

  return (
    <div style={{ overflowX: 'auto' }}>
      <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '13px' }}>
        <thead>
          <tr style={{ borderBottom: '2px solid var(--line)', background: 'var(--soft)' }}>
            <th style={{ padding: '12px' }}>Order ID</th>
            <th style={{ padding: '12px' }}>Customer / Contact</th>
            <th style={{ padding: '12px' }}>City, State</th>
            <th style={{ padding: '12px' }}>Total Amount</th>
            <th style={{ padding: '12px' }}>Payment</th>
            <th style={{ padding: '12px' }}>Status</th>
            <th style={{ padding: '12px' }}>Date</th>
            <th style={{ padding: '12px' }}>Update Status</th>
          </tr>
        </thead>
        <tbody>
          {orders.map((o) => (
            <tr key={o.id} style={{ borderBottom: '1px solid var(--line)' }}>
              <td style={{ padding: '12px' }}>
                <strong>{o.order_number}</strong>
              </td>
              <td style={{ padding: '12px' }}>
                <div>{o.shipping_name || o.customer_name || 'Customer'}</div>
                <small style={{ color: 'var(--muted)' }}>{o.shipping_phone}</small>
              </td>
              <td style={{ padding: '12px' }}>
                {o.shipping_city}, {o.shipping_state}
              </td>
              <td style={{ padding: '12px' }}>
                <strong>{formatPrice(o.total_amount)}</strong>
              </td>
              <td style={{ padding: '12px' }}>
                <span
                  style={{
                    padding: '3px 8px',
                    borderRadius: '12px',
                    fontSize: '11px',
                    fontWeight: '600',
                    background: o.payment_status === 'paid' ? '#e8f5e9' : '#fff3e0',
                    color: o.payment_status === 'paid' ? '#2e7d32' : '#e65100'
                  }}
                >
                  {o.payment_status?.toUpperCase()}
                </span>
              </td>
              <td style={{ padding: '12px' }}>
                <span
                  style={{
                    padding: '3px 8px',
                    borderRadius: '12px',
                    fontSize: '11px',
                    fontWeight: '600',
                    background: '#f0f0f0',
                    color: '#333'
                  }}
                >
                  {o.status?.toUpperCase()}
                </span>
              </td>
              <td style={{ padding: '12px', color: 'var(--muted)' }}>
                {new Date(o.created_at).toLocaleDateString('en-IN', {
                  day: 'numeric',
                  month: 'short',
                  year: 'numeric'
                })}
              </td>
              <td style={{ padding: '12px' }}>
                <select
                  value={o.status}
                  onChange={(e) => onUpdateStatus(o.id, e.target.value)}
                  style={{ fontSize: '12px', padding: '4px 8px', borderRadius: '4px' }}
                >
                  {ORDER_STATUSES.map((st) => (
                    <option key={st} value={st}>
                      {st.charAt(0).toUpperCase() + st.slice(1)}
                    </option>
                  ))}
                </select>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

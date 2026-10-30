import { useState, useEffect } from 'react';
import orderService from '../../services/orderService';
import OrderTable from '../../components/admin/OrderTable';
import Loading from '../../components/common/Loading';

export default function AdminOrders() {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filter, setFilter] = useState('');

  useEffect(() => {
    fetchOrders();
  }, []);

  const fetchOrders = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await orderService.adminGetOrders();
      setOrders(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleUpdateStatus = async (orderId, newStatus) => {
    try {
      await orderService.adminUpdateOrderStatus(orderId, newStatus);
      setOrders((prev) =>
        prev.map((o) => (o.id === orderId ? { ...o, status: newStatus } : o))
      );
    } catch (err) {
      alert(err.message);
    }
  };

  const filteredOrders = filter
    ? orders.filter((o) => o.status.toLowerCase() === filter.toLowerCase())
    : orders;

  if (loading) return <Loading message="Loading customer orders…" />;

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '14px' }}>
        <div>
          <span className="eyebrow">FULFILLMENT</span>
          <h1 style={{ fontSize: '26px', margin: '4px 0' }}>Customer Orders ({filteredOrders.length})</h1>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
          <span style={{ fontSize: '13px', color: 'var(--muted)' }}>Filter by status:</span>
          <select
            value={filter}
            onChange={(e) => setFilter(e.target.value)}
            style={{ padding: '6px 12px', borderRadius: '4px' }}
          >
            <option value="">All Orders</option>
            <option value="pending">Pending</option>
            <option value="confirmed">Confirmed</option>
            <option value="processing">Processing</option>
            <option value="shipped">Shipped</option>
            <option value="delivered">Delivered</option>
            <option value="cancelled">Cancelled</option>
          </select>
        </div>
      </div>

      {error && <p style={{ color: '#d32f2f' }}>{error}</p>}

      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', padding: '20px' }}>
        <OrderTable orders={filteredOrders} onUpdateStatus={handleUpdateStatus} />
      </div>
    </div>
  );
}

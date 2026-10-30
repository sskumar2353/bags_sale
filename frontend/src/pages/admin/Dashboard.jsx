import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import DashboardCards from '../../components/admin/DashboardCards';
import OrderTable from '../../components/admin/OrderTable';
import Loading from '../../components/common/Loading';
import productService from '../../services/productService';
import orderService from '../../services/orderService';
import { Plus, ArrowRight } from 'lucide-react';

export default function Dashboard() {
  const [stats, setStats] = useState({});
  const [recentOrders, setRecentOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadDashboard() {
      try {
        setLoading(true);
        setError(null);
        const [statsData, ordersData] = await Promise.all([
          productService.adminGetDashboardStats(),
          orderService.adminGetOrders()
        ]);
        setStats(statsData);
        setRecentOrders(ordersData.slice(0, 5));
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    loadDashboard();
  }, []);

  const handleUpdateOrderStatus = async (orderId, status) => {
    try {
      await orderService.adminUpdateOrderStatus(orderId, status);
      setRecentOrders((prev) =>
        prev.map((o) => (o.id === orderId ? { ...o, status } : o))
      );
    } catch (err) {
      alert(err.message);
    }
  };

  if (loading) return <Loading message="Loading executive metrics…" />;

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <span className="eyebrow">OVERVIEW</span>
          <h1 style={{ fontSize: '26px', margin: '4px 0' }}>Dashboard</h1>
        </div>
        <Link to="/admin/products/new" className="button button-dark" style={{ minHeight: '40px' }}>
          <Plus size={16} /> New Product
        </Link>
      </div>

      {error && <p style={{ color: '#d32f2f', marginBottom: '16px' }}>{error}</p>}

      <DashboardCards stats={stats} />

      <section style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', padding: '24px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
          <h3>Recent Orders</h3>
          <Link to="/admin/orders" className="text-link" style={{ fontSize: '12px' }}>
            View all orders <ArrowRight size={14} />
          </Link>
        </div>
        <OrderTable orders={recentOrders} onUpdateStatus={handleUpdateOrderStatus} />
      </section>
    </div>
  );
}

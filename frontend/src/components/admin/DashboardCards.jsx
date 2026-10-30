import formatPrice from '../../utils/formatPrice';
import { Package, ShoppingCart, Users, DollarSign, Clock, AlertTriangle } from 'lucide-react';

export default function DashboardCards({ stats = {} }) {
  const cards = [
    {
      title: 'Total Revenue',
      value: formatPrice(stats.totalRevenue || 0),
      icon: DollarSign,
      color: '#2e7d32'
    },
    {
      title: 'Total Orders',
      value: stats.totalOrders || 0,
      icon: ShoppingCart,
      color: '#1565c0'
    },
    {
      title: 'Pending Orders',
      value: stats.pendingOrders || 0,
      icon: Clock,
      color: '#ef6c00'
    },
    {
      title: 'Total Products',
      value: stats.totalProducts || 0,
      icon: Package,
      color: '#6a1b9a'
    },
    {
      title: 'Low Stock Alerts',
      value: stats.lowStockCount || 0,
      icon: AlertTriangle,
      color: '#c62828'
    },
    {
      title: 'Total Customers',
      value: stats.totalUsers || 0,
      icon: Users,
      color: '#00838f'
    }
  ];

  return (
    <div
      className="dashboard-cards"
      style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '16px',
        marginBottom: '28px'
      }}
    >
      {cards.map((c) => {
        const Icon = c.icon;
        return (
          <div
            key={c.title}
            style={{
              padding: '18px',
              background: '#fff',
              border: '1px solid var(--line)',
              borderRadius: '6px',
              boxShadow: '0 2px 6px rgba(0,0,0,0.03)'
            }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span style={{ fontSize: '11px', color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                {c.title}
              </span>
              <Icon size={18} color={c.color} />
            </div>
            <div style={{ fontSize: '22px', fontWeight: '700', marginTop: '10px' }}>
              {c.value}
            </div>
          </div>
        );
      })}
    </div>
  );
}

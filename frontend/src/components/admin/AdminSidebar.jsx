import { NavLink, useNavigate } from 'react-router-dom';
import { LayoutDashboard, Package, ShoppingBag, FolderTree, LogOut, Users } from 'lucide-react';
import useAuth from '../../hooks/useAuth';

export default function AdminSidebar() {
  const { logout, user } = useAuth();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await logout();
    navigate('/admin/login', { replace: true });
  };

  const links = [
    { to: '/admin/dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { to: '/admin/products', label: 'Products', icon: Package },
    { to: '/admin/categories', label: 'Categories', icon: FolderTree },
    { to: '/admin/orders', label: 'Orders', icon: ShoppingBag },
    { to: '/admin/users', label: 'Users', icon: Users }
  ];

  return (
    <aside
      className="admin-sidebar"
      style={{
        width: '240px',
        background: 'var(--soft)',
        borderRight: '1px solid var(--line)',
        padding: '24px 16px',
        display: 'flex',
        flexDirection: 'column',
        gap: '8px',
        minHeight: '80vh'
      }}
    >
      <div style={{ marginBottom: '20px', paddingLeft: '8px' }}>
        <span className="eyebrow">ADMIN CONSOLE</span>
        <h3 style={{ margin: '4px 0', fontSize: '18px' }}>Daily Objects</h3>
        <span style={{ fontSize: '11px', color: '#777' }}>Logged in as {user?.email || 'Admin'}</span>
      </div>

      {links.map((link) => {
        const Icon = link.icon;
        return (
          <NavLink
            key={link.to}
            to={link.to}
            style={({ isActive }) => ({
              display: 'flex',
              alignItems: 'center',
              gap: '12px',
              padding: '10px 12px',
              borderRadius: '4px',
              fontSize: '13px',
              fontWeight: isActive ? '600' : '400',
              background: isActive ? 'var(--ink)' : 'transparent',
              color: isActive ? '#fff' : 'var(--ink)',
              textDecoration: 'none'
            })}
          >
            <Icon size={18} />
            {link.label}
          </NavLink>
        );
      })}

      <div style={{ marginTop: 'auto', paddingTop: '20px', borderTop: '1px solid var(--line)' }}>
        <button
          onClick={handleLogout}
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '8px',
            fontSize: '13px',
            color: '#b00020',
            background: 'none',
            border: 'none',
            cursor: 'pointer',
            padding: '8px',
            width: '100%',
            fontWeight: '600'
          }}
        >
          <LogOut size={16} /> Sign Out (Admin)
        </button>
      </div>
    </aside>
  );
}

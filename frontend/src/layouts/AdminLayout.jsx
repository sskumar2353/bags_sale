import { Outlet, Navigate } from 'react-router-dom';
import useAuth from '../hooks/useAuth';
import AdminSidebar from '../components/admin/AdminSidebar';
import Loading from '../components/common/Loading';

export default function AdminLayout() {
  const { user, loading, isAdmin } = useAuth();

  if (loading) {
    return <Loading message="Checking authorization…" />;
  }

  if (!user || !isAdmin) {
    return <Navigate to="/admin/login" replace />;
  }

  return (
    <div className="admin-wrapper" style={{ display: 'flex', minHeight: '100vh', background: '#faf9f6' }}>
      <AdminSidebar />
      <main className="admin-main" style={{ flex: 1, padding: '32px 40px', overflowX: 'auto' }}>
        <Outlet />
      </main>
    </div>
  );
}

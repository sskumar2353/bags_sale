import { Outlet } from 'react-router-dom';
import AccessibilityHeader from '../components/common/AccessibilityHeader';
import AnnouncementBar from '../components/common/AnnouncementBar';
import Navbar from '../components/common/Navbar';
import Footer from '../components/common/Footer';
import useCart from '../hooks/useCart';

export default function MainLayout() {
  const { toastMessage } = useCart();

  return (
    <div className="site-wrapper">
      <AccessibilityHeader />
      <AnnouncementBar />
      <Navbar />

      {/* Global Toast Notification */}
      {toastMessage && (
        <div
          className="global-toast"
          style={{
            position: 'fixed',
            bottom: '24px',
            right: '24px',
            background: 'var(--ink)',
            color: '#fff',
            padding: '14px 22px',
            borderRadius: '4px',
            fontSize: '13px',
            fontWeight: '500',
            boxShadow: '0 8px 24px rgba(0,0,0,0.18)',
            zIndex: 9999,
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
            animation: 'fadeIn 0.25s ease'
          }}
        >
          {toastMessage}
        </div>
      )}

      <main className="main-content" id="main-content" tabIndex="-1">
        <Outlet />
      </main>

      <Footer />
    </div>
  );
}

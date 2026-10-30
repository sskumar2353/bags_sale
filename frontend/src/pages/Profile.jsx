import { useState, useEffect } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import useAuth from '../hooks/useAuth';
import authService from '../services/authService';
import orderService from '../services/orderService';
import formatPrice from '../utils/formatPrice';
import Loading from '../components/common/Loading';
import EmptyState from '../components/common/EmptyState';
import {
  ShoppingBag,
  MapPin,
  Heart,
  User,
  LogOut,
  Package,
  Plus,
  Trash2,
  ChevronRight,
  Shield,
  Truck,
  CheckCircle2,
  Clock
} from 'lucide-react';

export default function Profile() {
  const { user, loading, logout, isAdmin } = useAuth();
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  // Tab state: 'orders' | 'addresses' | 'details'
  const activeTab = searchParams.get('tab') || 'orders';
  const orderTypeFilter = searchParams.get('f') || 'type~online';

  const [orders, setOrders] = useState([]);
  const [ordersLoading, setOrdersLoading] = useState(false);
  const [addresses, setAddresses] = useState([]);
  const [showAddAddress, setShowAddAddress] = useState(false);
  const [newAddr, setNewAddr] = useState({
    full_name: '',
    phone: '',
    address_line1: '',
    address_line2: '',
    city: '',
    state: '',
    postal_code: '',
    country: 'India',
    address_type: 'home'
  });
  const [savingAddr, setSavingAddr] = useState(false);
  const [addrError, setAddrError] = useState(null);

  useEffect(() => {
    if (user) {
      if (activeTab === 'orders') {
        setOrdersLoading(true);
        orderService
          .getOrders()
          .then(setOrders)
          .catch((err) => console.warn('Could not fetch orders', err))
          .finally(() => setOrdersLoading(false));
      } else if (activeTab === 'addresses') {
        authService.getAddresses().then(setAddresses).catch(() => {});
      }
    }
  }, [user, activeTab]);

  if (loading) {
    return <Loading message="Loading your account portal…" />;
  }

  if (!user) {
    return (
      <main className="page auth-page" style={{ paddingTop: '40px' }}>
        <div style={{ textAlign: 'center', maxWidth: '440px', margin: '0 auto' }}>
          <ShoppingBag size={42} style={{ margin: '0 auto 16px', color: '#121212' }} />
          <span className="eyebrow">USER ACCOUNT PORTAL</span>
          <h1 style={{ fontSize: '28px', margin: '8px 0 12px' }}>Sign in to continue</h1>
          <p style={{ color: 'var(--ink-muted)', marginBottom: '24px' }}>
            View your order history, live track parcels, and manage saved delivery addresses.
          </p>
          <Link to="/login" className="button button-dark full">
            Sign In to Daily Objects
          </Link>
        </div>
      </main>
    );
  }

  const handleTabChange = (tabName, filterQuery = '') => {
    const next = new URLSearchParams();
    next.set('tab', tabName);
    if (filterQuery) next.set('f', filterQuery);
    setSearchParams(next);
  };

  const handleLogout = async () => {
    await logout();
    navigate('/', { replace: true });
  };

  const handleCreateAddress = async (e) => {
    e.preventDefault();
    setSavingAddr(true);
    setAddrError(null);
    try {
      const added = await authService.addAddress(newAddr);
      setAddresses((prev) => [...prev, added]);
      setShowAddAddress(false);
      setNewAddr({
        full_name: '',
        phone: '',
        address_line1: '',
        address_line2: '',
        city: '',
        state: '',
        postal_code: '',
        country: 'India',
        address_type: 'home'
      });
    } catch (err) {
      setAddrError(err.message);
    } finally {
      setSavingAddr(false);
    }
  };

  const handleDeleteAddress = async (id) => {
    if (!window.confirm('Are you sure you want to delete this address?')) return;
    try {
      await authService.deleteAddress(id);
      setAddresses((prev) => prev.filter((a) => a.id !== id));
    } catch (err) {
      alert(err.message);
    }
  };

  const initials = `${user.first_name?.[0] || 'U'}${user.last_name?.[0] || ''}`.toUpperCase();

  return (
    <main className="page uap-page" style={{ maxWidth: '1240px', margin: '0 auto', padding: '24px var(--space) 64px' }}>
      <div className="uap-layout" style={{ display: 'grid', gridTemplateColumns: '280px 1fr', gap: '32px', alignItems: 'start' }}>
        {/* Left Navigation Sidebar */}
        <aside
          className="uap-sidebar"
          style={{
            background: '#ffffff',
            border: '1px solid #ebebeb',
            borderRadius: '8px',
            padding: '24px 18px',
            boxShadow: '0 2px 8px rgba(0,0,0,0.03)'
          }}
        >
          {/* User Profile Header */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '14px', paddingBottom: '20px', borderBottom: '1px solid #f0f0f0', marginBottom: '16px' }}>
            <div
              style={{
                width: '48px',
                height: '48px',
                borderRadius: '50%',
                background: '#121212',
                color: '#ffffff',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '18px',
                fontWeight: '800',
                letterSpacing: '0.04em'
              }}
            >
              {initials}
            </div>
            <div style={{ minWidth: 0, flex: 1 }}>
              <h2 style={{ fontSize: '16px', fontWeight: '800', margin: 0, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                {user.first_name} {user.last_name || ''}
              </h2>
              <span style={{ fontSize: '12px', color: '#777', display: 'block', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                {user.email}
              </span>
            </div>
          </div>

          {/* Navigation Links */}
          <nav style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
            <button
              onClick={() => handleTabChange('orders', 'type~online')}
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '12px 14px',
                borderRadius: '6px',
                fontSize: '13.5px',
                fontWeight: activeTab === 'orders' ? '700' : '500',
                background: activeTab === 'orders' ? '#121212' : 'transparent',
                color: activeTab === 'orders' ? '#ffffff' : '#333333',
                border: 'none',
                cursor: 'pointer',
                textAlign: 'left',
                transition: 'all 0.2s ease'
              }}
            >
              <span style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <Package size={18} /> My Orders
              </span>
              <ChevronRight size={16} style={{ opacity: activeTab === 'orders' ? 1 : 0.4 }} />
            </button>

            <button
              onClick={() => handleTabChange('addresses')}
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '12px 14px',
                borderRadius: '6px',
                fontSize: '13.5px',
                fontWeight: activeTab === 'addresses' ? '700' : '500',
                background: activeTab === 'addresses' ? '#121212' : 'transparent',
                color: activeTab === 'addresses' ? '#ffffff' : '#333333',
                border: 'none',
                cursor: 'pointer',
                textAlign: 'left',
                transition: 'all 0.2s ease'
              }}
            >
              <span style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <MapPin size={18} /> My Addresses
              </span>
              <ChevronRight size={16} style={{ opacity: activeTab === 'addresses' ? 1 : 0.4 }} />
            </button>

            <Link
              to="/wishlist"
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '12px 14px',
                borderRadius: '6px',
                fontSize: '13.5px',
                fontWeight: '500',
                color: '#333333',
                textDecoration: 'none',
                transition: 'all 0.2s ease'
              }}
            >
              <span style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <Heart size={18} /> Wishlist
              </span>
              <ChevronRight size={16} style={{ opacity: 0.4 }} />
            </Link>

            <button
              onClick={() => handleTabChange('details')}
              style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                padding: '12px 14px',
                borderRadius: '6px',
                fontSize: '13.5px',
                fontWeight: activeTab === 'details' ? '700' : '500',
                background: activeTab === 'details' ? '#121212' : 'transparent',
                color: activeTab === 'details' ? '#ffffff' : '#333333',
                border: 'none',
                cursor: 'pointer',
                textAlign: 'left',
                transition: 'all 0.2s ease'
              }}
            >
              <span style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <User size={18} /> Profile Details
              </span>
              <ChevronRight size={16} style={{ opacity: activeTab === 'details' ? 1 : 0.4 }} />
            </button>

            {isAdmin && (
              <Link
                to="/admin/dashboard"
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '10px',
                  padding: '12px 14px',
                  borderRadius: '6px',
                  fontSize: '13px',
                  fontWeight: '700',
                  color: '#a98761',
                  textDecoration: 'none',
                  marginTop: '10px',
                  borderTop: '1px solid #f0f0f0'
                }}
              >
                <Shield size={16} /> Admin Portal
              </Link>
            )}

            <button
              onClick={handleLogout}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '10px',
                padding: '12px 14px',
                borderRadius: '6px',
                fontSize: '13px',
                fontWeight: '600',
                color: '#b00020',
                background: 'transparent',
                border: 'none',
                cursor: 'pointer',
                marginTop: '12px',
                borderTop: '1px solid #f0f0f0'
              }}
            >
              <LogOut size={16} /> Sign Out
            </button>
          </nav>
        </aside>

        {/* Right Content Panel */}
        <section className="uap-content">
          {/* TAB 1: ORDERS (DailyObjects blueprint: /uap/olp?f=type~online) */}
          {activeTab === 'orders' && (
            <div>
              {/* Header with Sub-tabs */}
              <div
                style={{
                  background: '#ffffff',
                  border: '1px solid #ebebeb',
                  borderRadius: '8px',
                  padding: '20px 24px',
                  marginBottom: '20px',
                  boxShadow: '0 2px 8px rgba(0,0,0,0.03)'
                }}
              >
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '12px' }}>
                  <div>
                    <span className="eyebrow">ORDER HISTORY</span>
                    <h1 style={{ fontSize: '22px', fontWeight: '800', margin: '2px 0 0' }}>My Orders</h1>
                  </div>

                  {/* Sub-tabs: Online Orders vs Store Orders matching DailyObjects */}
                  <div style={{ display: 'flex', gap: '8px', background: '#f5f5f5', padding: '4px', borderRadius: '6px' }}>
                    <button
                      onClick={() => handleTabChange('orders', 'type~online')}
                      style={{
                        padding: '6px 14px',
                        fontSize: '12px',
                        fontWeight: '700',
                        borderRadius: '4px',
                        border: 'none',
                        cursor: 'pointer',
                        background: orderTypeFilter.includes('online') ? '#ffffff' : 'transparent',
                        color: orderTypeFilter.includes('online') ? '#121212' : '#666666',
                        boxShadow: orderTypeFilter.includes('online') ? '0 1px 4px rgba(0,0,0,0.08)' : 'none'
                      }}
                    >
                      ONLINE ORDERS
                    </button>
                    <button
                      onClick={() => handleTabChange('orders', 'type~store')}
                      style={{
                        padding: '6px 14px',
                        fontSize: '12px',
                        fontWeight: '700',
                        borderRadius: '4px',
                        border: 'none',
                        cursor: 'pointer',
                        background: orderTypeFilter.includes('store') ? '#ffffff' : 'transparent',
                        color: orderTypeFilter.includes('store') ? '#121212' : '#666666',
                        boxShadow: orderTypeFilter.includes('store') ? '0 1px 4px rgba(0,0,0,0.08)' : 'none'
                      }}
                    >
                      STORE ORDERS
                    </button>
                  </div>
                </div>
              </div>

              {/* Order List */}
              {ordersLoading ? (
                <Loading message="Fetching your orders…" />
              ) : orders.length === 0 ? (
                <div
                  style={{
                    background: '#ffffff',
                    border: '1px solid #ebebeb',
                    borderRadius: '8px',
                    padding: '64px 24px',
                    textAlign: 'center'
                  }}
                >
                  <Package size={48} style={{ margin: '0 auto 16px', color: '#999' }} />
                  <h3 style={{ fontSize: '18px', fontWeight: '700', margin: '0 0 6px' }}>
                    {orderTypeFilter.includes('store') ? 'No store orders found' : 'No online orders yet'}
                  </h3>
                  <p style={{ color: 'var(--ink-muted)', fontSize: '13.5px', maxWidth: '400px', margin: '0 auto 24px' }}>
                    Explore our handcrafted collection of backpacks, totes, and everyday carry pieces.
                  </p>
                  <Link to="/shop" className="button button-dark">
                    Start Shopping
                  </Link>
                </div>
              ) : (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                  {orders.map((order) => {
                    const statusColor =
                      order.order_status === 'delivered'
                        ? '#2db58e'
                        : order.order_status === 'shipped'
                        ? '#0070f3'
                        : '#e66b55';

                    return (
                      <div
                        key={order.id}
                        style={{
                          background: '#ffffff',
                          border: '1px solid #ebebeb',
                          borderRadius: '8px',
                          overflow: 'hidden',
                          boxShadow: '0 2px 8px rgba(0,0,0,0.03)'
                        }}
                      >
                        {/* Order Header */}
                        <div
                          style={{
                            padding: '16px 20px',
                            background: '#faf9f6',
                            borderBottom: '1px solid #f0f0f0',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            flexWrap: 'wrap',
                            gap: '12px'
                          }}
                        >
                          <div>
                            <span style={{ fontSize: '11px', fontWeight: '700', letterSpacing: '0.06em', color: '#777', textTransform: 'uppercase' }}>
                              ORDER ID
                            </span>
                            <div style={{ fontSize: '15px', fontWeight: '800', color: '#121212' }}>{order.order_number}</div>
                          </div>

                          <div style={{ fontSize: '12.5px', color: '#666' }}>
                            Placed on {new Date(order.created_at).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' })}
                          </div>

                          <div>
                            <span
                              style={{
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '6px',
                                padding: '4px 10px',
                                borderRadius: '20px',
                                fontSize: '11.5px',
                                fontWeight: '700',
                                textTransform: 'uppercase',
                                letterSpacing: '0.04em',
                                background: `${statusColor}18`,
                                color: statusColor
                              }}
                            >
                              <CheckCircle2 size={13} /> {order.order_status}
                            </span>
                          </div>

                          <div style={{ textAlign: 'right' }}>
                            <span style={{ fontSize: '11px', color: '#777', display: 'block' }}>TOTAL</span>
                            <strong style={{ fontSize: '15px', color: '#121212' }}>{formatPrice(order.total_amount)}</strong>
                          </div>
                        </div>

                        {/* Order Items */}
                        <div style={{ padding: '20px' }}>
                          {(order.items || []).map((item) => (
                            <div
                              key={item.id}
                              style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '16px',
                                padding: '10px 0',
                                borderBottom: '1px solid #f7f7f7'
                              }}
                            >
                              <div
                                style={{
                                  width: '64px',
                                  height: '64px',
                                  borderRadius: '6px',
                                  background: '#f4f2ec',
                                  overflow: 'hidden',
                                  flexShrink: 0
                                }}
                              >
                                {item.product_image ? (
                                  <img
                                    src={item.product_image}
                                    alt={item.product_name}
                                    style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                                  />
                                ) : (
                                  <ShoppingBag size={24} style={{ margin: '20px auto', display: 'block', color: '#aaa' }} />
                                )}
                              </div>

                              <div style={{ flex: 1, minWidth: 0 }}>
                                <h4 style={{ fontSize: '14px', fontWeight: '700', margin: '0 0 4px', color: '#121212' }}>
                                  {item.product_name}
                                </h4>
                                <div style={{ fontSize: '12px', color: '#777' }}>
                                  Qty: {item.quantity} {item.variant_name && `· Variant: ${item.variant_name}`}
                                </div>
                              </div>

                              <div style={{ fontSize: '14px', fontWeight: '700', color: '#121212' }}>
                                {formatPrice(item.unit_price * item.quantity)}
                              </div>
                            </div>
                          ))}
                        </div>

                        {/* Order Footer Actions */}
                        <div
                          style={{
                            padding: '12px 20px',
                            background: '#ffffff',
                            borderTop: '1px solid #f0f0f0',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                            flexWrap: 'wrap',
                            gap: '10px'
                          }}
                        >
                          <span style={{ fontSize: '12px', color: '#777' }}>
                            Payment: <strong>{order.payment_method === 'cod' ? 'Cash on Delivery' : 'Prepaid (Razorpay)'}</strong>
                          </span>
                          <div style={{ display: 'flex', gap: '8px' }}>
                            <button
                              onClick={() => alert(`Tracking updates for order ${order.order_number}: In transit via BlueDart.`)}
                              style={{
                                padding: '6px 14px',
                                fontSize: '12px',
                                fontWeight: '600',
                                background: '#121212',
                                color: '#ffffff',
                                border: 'none',
                                borderRadius: '4px',
                                cursor: 'pointer'
                              }}
                            >
                              Track Order
                            </button>
                            <Link
                              to="/pages/contact-us"
                              style={{
                                padding: '6px 14px',
                                fontSize: '12px',
                                fontWeight: '600',
                                background: '#ffffff',
                                color: '#121212',
                                border: '1px solid #dcdcdc',
                                borderRadius: '4px',
                                textDecoration: 'none'
                              }}
                            >
                              Need Help?
                            </Link>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          )}

          {/* TAB 2: ADDRESSES */}
          {activeTab === 'addresses' && (
            <div
              style={{
                background: '#ffffff',
                border: '1px solid #ebebeb',
                borderRadius: '8px',
                padding: '24px',
                boxShadow: '0 2px 8px rgba(0,0,0,0.03)'
              }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div>
                  <span className="eyebrow">SAVED ADDRESSES</span>
                  <h1 style={{ fontSize: '22px', fontWeight: '800', margin: '2px 0 0' }}>Delivery Addresses</h1>
                </div>
                <button
                  onClick={() => setShowAddAddress(!showAddAddress)}
                  className="button button-dark"
                  style={{ fontSize: '12.5px', padding: '8px 16px', display: 'inline-flex', alignItems: 'center', gap: '6px' }}
                >
                  <Plus size={16} /> {showAddAddress ? 'Cancel' : 'Add New Address'}
                </button>
              </div>

              {showAddAddress && (
                <form
                  onSubmit={handleCreateAddress}
                  style={{
                    background: '#faf9f6',
                    border: '1px solid #e7e5df',
                    borderRadius: '8px',
                    padding: '20px',
                    marginBottom: '24px'
                  }}
                >
                  <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '14px' }}>New Shipping Address</h3>
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '14px' }}>
                    <label style={{ fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      Full Name
                      <input
                        required
                        value={newAddr.full_name}
                        onChange={(e) => setNewAddr({ ...newAddr, full_name: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                    <label style={{ fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      Phone (10 digits)
                      <input
                        required
                        value={newAddr.phone}
                        onChange={(e) => setNewAddr({ ...newAddr, phone: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                    <label style={{ gridColumn: '1 / -1', fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      Address Line 1 (House/Flat, Street)
                      <input
                        required
                        value={newAddr.address_line1}
                        onChange={(e) => setNewAddr({ ...newAddr, address_line1: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                    <label style={{ fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      City
                      <input
                        required
                        value={newAddr.city}
                        onChange={(e) => setNewAddr({ ...newAddr, city: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                    <label style={{ fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      State
                      <input
                        required
                        value={newAddr.state}
                        onChange={(e) => setNewAddr({ ...newAddr, state: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                    <label style={{ fontSize: '12px', fontWeight: '600', color: '#555' }}>
                      Postal Code (PIN)
                      <input
                        required
                        value={newAddr.postal_code}
                        onChange={(e) => setNewAddr({ ...newAddr, postal_code: e.target.value })}
                        style={{ width: '100%', height: '40px', padding: '0 10px', marginTop: '4px', border: '1px solid #ccc', borderRadius: '4px' }}
                      />
                    </label>
                  </div>

                  {addrError && <p style={{ color: '#b00020', fontSize: '12px', marginTop: '10px' }}>{addrError}</p>}

                  <div style={{ marginTop: '16px' }}>
                    <button type="submit" disabled={savingAddr} className="button button-dark" style={{ fontSize: '13px', padding: '10px 20px' }}>
                      {savingAddr ? 'Saving…' : 'Save Address'}
                    </button>
                  </div>
                </form>
              )}

              {addresses.length === 0 ? (
                <p style={{ color: 'var(--ink-muted)', fontSize: '14px' }}>No saved addresses. Add an address for faster checkout.</p>
              ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px' }}>
                  {addresses.map((addr) => (
                    <div
                      key={addr.id}
                      style={{
                        border: '1px solid #ebebeb',
                        borderRadius: '6px',
                        padding: '16px',
                        background: '#ffffff',
                        position: 'relative'
                      }}
                    >
                      <strong style={{ fontSize: '14px', display: 'block', color: '#121212' }}>{addr.full_name}</strong>
                      <p style={{ fontSize: '13px', color: '#555', margin: '6px 0', lineHeight: '1.5' }}>
                        {addr.address_line1} {addr.address_line2 && `, ${addr.address_line2}`}
                        <br />
                        {addr.city}, {addr.state} - {addr.postal_code}
                        <br />
                        Phone: {addr.phone}
                      </p>
                      <button
                        onClick={() => handleDeleteAddress(addr.id)}
                        style={{
                          background: 'none',
                          border: 'none',
                          color: '#b00020',
                          cursor: 'pointer',
                          fontSize: '12px',
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '4px',
                          padding: '4px 0',
                          marginTop: '8px'
                        }}
                      >
                        <Trash2 size={13} /> Delete Address
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* TAB 3: PROFILE DETAILS */}
          {activeTab === 'details' && (
            <div
              style={{
                background: '#ffffff',
                border: '1px solid #ebebeb',
                borderRadius: '8px',
                padding: '24px',
                boxShadow: '0 2px 8px rgba(0,0,0,0.03)'
              }}
            >
              <span className="eyebrow">ACCOUNT INFORMATION</span>
              <h1 style={{ fontSize: '22px', fontWeight: '800', margin: '2px 0 20px' }}>Personal Profile</h1>

              <div style={{ maxWidth: '440px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                <div>
                  <label style={{ fontSize: '12px', fontWeight: '600', color: '#666', display: 'block', marginBottom: '4px' }}>
                    First Name
                  </label>
                  <input
                    readOnly
                    value={user.first_name || ''}
                    style={{ width: '100%', height: '42px', padding: '0 12px', border: '1px solid #ddd', borderRadius: '4px', background: '#fafafa' }}
                  />
                </div>
                <div>
                  <label style={{ fontSize: '12px', fontWeight: '600', color: '#666', display: 'block', marginBottom: '4px' }}>
                    Last Name
                  </label>
                  <input
                    readOnly
                    value={user.last_name || ''}
                    style={{ width: '100%', height: '42px', padding: '0 12px', border: '1px solid #ddd', borderRadius: '4px', background: '#fafafa' }}
                  />
                </div>
                <div>
                  <label style={{ fontSize: '12px', fontWeight: '600', color: '#666', display: 'block', marginBottom: '4px' }}>
                    Email Address
                  </label>
                  <input
                    readOnly
                    value={user.email || ''}
                    style={{ width: '100%', height: '42px', padding: '0 12px', border: '1px solid #ddd', borderRadius: '4px', background: '#fafafa' }}
                  />
                </div>
                <div>
                  <label style={{ fontSize: '12px', fontWeight: '600', color: '#666', display: 'block', marginBottom: '4px' }}>
                    Phone Number
                  </label>
                  <input
                    readOnly
                    value={user.phone || 'Not provided'}
                    style={{ width: '100%', height: '42px', padding: '0 12px', border: '1px solid #ddd', borderRadius: '4px', background: '#fafafa' }}
                  />
                </div>
                <div style={{ marginTop: '10px' }}>
                  <Link to="/forgot-password" className="text-link" style={{ fontSize: '13px', fontWeight: '600' }}>
                    Change or Reset Password →
                  </Link>
                </div>
              </div>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

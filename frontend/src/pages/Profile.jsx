import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import useAuth from '../hooks/useAuth';
import authService from '../services/authService';
import Loading from '../components/common/Loading';
import { MapPin, ShoppingBag, LogOut, Plus, Shield } from 'lucide-react';

export default function Profile() {
  const { user, loading, logout, isAdmin } = useAuth();
  const navigate = useNavigate();

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
  const [addrError, setAddrError] = useState(null);
  const [savingAddr, setSavingAddr] = useState(false);

  useEffect(() => {
    if (user) {
      authService.getAddresses().then(setAddresses).catch(() => {});
    }
  }, [user]);

  if (loading) {
    return <Loading message="Loading profile…" />;
  }

  if (!user) {
    return (
      <main className="page auth-page">
        <h1>Sign in to your account</h1>
        <p>Access your orders and manage saved addresses.</p>
        <Link to="/login" className="button button-dark">
          Sign In
        </Link>
      </main>
    );
  }

  const handleLogout = async () => {
    await logout();
    navigate('/');
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
    try {
      await authService.deleteAddress(id);
      setAddresses((prev) => prev.filter((a) => a.id !== id));
    } catch (err) {
      alert(err.message);
    }
  };

  return (
    <main className="page" style={{ paddingTop: '24px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px', marginBottom: '28px' }}>
        <div>
          <span className="eyebrow">YOUR ACCOUNT</span>
          <h1 style={{ margin: '6px 0 4px', fontSize: '28px' }}>
            Hello, {user.first_name || 'there'}.
          </h1>
          <p style={{ color: 'var(--muted)', fontSize: '14px' }}>{user.email} {user.phone ? `· ${user.phone}` : ''}</p>
        </div>

        <div style={{ display: 'flex', gap: '10px' }}>
          {isAdmin && (
            <Link to="/admin/dashboard" className="button button-outline">
              <Shield size={16} /> Admin Console
            </Link>
          )}
          <Link to="/orders" className="button button-outline">
            <ShoppingBag size={16} /> View Orders
          </Link>
          <button className="button button-outline" onClick={handleLogout}>
            <LogOut size={16} /> Sign Out
          </button>
        </div>
      </div>

      {/* Saved Addresses Section */}
      <section style={{ borderTop: '1px solid var(--line)', paddingTop: '28px', marginTop: '20px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
          <h3>Saved Addresses</h3>
          <button
            className="button button-outline"
            style={{ minHeight: '36px', fontSize: '12px' }}
            onClick={() => setShowAddAddress(!showAddAddress)}
          >
            <Plus size={14} /> {showAddAddress ? 'Cancel' : 'Add New Address'}
          </button>
        </div>

        {showAddAddress && (
          <form
            onSubmit={handleCreateAddress}
            style={{
              background: 'var(--soft)',
              padding: '20px',
              borderRadius: '6px',
              marginBottom: '24px',
              maxWidth: '600px'
            }}
          >
            <h4 style={{ marginBottom: '14px' }}>Add New Address</h4>
            <div className="form-grid">
              <label>
                Full Name
                <input
                  required
                  value={newAddr.full_name}
                  onChange={(e) => setNewAddr({ ...newAddr, full_name: e.target.value })}
                />
              </label>
              <label>
                Phone
                <input
                  required
                  value={newAddr.phone}
                  onChange={(e) => setNewAddr({ ...newAddr, phone: e.target.value })}
                />
              </label>
              <label className="wide">
                Address Line 1
                <input
                  required
                  value={newAddr.address_line1}
                  onChange={(e) => setNewAddr({ ...newAddr, address_line1: e.target.value })}
                />
              </label>
              <label className="wide">
                Address Line 2 (Optional)
                <input
                  value={newAddr.address_line2}
                  onChange={(e) => setNewAddr({ ...newAddr, address_line2: e.target.value })}
                />
              </label>
              <label>
                City
                <input
                  required
                  value={newAddr.city}
                  onChange={(e) => setNewAddr({ ...newAddr, city: e.target.value })}
                />
              </label>
              <label>
                State
                <input
                  required
                  value={newAddr.state}
                  onChange={(e) => setNewAddr({ ...newAddr, state: e.target.value })}
                />
              </label>
              <label>
                PIN Code
                <input
                  required
                  value={newAddr.postal_code}
                  onChange={(e) => setNewAddr({ ...newAddr, postal_code: e.target.value })}
                />
              </label>
            </div>
            {addrError && <p style={{ color: '#d32f2f', fontSize: '13px', marginTop: '10px' }}>{addrError}</p>}
            <button
              type="submit"
              className="button button-dark"
              disabled={savingAddr}
              style={{ marginTop: '14px', minHeight: '40px' }}
            >
              {savingAddr ? 'Saving…' : 'Save Address'}
            </button>
          </form>
        )}

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '16px' }}>
          {addresses.map((a) => (
            <div
              key={a.id}
              style={{
                border: '1px solid var(--line)',
                borderRadius: '6px',
                padding: '16px',
                background: '#fff'
              }}
            >
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
                <MapPin size={16} />
                <strong>{a.full_name}</strong>
                {a.is_default && (
                  <span style={{ fontSize: '10px', background: 'var(--soft)', padding: '2px 6px', borderRadius: '4px' }}>
                    DEFAULT
                  </span>
                )}
              </div>
              <p style={{ fontSize: '13px', color: 'var(--ink)', margin: '4px 0' }}>
                {a.address_line1} {a.address_line2 ? `, ${a.address_line2}` : ''}
              </p>
              <p style={{ fontSize: '12px', color: 'var(--muted)', margin: '2px 0' }}>
                {a.city}, {a.state} - {a.postal_code}
              </p>
              <p style={{ fontSize: '12px', color: 'var(--muted)' }}>Phone: {a.phone}</p>
              <button
                type="button"
                onClick={() => handleDeleteAddress(a.id)}
                style={{
                  marginTop: '10px',
                  background: 'none',
                  border: 'none',
                  color: '#d32f2f',
                  fontSize: '11px',
                  cursor: 'pointer',
                  padding: 0
                }}
              >
                Delete Address
              </button>
            </div>
          ))}
          {addresses.length === 0 && !showAddAddress && (
            <p style={{ color: 'var(--muted)', fontSize: '13px' }}>
              No addresses saved yet. Add an address for faster checkout.
            </p>
          )}
        </div>
      </section>
    </main>
  );
}

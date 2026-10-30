import { useState, useEffect } from 'react';
import useAuth from '../../hooks/useAuth';
import authService from '../../services/authService';

export default function AddressForm({ address, onChangeAddress, onSelectSavedAddress }) {
  const { isAuthenticated } = useAuth();
  const [savedAddresses, setSavedAddresses] = useState([]);
  const [selectedId, setSelectedId] = useState(null);

  useEffect(() => {
    if (isAuthenticated) {
      authService.getAddresses().then((data) => {
        if (Array.isArray(data) && data.length > 0) {
          setSavedAddresses(data);
          const defaultAddr = data.find((a) => a.is_default) || data[0];
          if (defaultAddr) {
            setSelectedId(defaultAddr.id);
            onSelectSavedAddress(defaultAddr);
          }
        }
      }).catch(() => {});
    }
  }, [isAuthenticated, onSelectSavedAddress]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setSelectedId(null);
    onChangeAddress({
      ...address,
      [name]: value
    });
  };

  const handlePickSaved = (saved) => {
    setSelectedId(saved.id);
    onSelectSavedAddress(saved);
  };

  return (
    <div className="checkout-address-section">
      {savedAddresses.length > 0 && (
        <div style={{ marginBottom: '20px' }}>
          <h3>Saved Delivery Addresses</h3>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '10px', marginTop: '10px' }}>
            {savedAddresses.map((saved) => (
              <div
                key={saved.id}
                onClick={() => handlePickSaved(saved)}
                style={{
                  padding: '12px',
                  border: selectedId === saved.id ? '2px solid var(--ink)' : '1px solid var(--line)',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  fontSize: '12px',
                  background: selectedId === saved.id ? 'var(--soft)' : '#fff'
                }}
              >
                <strong>{saved.full_name}</strong>
                <p style={{ margin: '4px 0' }}>{saved.address_line1}, {saved.city}</p>
                <p style={{ color: 'var(--muted)' }}>PIN: {saved.postal_code} · {saved.phone}</p>
              </div>
            ))}
          </div>
          <p style={{ fontSize: '11px', color: 'var(--muted)', marginTop: '8px' }}>
            Or fill out a new address below:
          </p>
        </div>
      )}

      <h2>Delivery Details</h2>
      <div className="form-grid">
        <label>
          Full Name *
          <input
            name="full_name"
            required
            autoComplete="name"
            value={address.full_name || ''}
            onChange={handleChange}
            placeholder="First and last name"
          />
        </label>

        <label>
          Phone Number *
          <input
            name="phone"
            required
            type="tel"
            autoComplete="tel"
            value={address.phone || ''}
            onChange={handleChange}
            placeholder="10-digit mobile number"
          />
        </label>

        <label className="wide">
          Street Address *
          <input
            name="address_line1"
            required
            autoComplete="street-address"
            value={address.address_line1 || ''}
            onChange={handleChange}
            placeholder="House/flat no., building, street"
          />
        </label>

        <label className="wide">
          Apartment / Landmark (Optional)
          <input
            name="address_line2"
            value={address.address_line2 || ''}
            onChange={handleChange}
            placeholder="Floor, landmark, unit"
          />
        </label>

        <label>
          City *
          <input
            name="city"
            required
            value={address.city || ''}
            onChange={handleChange}
            placeholder="City"
          />
        </label>

        <label>
          State *
          <input
            name="state"
            required
            value={address.state || ''}
            onChange={handleChange}
            placeholder="State"
          />
        </label>

        <label>
          Postal Code (PIN) *
          <input
            name="postal_code"
            required
            inputMode="numeric"
            value={address.postal_code || ''}
            onChange={handleChange}
            placeholder="6-digit PIN code"
          />
        </label>

        <label>
          Country *
          <input
            name="country"
            required
            value={address.country || 'India'}
            onChange={handleChange}
          />
        </label>

        <label className="wide">
          Email Address for Order Updates *
          <input
            name="email"
            required
            type="email"
            autoComplete="email"
            value={address.email || ''}
            onChange={handleChange}
            placeholder="you@example.com"
          />
        </label>
      </div>
    </div>
  );
}

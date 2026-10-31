import { useState, useMemo } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, MapPin, CheckCircle, SlidersHorizontal } from 'lucide-react';
import ProductGrid from '../products/ProductGrid';

const QUICK_FILTERS = [
  { label: 'ALL BAGS', key: 'all' },
  { label: 'BACKPACKS', key: 'backpack' },
  { label: 'TOTES', key: 'tote' },
  { label: 'CROSSBODY', key: 'crossbody' },
  { label: 'MESSENGERS', key: 'messenger' },
  { label: 'WALLETS', key: 'wallet' },
  { label: 'POUCHES', key: 'pouch' },
  { label: 'ACCESSORIES', key: 'accessories' }
];

export default function FeaturedProducts({ products = [], loading = false }) {
  const [activeFilter, setActiveFilter] = useState('all');
  const [pincode, setPincode] = useState(() => localStorage.getItem('do-pincode') || '110001');
  const [enteredPincode, setEnteredPincode] = useState(pincode);
  const [pincodeStatus, setPincodeStatus] = useState(
    pincode ? `Delivering to ${pincode} · Standard 2-Day Express Delivery available` : null
  );

  const handlePincodeCheck = (e) => {
    e.preventDefault();
    const clean = enteredPincode.trim();
    if (!/^[1-9][0-9]{5}$/.test(clean)) {
      setPincodeStatus('Please enter a valid 6-digit Indian PIN code.');
      return;
    }
    setPincode(clean);
    localStorage.setItem('do-pincode', clean);
    setPincodeStatus(`Delivering to ${clean} · Standard 2-Day Express Delivery available (Free above ₹1,499)`);
  };

  const filteredProducts = useMemo(() => {
    if (activeFilter === 'all') return products;
    const term = activeFilter.toLowerCase();
    return products.filter((p) => {
      const catSlug = (p.category_slug || '').toLowerCase();
      const catName = (p.category || '').toLowerCase();
      const name = (p.name || '').toLowerCase();
      return catSlug.includes(term) || catName.includes(term) || name.includes(term);
    });
  }, [products, activeFilter]);

  return (
    <section className="section featured-section" style={{ maxWidth: 'var(--container)', margin: '0 auto', padding: '0 var(--space)' }}>
      {/* 1. Location-Based Delivery Postcode Bar (UX4G & GIGW compliance) */}
      <div
        className="delivery-location-bar"
        style={{
          background: '#faf9f6',
          border: '1px solid #ebebeb',
          borderRadius: '8px',
          padding: '12px 18px',
          marginBottom: '28px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          flexWrap: 'wrap',
          gap: '12px'
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '13px', color: '#121212', fontWeight: '600' }}>
          <MapPin size={17} color="#2db58e" />
          <span>Delivery Availability:</span>
          {pincodeStatus && (
            <span style={{ fontWeight: '500', color: '#4a4a4a', fontSize: '12.5px' }}>
              {pincodeStatus}
            </span>
          )}
        </div>

        <form onSubmit={handlePincodeCheck} style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <label htmlFor="delivery-pincode-input" className="sr-only">
            Enter 6-digit Delivery Pincode
          </label>
          <input
            id="delivery-pincode-input"
            type="text"
            maxLength={6}
            value={enteredPincode}
            onChange={(e) => setEnteredPincode(e.target.value)}
            placeholder="Pincode (e.g. 110001)"
            style={{
              height: '36px',
              width: '150px',
              padding: '0 10px',
              fontSize: '12.5px',
              border: '1px solid #dcdcdc',
              borderRadius: '4px',
              background: '#ffffff'
            }}
          />
          <button
            type="submit"
            style={{
              height: '36px',
              padding: '0 14px',
              fontSize: '12px',
              fontWeight: '700',
              background: '#121212',
              color: '#ffffff',
              border: 'none',
              borderRadius: '4px',
              cursor: 'pointer'
            }}
          >
            Check
          </button>
        </form>
      </div>

      {/* 2. Heading Section */}
      <div
        className="section-heading"
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'flex-end',
          flexWrap: 'wrap',
          gap: '16px',
          marginBottom: '24px'
        }}
      >
        <div>
          <span className="eyebrow">THE GOOD CARRY · CURATED ESSENTIALS</span>
          <h2 style={{ fontSize: 'clamp(24px, 3.2vw, 36px)', fontWeight: '800', letterSpacing: '0.04em', margin: '4px 0 0' }}>
            Everyday favourites
          </h2>
          <p style={{ color: 'var(--ink-muted)', marginTop: '6px', fontSize: '14px' }}>
            One signature piece for every style of carry—from backpacks and totes to crossbodies and pouches.
          </p>
        </div>
        <Link to="/shop" className="text-link" style={{ fontSize: '13px', fontWeight: '700', display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
          Explore All Bags <ArrowRight size={16} />
        </Link>
      </div>

      {/* 3. Quick Filter Chips (UX4G Sorting & Filtering compliance) */}
      <div
        className="quick-filters-row"
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '8px',
          overflowX: 'auto',
          paddingBottom: '8px',
          marginBottom: '24px',
          scrollbarWidth: 'none'
        }}
        role="group"
        aria-label="Filter bags by category"
      >
        <span style={{ fontSize: '12px', fontWeight: '700', color: '#777', display: 'inline-flex', alignItems: 'center', gap: '4px', marginRight: '6px' }}>
          <SlidersHorizontal size={14} /> Filter:
        </span>
        {QUICK_FILTERS.map((f) => {
          const isSelected = activeFilter === f.key;
          return (
            <button
              key={f.key}
              onClick={() => setActiveFilter(f.key)}
              style={{
                padding: '6px 14px',
                fontSize: '11px',
                fontWeight: '700',
                letterSpacing: '0.05em',
                borderRadius: '20px',
                border: isSelected ? '1px solid #121212' : '1px solid #e2e2e2',
                background: isSelected ? '#121212' : '#ffffff',
                color: isSelected ? '#ffffff' : '#333333',
                cursor: 'pointer',
                whiteSpace: 'nowrap',
                transition: 'all 0.15s ease'
              }}
              aria-pressed={isSelected}
            >
              {f.label}
            </button>
          );
        })}
      </div>

      {/* 4. Product Grid or Skeletons */}
      {loading ? (
        <div className="product-grid" aria-busy="true" aria-label="Loading products">
          {[...Array(9)].map((_, i) => (
            <div
              key={i}
              style={{
                background: '#f2f0eb',
                borderRadius: '6px',
                height: '380px',
                animation: 'pulse 1.5s infinite ease-in-out'
              }}
            />
          ))}
        </div>
      ) : (
        <ProductGrid
          products={filteredProducts.length > 0 ? filteredProducts : products}
          emptyMessage="No bags match the selected filter. Showing all curated pieces."
        />
      )}
    </section>
  );
}

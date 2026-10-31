import { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Menu, X, Search, UserRound, ShoppingBag, Shield, Heart, CheckCircle2 } from 'lucide-react';
import useAuth from '../../hooks/useAuth';
import useCart from '../../hooks/useCart';
import useWishlist from '../../hooks/useWishlist';
import SearchBar from './SearchBar';
import { NAV_LINKS, RAZORPAY_KEY_ID } from '../../utils/constants';
import api from '../../services/api';

export default function Navbar() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [donateOpen, setDonateOpen] = useState(false);
  const [donationAmount, setDonationAmount] = useState(1000);
  const [donating, setDonating] = useState(false);
  const [donationSuccess, setDonationSuccess] = useState(null);
  const { user, isAdmin } = useAuth();
  const { itemCount } = useCart();
  const { items: wishlistItems } = useWishlist();
  const wishlistCount = wishlistItems ? wishlistItems.length : 0;
  const location = useLocation();

  const loadRazorpayScript = () => {
    return new Promise((resolve) => {
      if (window.Razorpay) {
        resolve(true);
        return;
      }
      const script = document.createElement('script');
      script.src = 'https://checkout.razorpay.com/v1/checkout.js';
      script.onload = () => resolve(true);
      script.onerror = () => resolve(false);
      document.body.appendChild(script);
    });
  };

  const handleProceedDonate = async () => {
    try {
      setDonating(true);
      const loaded = await loadRazorpayScript();
      if (!loaded) {
        alert('Could not initialize Razorpay payment gateway. Please check your internet connection.');
        return;
      }

      let orderData = null;
      try {
        const res = await api.post('/payments/donate', { amount: donationAmount });
        orderData = res.data;
      } catch (e) {
        console.warn('Backend donation order creation skipped/failed:', e.message);
      }

      const key = orderData?.keyId || RAZORPAY_KEY_ID;

      const options = {
        key,
        amount: donationAmount * 100, // paise
        currency: 'INR',
        name: 'Bethany Looms',
        description: `Mission Donation (₹${donationAmount}) · Bethany Leprosy Mission Association`,
        order_id: orderData?.razorpayOrder?.id,
        prefill: {
          name: user ? `${user.first_name || ''} ${user.last_name || ''}`.trim() : '',
          email: user?.email || '',
          contact: user?.phone || ''
        },
        theme: {
          color: '#1e2d4a'
        },
        handler: (response) => {
          setDonationSuccess(response.razorpay_payment_id || 'SUCCESS');
        },
        modal: {
          ondismiss: () => {
            setDonating(false);
          }
        }
      };

      const rzp = new window.Razorpay(options);
      rzp.open();
    } catch (err) {
      console.error('Donation checkout error:', err);
      alert('Could not open payment gateway: ' + (err.message || 'Unknown error'));
    } finally {
      setDonating(false);
    }
  };

  const handleNavLinkClick = (to) => {
    setMenuOpen(false);
    if (to.startsWith('/#')) {
      const targetId = to.replace('/#', '');
      if (location.pathname === '/') {
        const el = document.getElementById(targetId);
        if (el) el.scrollIntoView({ behavior: 'smooth' });
      }
    }
  };

  return (
    <>
      <header className="header">
        <button
          className="icon-btn mobile-menu"
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label={menuOpen ? 'Close menu' : 'Open menu'}
        >
          {menuOpen ? <X size={22} /> : <Menu size={22} />}
        </button>

        {/* Brand Logo: Bethany Looms */}
        <Link to="/" className="brand-logo" onClick={() => setMenuOpen(false)} aria-label="Bethany Looms Home">
          <div className="brand-text-bethany">
            <span className="brand-name">Bethany Looms</span>
            <span className="brand-subname">A project of Bethany Leprosy Mission Association</span>
          </div>
        </Link>

        {/* Center Nav Links */}
        <nav className={menuOpen ? 'nav open' : 'nav'}>
          {NAV_LINKS.map((link) => (
            <Link
              key={link.label}
              to={link.to}
              className="nav-item"
              onClick={() => handleNavLinkClick(link.to)}
            >
              <span className="nav-item-label">{link.label}</span>
            </Link>
          ))}

          {isAdmin && (
            <Link
              to="/admin/dashboard"
              className="nav-item admin-nav-link"
              onClick={() => setMenuOpen(false)}
              style={{ color: 'var(--accent)', fontWeight: 'bold' }}
            >
              <Shield size={14} style={{ display: 'inline', marginRight: '4px' }} />
              ADMIN
            </Link>
          )}

          {/* Mobile Drawer Actions */}
          <div className="mobile-drawer-footer">
            <button
              className="button button-outline"
              style={{ width: '100%', marginBottom: '10px' }}
              onClick={() => {
                setMenuOpen(false);
                setDonateOpen(true);
              }}
            >
              Donate to Mission
            </button>
            <Link to="/wishlist" onClick={() => setMenuOpen(false)}>
              Wishlist {wishlistCount > 0 ? `(${wishlistCount})` : ''}
            </Link>
            <Link to={user ? '/profile' : '/login'} onClick={() => setMenuOpen(false)}>
              {user ? 'My Account' : 'Sign In'}
            </Link>
          </div>
        </nav>

        {/* Right Action Icons aligned in a luxury manner */}
        <div className="header-actions">
          {/* Donate Pill Button */}
          <button
            type="button"
            className="donate-pill-btn"
            onClick={() => setDonateOpen(true)}
            aria-label="Donate directly to mission"
          >
            <Heart size={14} fill="#e5ad42" color="#e5ad42" />
            <span>Donate</span>
          </button>

          {/* Search Icon */}
          <button
            className="icon-btn"
            onClick={() => setSearchOpen(!searchOpen)}
            aria-label="Search products"
          >
            <Search size={21} strokeWidth={1.8} />
          </button>

          {/* Wishlist Icon with count badge */}
          <Link
            className="icon-btn wishlist-icon-btn"
            to="/wishlist"
            aria-label="Wishlist"
          >
            <Heart size={21} strokeWidth={1.8} />
            {wishlistCount > 0 && <span className="nav-badge-count">{wishlistCount}</span>}
          </Link>

          {/* Cart Icon with count badge */}
          <Link
            className="icon-btn cart-icon-btn"
            to="/cart"
            aria-label="Shopping Cart"
          >
            <ShoppingBag size={21} strokeWidth={1.8} />
            {itemCount > 0 && <span className="nav-badge-count">{itemCount}</span>}
          </Link>

          {/* Profile / Account Icon */}
          <Link
            className="icon-btn desktop-action"
            to={user ? '/profile' : '/login'}
            aria-label="My Account"
          >
            <UserRound size={21} strokeWidth={1.8} />
          </Link>
        </div>
      </header>

      {searchOpen && <SearchBar onClose={() => setSearchOpen(false)} />}

      {/* Quick Donation Modal (Connected to Razorpay Gateway) */}
      {donateOpen && (
        <div className="donate-modal-overlay" onClick={() => { setDonateOpen(false); setDonationSuccess(null); }}>
          <div className="donate-modal" onClick={(e) => e.stopPropagation()}>
            <button
              className="donate-modal-close"
              onClick={() => { setDonateOpen(false); setDonationSuccess(null); }}
              aria-label="Close"
            >
              <X size={20} />
            </button>

            {donationSuccess ? (
              <div style={{ textAlign: 'center', padding: '12px 0' }}>
                <CheckCircle2 size={46} color="#2db58e" style={{ margin: '0 auto 12px' }} />
                <span className="eyebrow" style={{ color: 'var(--navy)', fontWeight: 700 }}>BETHANY LEPROSY MISSION ASSOCIATION</span>
                <h2 style={{ fontSize: '22px', margin: '8px 0 10px', color: 'var(--navy)' }}>
                  Thank You for Your Support!
                </h2>
                <p style={{ fontSize: '14.5px', color: '#555', lineHeight: '1.6', marginBottom: '16px' }}>
                  Your contribution of <strong>₹{donationAmount.toLocaleString('en-IN')}</strong> directly funds medical care, wholesome nutrition, and dignified livelihoods for our elderly and leprosy-affected weavers.
                </p>
                <div style={{ background: '#f7f6f2', padding: '12px 16px', borderRadius: '6px', fontSize: '12.5px', color: '#666', marginBottom: '20px' }}>
                  Payment ID: <strong>{donationSuccess}</strong><br />
                  80G tax deduction receipt will be issued for your contribution.
                </div>
                <button
                  type="button"
                  onClick={() => { setDonateOpen(false); setDonationSuccess(null); }}
                  className="button full"
                  style={{ background: 'var(--navy)', color: '#fff', height: '46px', fontSize: '14px', border: 'none', borderRadius: '6px', cursor: 'pointer' }}
                >
                  Close
                </button>
              </div>
            ) : (
              <>
                <span className="eyebrow" style={{ color: 'var(--navy)', fontWeight: 700 }}>BETHANY LEPROSY MISSION ASSOCIATION</span>
                <h2 style={{ fontSize: '24px', margin: '8px 0 12px', color: 'var(--navy)' }}>Partner with our Mission</h2>
                <p style={{ fontSize: '14.5px', color: '#555', lineHeight: '1.6', marginBottom: '20px' }}>
                  Your donation provides free medical care, dignified livelihood, food, and safe shelter to elders and leprosy survivors across our community.
                </p>

                <div style={{ display: 'flex', gap: '10px', marginBottom: '20px' }}>
                  {[500, 1000, 2500, 5000].map((amt) => (
                    <button
                      key={amt}
                      type="button"
                      onClick={() => setDonationAmount(amt)}
                      className={`amt-select-btn ${donationAmount === amt ? 'selected' : ''}`}
                    >
                      ₹{amt.toLocaleString('en-IN')}
                    </button>
                  ))}
                </div>

                <div style={{ background: '#f7f6f2', padding: '16px', borderRadius: '8px', marginBottom: '20px', border: '1px solid #e2ded4', fontSize: '13.5px' }}>
                  <div><strong>Tax Exemption:</strong> 80G Tax Deductible receipt will be issued for all Indian donations.</div>
                  <div style={{ marginTop: '6px', color: '#666' }}>Pay securely via UPI QR, Google Pay, PhonePe, Cards or Netbanking on Razorpay.</div>
                </div>

                <button
                  type="button"
                  onClick={handleProceedDonate}
                  disabled={donating}
                  className="button full"
                  style={{ background: 'var(--navy)', color: '#fff', height: '48px', fontSize: '15px', fontWeight: 600, border: 'none', borderRadius: '6px', cursor: 'pointer' }}
                >
                  {donating ? 'Opening Razorpay Gateway…' : `Proceed to Donate ₹${donationAmount.toLocaleString('en-IN')} via Razorpay`}
                </button>
              </>
            )}
          </div>
        </div>
      )}
    </>
  );
}

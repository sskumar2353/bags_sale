import { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Menu, X, Search, UserRound, ShoppingBag, Shield, Heart } from 'lucide-react';
import useAuth from '../../hooks/useAuth';
import useCart from '../../hooks/useCart';
import SearchBar from './SearchBar';
import { NAV_LINKS, NAV_LINKS_TE } from '../../utils/constants';

export default function Navbar() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [donateOpen, setDonateOpen] = useState(false);
  const [donationAmount, setDonationAmount] = useState(1000);
  const [lang, setLang] = useState(() => localStorage.getItem('site_lang') || 'en');
  const { user, isAdmin } = useAuth();
  const { itemCount } = useCart();
  const location = useLocation();

  useEffect(() => {
    const saved = localStorage.getItem('site_lang') || 'en';
    document.documentElement.lang = saved;
  }, []);

  const toggleLanguage = () => {
    const nextLang = lang === 'en' ? 'te' : 'en';
    setLang(nextLang);
    localStorage.setItem('site_lang', nextLang);
    document.documentElement.lang = nextLang;
  };

  const navItems = lang === 'te' ? NAV_LINKS_TE : NAV_LINKS;

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

        {/* Brand Logo: Bethany Looms (A project of Bethany Leprosy Mission Association) */}
        <Link to="/" className="brand-logo" onClick={() => setMenuOpen(false)} aria-label="Bethany Looms Home">
          <div className="brand-text-bethany">
            <span className="brand-name">Bethany Looms</span>
            <span className="brand-subname">A project of Bethany Leprosy Mission Association</span>
          </div>
        </Link>

        {/* Center Nav Links */}
        <nav className={menuOpen ? 'nav open' : 'nav'}>
          {navItems.map((link) => (
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
              className="mobile-lang-btn"
              onClick={toggleLanguage}
              type="button"
              aria-label="Switch language"
            >
              <span>{lang === 'en' ? 'భాష: తెలుగులోకి మార్చండి' : 'Language: Switch to English'}</span>
            </button>
            <button
              className="button button-outline"
              style={{ width: '100%', marginBottom: '10px' }}
              onClick={() => {
                setMenuOpen(false);
                setDonateOpen(true);
              }}
            >
              Donate
            </button>
            <Link to="/wishlist" onClick={() => setMenuOpen(false)}>Wishlist</Link>
            <Link to={user ? '/profile' : '/login'} onClick={() => setMenuOpen(false)}>
              {user ? 'My Account' : 'Sign In'}
            </Link>
          </div>
        </nav>

        {/* Right Action Items: Donate, Cart, Search, Profile, Language */}
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

          {/* Cart Pill Button matching PDF */}
          <Link className="cart-pill-btn" to="/cart" aria-label="Shopping Cart">
            <span>Cart ({itemCount})</span>
          </Link>

          {/* Language Switcher */}
          <button
            className="lang-pill-btn"
            onClick={toggleLanguage}
            type="button"
            aria-label="Switch language between English and Telugu"
            title="English · తెలుగు"
          >
            {lang === 'en' ? 'తెలుగు' : 'EN'}
          </button>

          <button
            className="icon-btn"
            onClick={() => setSearchOpen(!searchOpen)}
            aria-label="Search products"
          >
            <Search size={20} strokeWidth={1.8} />
          </button>

          <Link
            className="icon-btn desktop-action"
            to={user ? '/profile' : '/login'}
            aria-label="My Account"
          >
            <UserRound size={20} strokeWidth={1.8} />
          </Link>
        </div>
      </header>

      {searchOpen && <SearchBar onClose={() => setSearchOpen(false)} />}

      {/* Quick Donation Modal */}
      {donateOpen && (
        <div className="donate-modal-overlay" onClick={() => setDonateOpen(false)}>
          <div className="donate-modal" onClick={(e) => e.stopPropagation()}>
            <button className="donate-modal-close" onClick={() => setDonateOpen(false)} aria-label="Close">
              <X size={20} />
            </button>
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
              <div style={{ marginTop: '6px', color: '#666' }}>Direct UPI / Netbanking: <strong>bethany.mission@sbi</strong></div>
            </div>

            <a
              href={`https://wa.me/918000123456?text=${encodeURIComponent(`Hello Bethany Looms, I would like to make a contribution of ₹${donationAmount} to support the Bethany Leprosy Mission Association.`)}`}
              target="_blank"
              rel="noopener noreferrer"
              className="button full"
              style={{ background: 'var(--navy)', color: '#fff', height: '48px', fontSize: '15px' }}
            >
              Proceed to Donate ₹{donationAmount.toLocaleString('en-IN')}
            </a>
          </div>
        </div>
      )}
    </>
  );
}

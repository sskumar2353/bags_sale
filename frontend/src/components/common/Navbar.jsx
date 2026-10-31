import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Menu, X, Search, UserRound, ShoppingBag, Shield, Globe } from 'lucide-react';
import useAuth from '../../hooks/useAuth';
import useCart from '../../hooks/useCart';
import SearchBar from './SearchBar';
import { NAV_LINKS } from '../../utils/constants';

const NAV_LINKS_HI = [
  { label: 'टेक (TECH)', to: '/category/tech' },
  { label: 'कार्य आवश्यकताएं (WORK)', to: '/category/work-essentials' },
  { label: 'उपहार (GIFTING)', to: '/gifting', hasGiftBow: true },
  { label: 'कलेक्शंस (COLLECTIONS)', to: '/shop' },
  { label: 'नए आगमन (NEW)', to: '/shop?sort=newest' }
];

export default function Navbar() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [lang, setLang] = useState(() => localStorage.getItem('site_lang') || 'en');
  const { user, isAdmin } = useAuth();
  const { itemCount } = useCart();

  useEffect(() => {
    const saved = localStorage.getItem('site_lang') || 'en';
    document.documentElement.lang = saved;
  }, []);

  const toggleLanguage = () => {
    const nextLang = lang === 'en' ? 'hi' : 'en';
    setLang(nextLang);
    localStorage.setItem('site_lang', nextLang);
    document.documentElement.lang = nextLang;
  };

  const navItems = lang === 'hi' ? NAV_LINKS_HI : NAV_LINKS;

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

        {/* Brand Logo with DO geometric glyph + stacked Daily Objects */}
        <Link to="/" className="brand-logo" onClick={() => setMenuOpen(false)} aria-label="Daily Objects Home">
          <svg
            className="brand-glyph"
            width="38"
            height="22"
            viewBox="0 0 38 22"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            aria-hidden="true"
          >
            {/* Geometric D mark */}
            <path
              fillRule="evenodd"
              clipRule="evenodd"
              d="M0 0H9.5C14.7 0 19 4.3 19 9.5V12.5C19 17.7 14.7 22 9.5 22H0V0ZM5.5 5.5V16.5H9.5C11.7 16.5 13.5 14.7 13.5 12.5V9.5C13.5 7.3 11.7 5.5 9.5 5.5H5.5Z"
              fill="#000000"
            />
            {/* Geometric O top arc */}
            <path
              d="M21.5 9C21.5 4 25.5 0 30.5 0C35.5 0 39.5 4 39.5 9H34.5C34.5 6.5 32.7 4.8 30.5 4.8C28.3 4.8 26.5 6.5 26.5 9H21.5Z"
              fill="#000000"
            />
            {/* Geometric O bottom arc */}
            <path
              d="M21.5 13H26.5C26.5 15.5 28.3 17.2 30.5 17.2C32.7 17.2 34.5 15.5 34.5 13H39.5C39.5 18 35.5 22 30.5 22C25.5 22 21.5 18 21.5 13Z"
              fill="#000000"
            />
          </svg>
          <div className="brand-text">
            <span className="brand-daily">Daily</span>
            <span className="brand-objects">Objects</span>
          </div>
        </Link>

        {/* Center Nav Links */}
        <nav className={menuOpen ? 'nav open' : 'nav'}>
          {navItems.map((link) => (
            <Link
              key={link.label}
              to={link.to}
              className={link.hasGiftBow ? 'nav-item nav-item-gifting' : 'nav-item'}
              onClick={() => setMenuOpen(false)}
            >
              {link.hasGiftBow && (
                <span className="nav-gift-bow" aria-hidden="true">
                  <svg width="42" height="11" viewBox="0 0 42 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <line x1="0" y1="5.5" x2="16" y2="5.5" stroke="#2db58e" strokeWidth="1.6" strokeLinecap="round" />
                    <path
                      d="M21 5.5 C18 5.5, 16 1.8, 18.5 1.2 C20.2 0.8, 21.2 3.8, 21 5.5 Z"
                      stroke="#2db58e"
                      strokeWidth="1.4"
                      fill="none"
                    />
                    <path
                      d="M21 5.5 C24 5.5, 26 1.8, 23.5 1.2 C21.8 0.8, 20.8 3.8, 21 5.5 Z"
                      stroke="#2db58e"
                      strokeWidth="1.4"
                      fill="none"
                    />
                    <circle cx="21" cy="5.5" r="1.4" fill="#2db58e" />
                    <line x1="26" y1="5.5" x2="42" y2="5.5" stroke="#2db58e" strokeWidth="1.6" strokeLinecap="round" />
                  </svg>
                </span>
              )}
              <span className="nav-item-label">{link.label}</span>
            </Link>
          ))}

          {isAdmin && (
            <Link
              to="/admin/dashboard"
              className="nav-item admin-nav-link"
              onClick={() => setMenuOpen(false)}
              style={{ color: '#a98761', fontWeight: 'bold' }}
            >
              <Shield size={14} style={{ display: 'inline', marginRight: '4px' }} />
              ADMIN
            </Link>
          )}

          {/* Quick links in mobile drawer */}
          <div className="mobile-drawer-footer">
            <button
              className="mobile-lang-btn"
              onClick={toggleLanguage}
              type="button"
              aria-label={`Switch language. Current language: ${lang === 'en' ? 'English' : 'Hindi'}`}
            >
              <Globe size={16} />
              <span>{lang === 'en' ? 'भाषा: हिंदी में बदलें' : 'Language: Switch to English'}</span>
            </button>
            <Link to="/wishlist" onClick={() => setMenuOpen(false)}>Wishlist</Link>
            <Link to={user ? '/profile' : '/login'} onClick={() => setMenuOpen(false)}>
              {user ? 'My Account' : 'Sign In'}
            </Link>
          </div>
        </nav>

        {/* Right Action Icons matching screenshot: Language Switcher, Search, Profile, Shopping Bag */}
        <div className="header-actions">
          <button
            className="lang-switcher-pill"
            onClick={toggleLanguage}
            type="button"
            aria-label={`Current language: ${lang === 'en' ? 'English' : 'Hindi'}. Click to switch.`}
            title="Toggle English / हिंदी"
          >
            <Globe size={15} />
            <span className="lang-text">{lang === 'en' ? 'EN' : 'हिं'}</span>
          </button>

          <button
            className="icon-btn"
            onClick={() => setSearchOpen(!searchOpen)}
            aria-label="Search products"
          >
            <Search size={22} strokeWidth={1.8} />
          </button>

          <Link
            className="icon-btn desktop-action"
            to={user ? '/profile' : '/login'}
            aria-label="My Account"
          >
            <UserRound size={22} strokeWidth={1.8} />
          </Link>

          <Link className="icon-btn cart-btn" to="/cart" aria-label="Shopping Cart">
            <ShoppingBag size={22} strokeWidth={1.8} />
            {itemCount > 0 && <span className="count">{itemCount}</span>}
          </Link>
        </div>
      </header>

      {searchOpen && <SearchBar onClose={() => setSearchOpen(false)} />}
    </>
  );
}

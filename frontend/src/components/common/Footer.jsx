import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, Camera, Mail, Phone, Clock, FileText, MessageSquareQuote } from 'lucide-react';

export default function Footer() {
  const [subscribed, setSubscribed] = useState(false);

  return (
    <footer className="footer">
      <div className="footer-top">
        {/* Brand Information */}
        <div className="footer-brand">
          <Link className="wordmark footer-logo" to="/" aria-label="Daily Objects Home">
            daily<span>objects</span><i>.</i>
          </Link>
          <p style={{ margin: '8px 0 16px', lineHeight: '1.6' }}>
            Thoughtful bags and everyday carry, designed for life in motion.
          </p>
          <a
            className="social-link"
            href="https://www.instagram.com/"
            target="_blank"
            rel="noreferrer"
            aria-label="Follow Daily Objects on Instagram"
          >
            <Camera size={16} /> Follow along on Instagram
          </a>
        </div>

        {/* Column 1: Bags & Accessories */}
        <div className="footer-col">
          <h3 className="footer-heading">BAGS & ACCESSORIES</h3>
          <ul className="footer-links-list">
            <li><Link to="/category/tote-bags">TOTE BAGS</Link></li>
            <li><Link to="/category/crossbody-bags">CROSSBODY BAGS</Link></li>
            <li><Link to="/category/backpacks">BACKPACKS</Link></li>
            <li><Link to="/category/messenger-laptop-bags">MESSENGER BAGS</Link></li>
            <li><Link to="/category/phone-bags">PHONE BAGS</Link></li>
            <li><Link to="/category/wallets">WALLETS</Link></li>
            <li><Link to="/category/duffle-bags">DUFFLE BAGS</Link></li>
            <li><Link to="/category/pouches">POUCHES</Link></li>
            <li><Link to="/category/bag-accessories">BAGS ACCESSORIES</Link></li>
          </ul>
        </div>

        {/* Column 2: Customer Care with Direct Contact Details (UX4G & GIGW compliance) */}
        <div className="footer-col">
          <h3 className="footer-heading">CUSTOMER CARE</h3>
          <div className="footer-direct-contact" style={{ marginBottom: '14px', fontSize: '13px', lineHeight: '1.7' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
              <Mail size={15} color="#2db58e" />
              <a href="mailto:support@dailyobjects.example" style={{ color: 'inherit', textDecoration: 'underline' }}>
                support@dailyobjects.example
              </a>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
              <Phone size={15} color="#2db58e" />
              <a href="tel:+918000123456" style={{ color: 'inherit', textDecoration: 'underline' }}>
                +91 8000 123 456
              </a>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '11.5px', color: '#888' }}>
              <Clock size={13} /> Mon–Sat: 10:00 AM – 7:00 PM IST
            </div>
          </div>

          <ul className="footer-links-list">
            <li><Link to="/pages/contact-us">Contact Us</Link></li>
            <li><Link to="/pages/feedback">Feedback</Link></li>
            <li><Link to="/pages/shipping">Shipping & Delivery</Link></li>
            <li><Link to="/pages/returns">Returns & Exchanges</Link></li>
            <li><Link to="/pages/faqs">FAQs</Link></li>
            <li><Link to="/pages/sitemap">HTML Sitemap</Link></li>
          </ul>
        </div>

        {/* Column 3: Company */}
        <div className="footer-col">
          <h3 className="footer-heading">COMPANY</h3>
          <ul className="footer-links-list">
            <li><Link to="/">Home</Link></li>
            <li><Link to="/pages/about-us">About Us</Link></li>
            <li><Link to="/pages/privacy-policy">Privacy Policy</Link></li>
            <li><Link to="/pages/terms-and-conditions">Terms & Conditions</Link></li>
            <li><Link to="/pages/feedback">Give Feedback</Link></li>
            <li><Link to="/pages/sitemap">Site Directory</Link></li>
          </ul>
        </div>

        {/* Column 4: Newsletter */}
        <div className="footer-col footer-news">
          <h3 className="footer-heading">STAY IN THE LOOP</h3>
          <p style={{ fontSize: '13px', margin: '6px 0 12px', color: '#777' }}>
            New drops, thoughtful carry designs, and mystery gifts.
          </p>

          <form
            className="newsletter"
            onSubmit={(e) => {
              e.preventDefault();
              setSubscribed(true);
              e.currentTarget.reset();
            }}
          >
            {/* Visible Persistent Input Label (UX4G Form compliance) */}
            <label htmlFor="footer-newsletter-email" className="footer-newsletter-label">
              Email address
            </label>
            <div className="newsletter-input-group">
              <input
                id="footer-newsletter-email"
                type="email"
                placeholder="name@example.com"
                aria-label="Email address for newsletter"
                required
              />
              <button type="submit" aria-label="Subscribe to newsletter">
                <ArrowRight size={18} />
              </button>
            </div>
          </form>
          {subscribed && <span className="subscribe-confirm">Thanks for joining our list.</span>}
        </div>
      </div>

      <div className="footer-bottom">
        <span>© 2026 Daily Objects Design Lab Pvt. Ltd. Made for everyday.</span>
        <span>Designed for life in motion</span>
      </div>
    </footer>
  );
}

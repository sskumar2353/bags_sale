import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Mail, Phone, MapPin, Heart, ShieldCheck, ArrowRight } from 'lucide-react';

export default function Footer() {
  const [newsletterEmail, setNewsletterEmail] = useState('');
  const [subscribed, setSubscribed] = useState(false);

  const handleSubscribe = (e) => {
    e.preventDefault();
    if (newsletterEmail) {
      setSubscribed(true);
      setNewsletterEmail('');
    }
  };

  return (
    <footer className="footer-bethany">
      <div className="footer-bethany-container">
        {/* Column 1: Brand & Registration */}
        <div className="footer-bethany-col brand-col">
          <Link to="/" className="footer-brand-title" aria-label="Bethany Looms Home">
            Bethany Looms
          </Link>
          <p className="footer-brand-sub">
            A project of Bethany Leprosy Mission Association.
          </p>
          <div className="footer-trust-tags">
            <span>[Registration no. AP-BLMA-1984]</span>
            <span>[80G & 12A Tax Exempt]</span>
            <span>[FCRA Approved]</span>
          </div>
          <p className="footer-mission-statement">
            Every bag is handwoven by people affected by leprosy and elders in our care. Your purchase gives them dignity, income and a future.
          </p>
        </div>

        {/* Column 2: Contact */}
        <div className="footer-bethany-col">
          <h3 className="footer-bethany-heading">Contact</h3>
          <div className="footer-contact-details">
            <p>
              <strong>[Address]</strong><br />
              Bethany Mission Campus, Bapatla / Hyderabad,<br />
              Andhra Pradesh & Telangana, India
            </p>
            <p>
              <strong>[Phone & WhatsApp]</strong><br />
              <a href="tel:+918000123456">+91 8000 123 456</a> · <a href="https://wa.me/918000123456" target="_blank" rel="noreferrer">WhatsApp orders</a>
            </p>
            <p>
              <strong>[Email]</strong><br />
              <a href="mailto:care@bethanylooms.org">care@bethanylooms.org</a>
            </p>
          </div>
        </div>

        {/* Column 3: Pay with & Policies */}
        <div className="footer-bethany-col">
          <h3 className="footer-bethany-heading">Pay with</h3>
          <p className="pay-methods-text">UPI · Cards · Net banking</p>
          <ul className="footer-bethany-links">
            <li><Link to="/pages/shipping">Shipping & Delivery</Link></li>
            <li><Link to="/pages/returns">Returns & Exchanges</Link></li>
            <li><Link to="/pages/privacy-policy">Privacy Policy</Link></li>
            <li><Link to="/pages/terms-and-conditions">Terms & Conditions</Link></li>
            <li><Link to="/pages/feedback">Feedback</Link></li>
            <li><Link to="/pages/sitemap">HTML Sitemap</Link></li>
          </ul>
        </div>

        {/* Column 4: Language & Mission updates */}
        <div className="footer-bethany-col">
          <h3 className="footer-bethany-heading">Language</h3>
          <p className="lang-text-footer">
            <span style={{ fontWeight: 600 }}>English</span> · <span style={{ fontWeight: 600 }}>తెలుగు</span>
          </p>
          
          <h4 className="footer-bethany-subheading" style={{ marginTop: '20px' }}>Stay in touch</h4>
          <p style={{ fontSize: '13px', color: '#a0aec0', margin: '6px 0 12px' }}>
            Updates on artisan stories, new handwoven batches, and our mission.
          </p>
          <form onSubmit={handleSubscribe} className="footer-bethany-form">
            <input
              type="email"
              value={newsletterEmail}
              onChange={(e) => setNewsletterEmail(e.target.value)}
              placeholder="Your email address"
              aria-label="Email address for mission newsletter"
              required
            />
            <button type="submit" aria-label="Subscribe">
              <ArrowRight size={16} />
            </button>
          </form>
          {subscribed && <span className="footer-sub-success">Thank you for supporting our artisans!</span>}
        </div>
      </div>

      <div className="footer-bethany-bottom">
        <div className="footer-bottom-container">
          <span>© 2026 Bethany Looms · Bethany Leprosy Mission Association. All rights reserved.</span>
          <span>Skill has no stigma. Dignity can be woven back.</span>
        </div>
      </div>
    </footer>
  );
}

import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, Camera } from 'lucide-react';

export default function Footer() {
  const [subscribed, setSubscribed] = useState(false);

  const cols = [
    {
      title: 'BAGS & ACCESSORIES',
      links: [
        ['TOTE BAGS', '/category/tote-bags'],
        ['CROSSBODY BAGS', '/category/crossbody-bags'],
        ['BACKPACKS', '/category/backpacks'],
        ['MESSENGER BAGS', '/category/messenger-laptop-bags'],
        ['PHONE BAGS', '/category/phone-bags'],
        ['WALLETS', '/category/wallets'],
        ['DUFFLE BAGS', '/category/duffle-bags'],
        ['POUCHES', '/category/pouches'],
        ['BAGS ACCESSORIES', '/category/bag-accessories']
      ]
    },
    {
      title: 'CUSTOMER CARE',
      links: [
        ['Contact Us', '/pages/contact-us'],
        ['Shipping', '/pages/shipping'],
        ['Returns', '/pages/returns'],
        ['FAQs', '/pages/faqs']
      ]
    },
    {
      title: 'COMPANY',
      links: [
        ['About Us', '/pages/about-us'],
        ['Privacy Policy', '/pages/privacy-policy'],
        ['Terms & Conditions', '/pages/terms-and-conditions']
      ]
    }
  ];

  return (
    <footer className="footer">
      <div className="footer-top">
        <div className="footer-brand">
          <Link className="wordmark footer-logo" to="/">
            daily<span>objects</span><i>.</i>
          </Link>
          <p>Carry a little more of what matters.</p>
          <a
            className="social-link"
            href="https://www.instagram.com/"
            target="_blank"
            rel="noreferrer"
          >
            <Camera size={15} /> Follow along on Instagram
          </a>
        </div>

        {cols.map((col) => (
          <div key={col.title}>
            <h4>{col.title}</h4>
            {col.links.map(([label, to]) => (
              <Link key={label} to={to}>
                {label}
              </Link>
            ))}
          </div>
        ))}

        <div className="footer-news">
          <h4>STAY IN THE LOOP</h4>
          <p>New drops, thoughtful things, occasionally.</p>
          <form
            className="newsletter"
            onSubmit={(e) => {
              e.preventDefault();
              setSubscribed(true);
              e.currentTarget.reset();
            }}
          >
            <input
              type="email"
              placeholder="Your email address"
              aria-label="Your email address"
              required
            />
            <button aria-label="Subscribe">
              <ArrowRight size={18} />
            </button>
          </form>
          {subscribed && <span className="subscribe-confirm">Thanks for joining our list.</span>}
        </div>
      </div>

      <div className="footer-bottom">
        <span>© 2026 Daily Objects. Made for everyday.</span>
        <span>
          Designed for life in motion <Camera size={14} />
        </span>
      </div>
    </footer>
  );
}

import { useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { ArrowRight, CheckCircle2, Star, Mail, Phone, MapPin, Compass, ShieldCheck, HeartHandshake } from 'lucide-react';

export default function InformationPage() {
  const { slug } = useParams();

  // Feedback form state
  const [feedbackSubmitted, setFeedbackSubmitted] = useState(false);
  const [rating, setRating] = useState(5);
  const [feedbackCategory, setFeedbackCategory] = useState('Product Quality');
  const [feedbackText, setFeedbackText] = useState('');
  const [feedbackName, setFeedbackName] = useState('');
  const [feedbackEmail, setFeedbackEmail] = useState('');

  const handleFeedbackSubmit = (e) => {
    e.preventDefault();
    setFeedbackSubmitted(true);
  };

  const pages = {
    'contact-us': {
      title: 'Contact Us',
      eyebrow: 'CUSTOMER CARE · WE’RE HERE FOR YOU',
      render: () => (
        <div style={{ maxWidth: '680px' }}>
          <p style={{ fontSize: '16px', lineHeight: '1.7', color: '#444', marginBottom: '24px' }}>
            We are always here to assist with your inquiries, order status, custom monogramming, or after-sales care.
          </p>
          <div style={{ background: '#f7f6f2', padding: '24px', borderRadius: '8px', marginBottom: '28px', border: '1px solid #e5e3dc' }}>
            <h2 style={{ fontSize: '18px', marginBottom: '16px', fontWeight: 600 }}>Direct Contact Information</h2>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '14px', fontSize: '15px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <Mail size={18} color="#2db58e" />
                <span>Email: <a href="mailto:support@dailyobjects.example" style={{ textDecoration: 'underline', color: 'inherit' }}>support@dailyobjects.example</a></span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <Phone size={18} color="#2db58e" />
                <span>Phone: <a href="tel:+918000123456" style={{ textDecoration: 'underline', color: 'inherit' }}>+91 8000 123 456</a></span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                <MapPin size={18} color="#2db58e" />
                <span>Corporate Office: Daily Objects Design Lab Pvt. Ltd., Okhla Industrial Area, Phase-III, New Delhi 110020, India</span>
              </div>
            </div>
          </div>
          <a className="button button-dark" href="mailto:support@dailyobjects.example" style={{ display: 'inline-flex', alignItems: 'center', gap: '8px' }}>
            Send Us an Email <ArrowRight size={16} />
          </a>
        </div>
      )
    },
    'about-us': {
      title: 'About Daily Objects',
      eyebrow: 'OBJECTS FOR LIFE IN MOTION',
      render: () => (
        <div style={{ maxWidth: '780px' }}>
          <p style={{ fontSize: '18px', lineHeight: '1.7', color: '#222', marginBottom: '24px', fontWeight: 500 }}>
            Daily Objects crafts thoughtfully designed bags, sleeves, and accessories made to elevate every transition of your workday and weekend.
          </p>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '20px', margin: '32px 0' }}>
            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '24px', borderRadius: '8px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '12px' }}>
                <Compass size={22} color="#9a764d" />
                <h2 style={{ fontSize: '18px', margin: 0, fontWeight: 700 }}>Our Mission</h2>
              </div>
              <p style={{ fontSize: '14px', lineHeight: '1.6', color: '#555' }}>
                To create utilitarian, enduring carry essentials that seamlessly bridge minimalist aesthetics, functional organization, and resilient modern materials.
              </p>
            </div>

            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '24px', borderRadius: '8px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '12px' }}>
                <HeartHandshake size={22} color="#2db58e" />
                <h2 style={{ fontSize: '18px', margin: 0, fontWeight: 700 }}>Our Vision</h2>
              </div>
              <p style={{ fontSize: '14px', lineHeight: '1.6', color: '#555' }}>
                To establish India's premier homegrown design studio for everyday lifestyle goods, setting global benchmarks for durability, customer delight, and ethical production.
              </p>
            </div>
          </div>

          <div style={{ background: '#f7f6f2', padding: '24px', borderRadius: '8px', border: '1px solid #e5e3dc', marginTop: '24px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '10px' }}>
              <ShieldCheck size={20} color="#121212" />
              <h2 style={{ fontSize: '17px', margin: 0, fontWeight: 700 }}>Operating Entity & Corporate Governance</h2>
            </div>
            <p style={{ fontSize: '14px', lineHeight: '1.6', color: '#444' }}>
              <strong>Daily Objects Design Lab Pvt. Ltd.</strong> is a registered Indian private limited company incorporated under the Companies Act, 2013. We maintain full compliance with Ministry of Electronics and Information Technology (MeitY) guidelines, Consumer Protection E-Commerce Rules, and WCAG accessibility standards.
            </p>
          </div>
        </div>
      )
    },
    feedback: {
      title: 'Customer Feedback & Suggestions',
      eyebrow: 'HELP US SERVE YOU BETTER',
      render: () => (
        <div style={{ maxWidth: '640px' }}>
          <p style={{ fontSize: '15px', lineHeight: '1.6', color: '#555', marginBottom: '24px' }}>
            Your feedback directly guides our design decisions, packaging enhancements, and customer support. Please share your thoughts below.
          </p>

          {feedbackSubmitted ? (
            <div style={{ background: '#e8f5e9', border: '1px solid #a5d6a7', borderRadius: '8px', padding: '28px', textAlign: 'center' }}>
              <CheckCircle2 size={42} color="#2e7d32" style={{ margin: '0 auto 12px' }} />
              <h2 style={{ fontSize: '20px', color: '#1b5e20', marginBottom: '8px', fontWeight: 700 }}>Thank you for your feedback!</h2>
              <p style={{ fontSize: '14px', color: '#2e7d32', marginBottom: '20px' }}>
                Your insights have been logged with our customer experience team (Ticket ID: DO-{(Math.random() * 90000 + 10000).toFixed(0)}).
              </p>
              <button
                type="button"
                className="button button-dark"
                onClick={() => {
                  setFeedbackSubmitted(false);
                  setFeedbackText('');
                }}
              >
                Submit another response
              </button>
            </div>
          ) : (
            <form onSubmit={handleFeedbackSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '18px' }}>
              <div>
                <label style={{ display: 'block', fontSize: '13px', fontWeight: 700, marginBottom: '6px' }}>
                  Rate your experience (1 to 5 stars)
                </label>
                <div style={{ display: 'flex', gap: '8px' }}>
                  {[1, 2, 3, 4, 5].map((star) => (
                    <button
                      key={star}
                      type="button"
                      onClick={() => setRating(star)}
                      aria-label={`Rate ${star} star${star > 1 ? 's' : ''}`}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        cursor: 'pointer',
                        padding: '4px'
                      }}
                    >
                      <Star
                        size={28}
                        fill={star <= rating ? '#f59e0b' : 'none'}
                        color={star <= rating ? '#f59e0b' : '#9ca3af'}
                      />
                    </button>
                  ))}
                </div>
              </div>

              <div>
                <label htmlFor="fb-category" style={{ display: 'block', fontSize: '13px', fontWeight: 700, marginBottom: '6px' }}>
                  Feedback Category
                </label>
                <select
                  id="fb-category"
                  value={feedbackCategory}
                  onChange={(e) => setFeedbackCategory(e.target.value)}
                  style={{ width: '100%', height: '44px', padding: '0 12px', border: '1px solid #ccc', borderRadius: '4px', background: '#fff' }}
                >
                  <option value="Product Quality">Product Quality & Craftsmanship</option>
                  <option value="Website & Ordering">Website & Ordering Experience</option>
                  <option value="Delivery & Packaging">Shipping, Delivery & Packaging</option>
                  <option value="Customer Support">Customer Care & Support</option>
                  <option value="Other Suggestions">New Feature / Product Suggestion</option>
                </select>
              </div>

              <div>
                <label htmlFor="fb-name" style={{ display: 'block', fontSize: '13px', fontWeight: 700, marginBottom: '6px' }}>
                  Your Name (Optional)
                </label>
                <input
                  id="fb-name"
                  type="text"
                  placeholder="e.g. Priyanshu Sharma"
                  value={feedbackName}
                  onChange={(e) => setFeedbackName(e.target.value)}
                  style={{ width: '100%', height: '44px', padding: '0 12px', border: '1px solid #ccc', borderRadius: '4px' }}
                />
              </div>

              <div>
                <label htmlFor="fb-email" style={{ display: 'block', fontSize: '13px', fontWeight: 700, marginBottom: '6px' }}>
                  Email Address
                </label>
                <input
                  id="fb-email"
                  type="email"
                  required
                  placeholder="name@example.com"
                  value={feedbackEmail}
                  onChange={(e) => setFeedbackEmail(e.target.value)}
                  style={{ width: '100%', height: '44px', padding: '0 12px', border: '1px solid #ccc', borderRadius: '4px' }}
                />
              </div>

              <div>
                <label htmlFor="fb-comments" style={{ display: 'block', fontSize: '13px', fontWeight: 700, marginBottom: '6px' }}>
                  Your Comments or Suggestions
                </label>
                <textarea
                  id="fb-comments"
                  required
                  rows={4}
                  placeholder="Tell us what you loved or how we can improve..."
                  value={feedbackText}
                  onChange={(e) => setFeedbackText(e.target.value)}
                  style={{ width: '100%', padding: '12px', border: '1px solid #ccc', borderRadius: '4px', resize: 'vertical' }}
                />
              </div>

              <button type="submit" className="button button-dark" style={{ height: '48px', fontSize: '15px', fontWeight: 600 }}>
                Submit Feedback
              </button>
            </form>
          )}
        </div>
      )
    },
    sitemap: {
      title: 'HTML Sitemap & Directory',
      eyebrow: 'COMPLETE STORE DIRECTORY',
      render: () => (
        <div style={{ maxWidth: '900px' }}>
          <p style={{ fontSize: '15px', lineHeight: '1.6', color: '#555', marginBottom: '28px' }}>
            Browse all public pages, category collections, customer support policies, and company information.
          </p>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))', gap: '32px' }}>
            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '20px', borderRadius: '8px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, marginBottom: '14px', borderBottom: '1px solid #e5e3dc', paddingBottom: '8px' }}>
                Main Pages & Storefront
              </h2>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '10px' }}>
                <li><Link to="/" style={{ color: '#121212', textDecoration: 'underline' }}>Home Page</Link></li>
                <li><Link to="/shop" style={{ color: '#121212', textDecoration: 'underline' }}>Shop All Bags</Link></li>
                <li><Link to="/shop?sort=newest" style={{ color: '#121212', textDecoration: 'underline' }}>New Arrivals</Link></li>
                <li><Link to="/gifting" style={{ color: '#121212', textDecoration: 'underline' }}>Gifting & Bundles</Link></li>
                <li><Link to="/cart" style={{ color: '#121212', textDecoration: 'underline' }}>Shopping Bag</Link></li>
                <li><Link to="/wishlist" style={{ color: '#121212', textDecoration: 'underline' }}>Saved Wishlist</Link></li>
              </ul>
            </div>

            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '20px', borderRadius: '8px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, marginBottom: '14px', borderBottom: '1px solid #e5e3dc', paddingBottom: '8px' }}>
                Carry Categories
              </h2>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '10px' }}>
                <li><Link to="/category/tote-bags" style={{ color: '#121212', textDecoration: 'underline' }}>Tote Bags</Link></li>
                <li><Link to="/category/crossbody-bags" style={{ color: '#121212', textDecoration: 'underline' }}>Crossbody Bags</Link></li>
                <li><Link to="/category/backpacks" style={{ color: '#121212', textDecoration: 'underline' }}>Backpacks</Link></li>
                <li><Link to="/category/messenger-laptop-bags" style={{ color: '#121212', textDecoration: 'underline' }}>Messenger & Laptop Bags</Link></li>
                <li><Link to="/category/phone-bags" style={{ color: '#121212', textDecoration: 'underline' }}>Phone Bags</Link></li>
                <li><Link to="/category/wallets" style={{ color: '#121212', textDecoration: 'underline' }}>Wallets & Cardholders</Link></li>
                <li><Link to="/category/duffle-bags" style={{ color: '#121212', textDecoration: 'underline' }}>Duffle Bags</Link></li>
                <li><Link to="/category/pouches" style={{ color: '#121212', textDecoration: 'underline' }}>Pouches & Organizers</Link></li>
              </ul>
            </div>

            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '20px', borderRadius: '8px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, marginBottom: '14px', borderBottom: '1px solid #e5e3dc', paddingBottom: '8px' }}>
                Customer Care & Help
              </h2>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '10px' }}>
                <li><Link to="/pages/contact-us" style={{ color: '#121212', textDecoration: 'underline' }}>Contact Customer Care</Link></li>
                <li><Link to="/pages/feedback" style={{ color: '#121212', textDecoration: 'underline' }}>Customer Feedback Form</Link></li>
                <li><Link to="/pages/shipping" style={{ color: '#121212', textDecoration: 'underline' }}>Shipping & Delivery Policy</Link></li>
                <li><Link to="/pages/returns" style={{ color: '#121212', textDecoration: 'underline' }}>Returns & Exchanges</Link></li>
                <li><Link to="/pages/faqs" style={{ color: '#121212', textDecoration: 'underline' }}>Frequently Asked Questions</Link></li>
                <li><a href="/robots.txt" style={{ color: '#121212', textDecoration: 'underline' }}>Robots.txt</a></li>
                <li><a href="/sitemap.xml" style={{ color: '#121212', textDecoration: 'underline' }}>XML Sitemap (Search Engines)</a></li>
              </ul>
            </div>

            <div style={{ background: '#fbfbfa', border: '1px solid #e5e3dc', padding: '20px', borderRadius: '8px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, marginBottom: '14px', borderBottom: '1px solid #e5e3dc', paddingBottom: '8px' }}>
                Company & Policies
              </h2>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '10px' }}>
                <li><Link to="/pages/about-us" style={{ color: '#121212', textDecoration: 'underline' }}>About Daily Objects</Link></li>
                <li><Link to="/pages/privacy-policy" style={{ color: '#121212', textDecoration: 'underline' }}>Privacy Policy</Link></li>
                <li><Link to="/pages/terms-and-conditions" style={{ color: '#121212', textDecoration: 'underline' }}>Terms & Conditions</Link></li>
              </ul>
            </div>
          </div>
        </div>
      )
    },
    shipping: {
      title: 'Shipping & Delivery Policy',
      eyebrow: 'DAILY OBJECTS · FULFILLMENT',
      render: () => (
        <div style={{ maxWidth: '640px' }}>
          <p style={{ fontSize: '16px', lineHeight: '1.7', color: '#444', marginBottom: '16px' }}>
            All domestic orders above ₹1,499 receive complimentary express shipping across India. Standard delivery takes 2–4 business days depending on your postal code.
          </p>
          <p style={{ fontSize: '15px', lineHeight: '1.6', color: '#666' }}>
            We partner with verified express logistics providers (BlueDart, Delhivery, XpressBees) with real-time SMS and email tracking updates.
          </p>
        </div>
      )
    },
    returns: {
      title: 'Easy Returns & Exchanges',
      eyebrow: 'DAILY OBJECTS · 7-DAY PROMISE',
      render: () => (
        <div style={{ maxWidth: '640px' }}>
          <p style={{ fontSize: '16px', lineHeight: '1.7', color: '#444', marginBottom: '16px' }}>
            We offer a 7-day hassle-free return window for all unused carry pieces in their original packaging with tags intact.
          </p>
          <p style={{ fontSize: '15px', lineHeight: '1.6', color: '#666' }}>
            Once your return request is submitted, our courier executive will schedule a doorstep pickup within 24–48 hours. Refunds are credited to the original payment source or UPI within 3 business days of receipt.
          </p>
        </div>
      )
    },
    faqs: {
      title: 'Frequently Asked Questions',
      eyebrow: 'HELP CENTER & COMMON ANSWERS',
      render: () => (
        <div style={{ maxWidth: '680px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
          <div style={{ border: '1px solid #e5e3dc', borderRadius: '6px', padding: '16px' }}>
            <h2 style={{ fontSize: '16px', fontWeight: 600, marginBottom: '6px' }}>How can I track my order?</h2>
            <p style={{ fontSize: '14px', color: '#555', margin: 0 }}>Sign in to your account and open My Orders, or check the shipment tracking link sent to your registered email and mobile number.</p>
          </div>
          <div style={{ border: '1px solid #e5e3dc', borderRadius: '6px', padding: '16px' }}>
            <h2 style={{ fontSize: '16px', fontWeight: 600, marginBottom: '6px' }}>Are your bags water-resistant?</h2>
            <p style={{ fontSize: '14px', color: '#555', margin: 0 }}>Yes, our premium canvas and technical ballistic nylon fabrics feature a water-repellent coating designed to withstand rain and spills.</p>
          </div>
          <div style={{ border: '1px solid #e5e3dc', borderRadius: '6px', padding: '16px' }}>
            <h2 style={{ fontSize: '16px', fontWeight: 600, marginBottom: '6px' }}>What payment methods are supported?</h2>
            <p style={{ fontSize: '14px', color: '#555', margin: 0 }}>We accept UPI (Google Pay, PhonePe, Paytm, BHIM), all major Credit & Debit cards (Visa, Mastercard, RuPay), Netbanking, and PayLater.</p>
          </div>
        </div>
      )
    },
    'privacy-policy': {
      title: 'Privacy Policy',
      eyebrow: 'DATA PROTECTION & ENCRYPTION',
      render: () => (
        <div style={{ maxWidth: '680px' }}>
          <p style={{ fontSize: '15px', lineHeight: '1.7', color: '#444', marginBottom: '14px' }}>
            We respect your privacy. Customer information is securely encrypted with 256-bit SSL encryption and used strictly for order fulfillment, fraud prevention, and account maintenance.
          </p>
          <p style={{ fontSize: '14px', lineHeight: '1.6', color: '#666' }}>
            We do not sell, rent, or trade your personal data with third-party advertising brokers. You may request account or data deletion at any time by contacting our data protection officer at support@dailyobjects.example.
          </p>
        </div>
      )
    },
    'terms-and-conditions': {
      title: 'Terms & Conditions',
      eyebrow: 'LEGAL & SERVICE AGREEMENT',
      render: () => (
        <div style={{ maxWidth: '680px' }}>
          <p style={{ fontSize: '15px', lineHeight: '1.7', color: '#444', marginBottom: '14px' }}>
            All product pricing and availability are updated in real-time. Orders are officially confirmed upon server verification of payment.
          </p>
          <p style={{ fontSize: '14px', lineHeight: '1.6', color: '#666' }}>
            All disputes are subject to the exclusive jurisdiction of the competent courts in New Delhi, India. Daily Objects reserves the right to cancel suspicious orders or orders placed with fraudulent credentials.
          </p>
        </div>
      )
    }
  };

  const page = pages[slug] || {
    title: 'Information',
    eyebrow: 'DAILY OBJECTS · CUSTOMER CARE',
    render: () => (
      <p style={{ color: '#555' }}>
        This page is being updated. Contact support@dailyobjects.example for immediate assistance.
      </p>
    )
  };

  return (
    <main id="main-content" tabIndex="-1" className="page information-page" style={{ paddingTop: '28px', minHeight: '60vh' }}>
      <span className="eyebrow">{page.eyebrow}</span>
      <h1 style={{ fontSize: 'clamp(28px, 4vw, 38px)', margin: '8px 0 20px', fontWeight: 700 }}>
        {page.title}
      </h1>

      {page.render()}

      <div style={{ marginTop: '36px', paddingTop: '20px', borderTop: '1px solid #e5e3dc' }}>
        <Link className="text-link" to="/shop" style={{ display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
          Continue shopping <ArrowRight size={16} />
        </Link>
      </div>
    </main>
  );
}

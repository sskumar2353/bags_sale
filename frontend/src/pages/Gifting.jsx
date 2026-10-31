import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Gift, Sparkles, Check, ArrowRight, PackageCheck, Heart, ShoppingBag } from 'lucide-react';
import ProductGrid from '../components/products/ProductGrid';
import productService from '../services/productService';
import '../styles/gifting.css';

export default function Gifting() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [unboxed, setUnboxed] = useState(false);
  const [boxShaking, setBoxShaking] = useState(false);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    let isMounted = true;
    async function loadGiftingProducts() {
      try {
        setLoading(true);
        const data = await productService.getProducts({ category: 'gifting' });
        if (isMounted) setProducts(data);
      } catch (err) {
        console.error('Failed to load gifting products', err);
      } finally {
        if (isMounted) setLoading(false);
      }
    }
    loadGiftingProducts();
    return () => {
      isMounted = false;
    };
  }, []);

  const handleUnbox = () => {
    if (unboxed) return;
    setBoxShaking(true);
    setTimeout(() => {
      setBoxShaking(false);
      setUnboxed(true);
    }, 850);
  };

  const handleCopyCode = () => {
    navigator.clipboard.writeText('MYSTERY4499');
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <main className="gifting-page">
      {/* Hero with Motion Graphics Ribbon Animation */}
      <section className="gifting-hero">
        <div className="motion-sparkles-container" aria-hidden="true">
          <span className="sparkle s1">✦</span>
          <span className="sparkle s2">✧</span>
          <span className="sparkle s3">✦</span>
          <span className="sparkle s4">✧</span>
          <span className="sparkle s5">✦</span>
        </div>

        <div className="gifting-hero-content">
          <div className="gifting-badge-tag">
            <Gift size={14} className="gift-pulse-icon" />
            <span>BETHANY LOOMS GIFT STUDIO</span>
          </div>

          <h1 className="gifting-title">
            Gifting that <span>means more</span>
          </h1>

          <p className="gifting-subtitle">
            Weddings, housewarmings, festivals, corporate gifts and return gifts. A Bethany Looms gift says, "I chose something beautiful and kind." Custom bulk orders welcome.
          </p>

          {/* Interactive 3D Gift Box with Motion Graphics */}
          <div className="gift-unbox-station">
            <div
              className={`interactive-gift-box ${boxShaking ? 'shaking' : ''} ${unboxed ? 'opened' : ''}`}
              onClick={handleUnbox}
              role="button"
              tabIndex={0}
              aria-label="Tap to open mystery gift"
            >
              <div className="box-lid">
                <div className="lid-ribbon-loop">
                  <span className="bow-knot" />
                </div>
              </div>
              <div className="box-body">
                <div className="body-ribbon-v" />
                <div className="body-ribbon-h" />
              </div>

              {/* Floating Confetti Particle Burst */}
              {unboxed && (
                <div className="confetti-burst" aria-hidden="true">
                  <span className="confetti c1" />
                  <span className="confetti c2" />
                  <span className="confetti c3" />
                  <span className="confetti c4" />
                  <span className="confetti c5" />
                  <span className="confetti c6" />
                </div>
              )}
            </div>

            {!unboxed ? (
              <button className="unbox-trigger-btn" onClick={handleUnbox}>
                <Sparkles size={16} /> Tap Gift Box to Reveal Reward
              </button>
            ) : (
              <div className="reward-reveal-card">
                <span className="reward-congrats">🎉 MYSTERY GIFT UNLOCKED!</span>
                <h3>Free Mystery Gift + ₹500 Off</h3>
                <p>Applied automatically on checkout for all orders above ₹4,499.</p>
                <div className="promo-code-pill" onClick={handleCopyCode}>
                  <code>MYSTERY4499</code>
                  <button className="copy-btn">{copied ? <Check size={14} /> : 'COPY'}</button>
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Curated Gifting Categories Showcase */}
      <section className="section gifting-collections-section">
        <div className="section-heading">
          <div>
            <span className="eyebrow">CURATED GIFT EDITS</span>
            <h2>Handpicked for Every Persona</h2>
          </div>
          <Link to="/shop" className="text-link">
            Explore all gifts <ArrowRight size={16} />
          </Link>
        </div>

        <div className="gifting-persona-grid">
          <div className="persona-card card-commuter">
            <div className="persona-copy">
              <span>FOR COMMUTERS</span>
              <h3>The Workpack & Briefcase Duo</h3>
              <p>Water-repellent technical protection for daily urban transit.</p>
              <Link to="/category/messenger-laptop-bags" className="persona-link">
                Shop Work Gifts <ArrowRight size={14} />
              </Link>
            </div>
            <img
              src="https://images.dailyobjects.com/marche/product-images/1202/clove-city-compact-messenger-bag-images/Clove-City-Compact-Fleet-Messenger-Bag.png?tr=cm-pad_resize,v-3"
              alt="Commuter Gift Set"
              loading="lazy"
            />
          </div>

          <div className="persona-card card-minimalist">
            <div className="persona-copy">
              <span>FOR MINIMALISTS</span>
              <h3>Sculpted Slings & Card Wallets</h3>
              <p>Lightweight hands-free companions in Basalt and Seagrass palettes.</p>
              <Link to="/category/crossbody-bags" className="persona-link">
                Shop Slings <ArrowRight size={14} />
              </Link>
            </div>
            <img
              src="https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3"
              alt="Minimalist Gift"
              loading="lazy"
            />
          </div>
        </div>
      </section>

      {/* Gifting Products Grid */}
      <section className="section gifting-catalog-section">
        <div className="section-heading">
          <div>
            <span className="eyebrow">GIFT CATALOGUE</span>
            <h2>Popular Keepsakes & Charms</h2>
          </div>
        </div>

        <ProductGrid products={products.slice(0, 16)} />
      </section>
    </main>
  );
}

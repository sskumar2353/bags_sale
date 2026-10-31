import { useState, useEffect, useMemo } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, ShoppingBag, Heart, Check, Sparkles } from 'lucide-react';
import productService from '../services/productService';
import useCart from '../hooks/useCart';

export default function Home() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [activeCategory, setActiveCategory] = useState('all');
  const [addedId, setAddedId] = useState(null);
  const { addToCart } = useCart();

  useEffect(() => {
    let isMounted = true;
    async function loadProducts() {
      try {
        setLoading(true);
        setError(null);
        const data = await productService.getProducts();
        if (isMounted && data) {
          setProducts(Array.isArray(data) ? data : data.products || []);
        }
      } catch (err) {
        if (isMounted) setError(err.message);
      } finally {
        if (isMounted) setLoading(false);
      }
    }
    loadProducts();
    return () => {
      isMounted = false;
    };
  }, []);

  const handleAddToCart = (e, product) => {
    e.preventDefault();
    e.stopPropagation();
    addToCart(product, 1);
    setAddedId(product.id);
    setTimeout(() => setAddedId(null), 1800);
  };

  // Filter products by category using the present application products
  const filteredProducts = useMemo(() => {
    if (activeCategory === 'all') return products;
    return products.filter((p) => {
      const catSlug = (p.category_slug || '').toLowerCase();
      const catName = (p.category || '').toLowerCase();
      const name = (p.name || '').toLowerCase();

      if (activeCategory === 'shoulder') {
        return catSlug.includes('crossbody') || catSlug.includes('sling') || name.includes('sling') || name.includes('shoulder');
      }
      if (activeCategory === 'tote') {
        return catSlug.includes('tote') || catSlug.includes('market') || name.includes('tote') || name.includes('market');
      }
      if (activeCategory === 'pouch') {
        return catSlug.includes('pouch') || catSlug.includes('wallet') || name.includes('pouch') || name.includes('wallet');
      }
      if (activeCategory === 'gifting') {
        return catSlug.includes('potli') || catSlug.includes('accessories') || name.includes('potli') || name.includes('gift') || p.price < 1500;
      }
      if (activeCategory === 'tech') {
        return catSlug.includes('messenger') || catSlug.includes('laptop') || catSlug.includes('backpack') || name.includes('laptop') || name.includes('backpack');
      }
      return true;
    });
  }, [products, activeCategory]);

  return (
    <div className="bethany-homepage">
      {/* ========================================================
          PAGE 1: HERO SECTION
          ======================================================== */}
      <section className="bethany-hero">
        <div className="bethany-container">
          <div className="bethany-hero-grid">
            <div className="bethany-hero-content">
              <span className="bethany-eyebrow">HANDMADE IN ANDHRA PRADESH & TELANGANA</span>
              <h1 className="bethany-hero-title">
                Handwoven with<br />
                hope. Carried with<br />
                pride.
              </h1>
              <p className="bethany-hero-subtitle">
                Every Bethany Looms bag is woven by hand by people affected by leprosy and by elders in our care. Your purchase gives them dignity, income and a future.
              </p>
              <div className="bethany-hero-actions">
                <a href="#collection" className="btn-ochre">
                  Shop the collection
                </a>
                <a href="#our-story" className="btn-outline-navy">
                  Our story
                </a>
              </div>
            </div>

            {/* Visual Collage Grid matching PDF Page 1 */}
            <div className="hero-visual-collage">
              {/* Large Indigo Woven Panel */}
              <div className="collage-item large weave-pattern-indigo">
                <span className="photo-label-pill">Photo: artisan at the loom</span>
              </div>
              {/* Top Right Ochre Woven Panel */}
              <div className="collage-item weave-pattern-ochre">
                <span className="photo-label-pill">Photo: jhola bag</span>
              </div>
              {/* Bottom Right Terracotta Panel */}
              <div className="collage-item weave-pattern-terracotta">
                <span className="photo-label-pill">Photo: potli pouch</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ========================================================
          PAGE 1: STATS BAND
          ======================================================== */}
      <section className="bethany-stats-band">
        <div className="bethany-container">
          <div className="stats-band-grid">
            <div className="stat-item">
              <span className="stat-number">120+</span>
              <span className="stat-label">artisans earning fair wages</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">350+</span>
              <span className="stat-label">residents given care and shelter</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">100%</span>
              <span className="stat-label">of every sale supports the mission</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">100%</span>
              <span className="stat-label">hand-woven, no machine weaving</span>
            </div>
          </div>
        </div>
      </section>

      {/* ========================================================
          PAGE 1: OUR STORY SECTION
          ======================================================== */}
      <section id="our-story" className="bethany-story-section">
        <div className="bethany-container">
          <div className="story-grid">
            {/* Left: Sage Green Weave Panel */}
            <div className="story-card-visual weave-pattern-sage">
              <span className="photo-label-pill">Photo: Meet the maker</span>
            </div>

            {/* Right: Story Content */}
            <div className="story-content">
              <span className="bethany-eyebrow">OUR STORY</span>
              <h2>Skill has no stigma. Dignity can be woven back.</h2>
              <p>
                Bethany Looms is the handcraft initiative of the Bethany Leprosy Mission Association, which runs primary care and a home for people affected by leprosy and for elders who have no one to turn to.
              </p>
              <p>
                For many of our residents, the world once said, "You can't." Here, with patient hands and steady looms, they answer, "Watch me." When you buy a bag, you give a family medicine, a meal, a roof and a reason to smile.
              </p>
              <Link to="/pages/about-us" className="story-read-link">
                Read the full story <ArrowRight size={16} />
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* ========================================================
          PAGE 2: WHAT MAKES US DIFFERENT
          ======================================================== */}
      <section className="bethany-diff-section">
        <div className="bethany-container">
          <div className="diff-header">
            <span className="bethany-eyebrow">WHAT MAKES US DIFFERENT</span>
            <h2>Made gently, for you and for them</h2>
          </div>

          <div className="diff-cards-grid">
            {/* 01 */}
            <div className="diff-card">
              <span className="diff-num">01</span>
              <h3>100% hand-woven</h3>
              <p>No machines in the weaving. Every piece carries the pattern and care of its maker, so no two are exactly alike.</p>
            </div>

            {/* 02 */}
            <div className="diff-card">
              <span className="diff-num">02</span>
              <h3>Skin-safe tapes and yarn</h3>
              <p>Stitching tapes are made from yarn dyed with skin-friendly dyes, gentle on the sensitive hands that make them.</p>
            </div>

            {/* 03 */}
            <div className="diff-card">
              <span className="diff-num">03</span>
              <h3>Every sale funds care</h3>
              <p>Proceeds support healthcare, food and shelter at our mission in Andhra Pradesh & Telangana.</p>
            </div>

            {/* 04 */}
            <div className="diff-card">
              <span className="diff-num">04</span>
              <h3>Fair, dignified work</h3>
              <p>Artisans are paid fairly and work at their own pace in a respectful, supportive place.</p>
            </div>

            {/* 05 */}
            <div className="diff-card">
              <span className="diff-num">05</span>
              <h3>Plastic-free and reusable</h3>
              <p>Long-lasting bags that replace single-use plastic, season after season.</p>
            </div>

            {/* 06 */}
            <div className="diff-card">
              <span className="diff-num">06</span>
              <h3>Built for daily Indian life</h3>
              <p>Reinforced stitching and strong weaves for market runs, college commutes and weddings.</p>
            </div>
          </div>
        </div>
      </section>

      {/* ========================================================
          PAGE 2: OUR COLLECTION (USING PRESENT PRODUCTS ONLY)
          ======================================================== */}
      <section id="collection" className="bethany-collection-section">
        <div className="bethany-container">
          <div className="collection-top-bar">
            <div>
              <span className="bethany-eyebrow">OUR COLLECTION</span>
              <h2>Designed for everyday India</h2>
            </div>
            <Link to="/shop" className="collection-view-all">
              View all products ({products.length}) →
            </Link>
          </div>

          {/* Category Filter Pills (Page 4) */}
          <div className="collection-filter-pills" role="tablist">
            <button
              className={`filter-pill ${activeCategory === 'all' ? 'active' : ''}`}
              onClick={() => setActiveCategory('all')}
            >
              All
            </button>
            <button
              className={`filter-pill ${activeCategory === 'shoulder' ? 'active' : ''}`}
              onClick={() => setActiveCategory('shoulder')}
            >
              Shoulder bags
            </button>
            <button
              className={`filter-pill ${activeCategory === 'tote' ? 'active' : ''}`}
              onClick={() => setActiveCategory('tote')}
            >
              Totes and market
            </button>
            <button
              className={`filter-pill ${activeCategory === 'pouch' ? 'active' : ''}`}
              onClick={() => setActiveCategory('pouch')}
            >
              Pouches
            </button>
            <button
              className={`filter-pill ${activeCategory === 'gifting' ? 'active' : ''}`}
              onClick={() => setActiveCategory('gifting')}
            >
              Festive and gifting
            </button>
            <button
              className={`filter-pill ${activeCategory === 'tech' ? 'active' : ''}`}
              onClick={() => setActiveCategory('tech')}
            >
              Travel and tech
            </button>
          </div>

          {/* Product Grid — Rendering Present Application Products Only */}
          {loading ? (
            <div className="bethany-product-grid">
              {[1, 2, 3, 4, 5, 6, 7, 8].map((n) => (
                <div key={n} className="bethany-product-card" style={{ opacity: 0.6 }}>
                  <div className="product-img-box weave-pattern-indigo" style={{ animation: 'pulse 1.5s infinite' }} />
                  <div className="product-info-box">
                    <div style={{ height: '18px', background: '#e2ded4', borderRadius: '4px', marginBottom: '8px' }} />
                    <div style={{ height: '14px', background: '#e2ded4', width: '60%', borderRadius: '4px' }} />
                  </div>
                </div>
              ))}
            </div>
          ) : error ? (
            <div style={{ textAlign: 'center', padding: '40px', background: '#fff', borderRadius: '8px' }}>
              <p style={{ color: '#e53e3e', marginBottom: '16px' }}>{error}</p>
              <button className="btn-ochre" onClick={() => window.location.reload()}>Try reloading</button>
            </div>
          ) : filteredProducts.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '40px', background: '#fff', borderRadius: '8px' }}>
              <p>No products found in this category.</p>
              <button className="btn-ochre" onClick={() => setActiveCategory('all')}>Show all products</button>
            </div>
          ) : (
            <div className="bethany-product-grid">
              {filteredProducts.map((p) => {
                const isJustAdded = addedId === p.id;
                const formattedPrice = `₹${Number(p.price || 0).toLocaleString('en-IN')}`;
                const imageSrc = p.primary_image || (p.images && p.images[0]?.image_url) || p.image_url;

                return (
                  <div key={p.id} className="bethany-product-card">
                    <Link to={`/product/${p.slug}`} className="product-img-box">
                      {imageSrc ? (
                        <img
                          src={imageSrc}
                          alt={p.name}
                          loading="lazy"
                          onError={(e) => {
                            e.currentTarget.style.display = 'none';
                            e.currentTarget.parentElement.classList.add('weave-pattern-indigo');
                          }}
                        />
                      ) : (
                        <div className="weave-pattern-indigo" style={{ width: '100%', height: '100%' }} />
                      )}
                    </Link>

                    <div className="product-info-box">
                      <h3 className="product-card-title">
                        <Link to={`/product/${p.slug}`}>{p.name}</Link>
                      </h3>
                      <p className="product-card-sub">
                        {p.category || 'Handwoven · skin-safe dyed tapes'}
                      </p>

                      <div className="product-card-footer">
                        <span className="product-price-val">{formattedPrice}</span>
                        <button
                          type="button"
                          className="btn-card-add"
                          onClick={(e) => handleAddToCart(e, p)}
                          aria-label={`Add ${p.name} to cart`}
                        >
                          {isJustAdded ? (
                            <>
                              <Check size={14} style={{ display: 'inline', verticalAlign: 'middle', marginRight: '4px' }} />
                              Added
                            </>
                          ) : (
                            'Add to cart'
                          )}
                        </button>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </section>

      {/* ========================================================
          PAGE 3: GIFTING THAT MEANS MORE
          ======================================================== */}
      <section className="bethany-container">
        <div className="bethany-gifting-banner">
          <div className="gifting-text">
            <h2>Gifting that means more</h2>
            <p>
              Weddings, housewarmings, festivals, corporate gifts and return gifts. A Bethany Looms gift says, "I chose something beautiful and kind." Custom bulk orders welcome.
            </p>
          </div>
          <a
            href="https://wa.me/918000123456?text=Hello%20Bethany%20Looms,%20I%20would%20like%20to%20enquire%20about%20custom%20bulk%20orders%20and%20corporate%20gifting."
            target="_blank"
            rel="noopener noreferrer"
            className="btn-bulk-enquire"
          >
            Enquire about bulk orders
          </a>
        </div>
      </section>

      {/* ========================================================
          PAGE 3: DONATE / PARTNER BANNER
          ======================================================== */}
      <section id="impact" className="bethany-donate-banner">
        <div className="bethany-container">
          <div className="donate-banner-grid">
            <div className="donate-text">
              <h2>Buy a bag. Gift a bag. Or donate directly.</h2>
              <p>We are not asking for pity. We are inviting you to partner with us.</p>
            </div>
            <div className="donate-actions">
              <a href="#collection" className="btn-ochre">
                Shop now
              </a>
              <a
                href="https://wa.me/918000123456?text=Hello%20Bethany%20Looms,%20I%20would%20like%20to%20donate%20to%20support%20the%20Bethany%20Leprosy%20Mission%20Association."
                target="_blank"
                rel="noopener noreferrer"
                className="btn-donate-white"
              >
                Donate [₹500 / ₹1,000]
              </a>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}

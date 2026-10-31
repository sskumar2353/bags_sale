import { useState, useEffect, useMemo } from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, Check } from 'lucide-react';
import productService from '../services/productService';
import useCart from '../hooks/useCart';
import formatPrice from '../utils/formatPrice';
import CategoryStoryBar from '../components/home/CategoryStoryBar';

function HomeCollectionCard({ product, onAddToCart, isJustAdded }) {
  const [activeSwatchImage, setActiveSwatchImage] = useState(null);
  const [activeSwatchId, setActiveSwatchId] = useState(null);

  const formattedPrice = formatPrice(product.price);
  const defaultImage =
    product.image ||
    product.primary_image ||
    product.image_url ||
    (product.images && product.images[0]?.image_url) ||
    'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3';
  const imageSrc = activeSwatchImage || defaultImage;

  return (
    <div className="bethany-product-card">
      <Link to={`/product/${product.slug}`} className="product-img-box">
        <img
          src={imageSrc}
          alt={product.name}
          loading="lazy"
          onError={(e) => {
            e.currentTarget.onerror = null;
            e.currentTarget.src =
              'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3';
          }}
        />
      </Link>

      <div className="product-info-box">
        <h3 className="product-card-title">
          <Link to={`/product/${product.slug}`}>{product.name}</Link>
        </h3>
        <p className="product-card-sub">
          {product.short_description || product.category || 'Handwoven · skin-safe dyed tapes'}
        </p>

        {product.variants && product.variants.length > 0 && (
          <div style={{ display: 'flex', gap: '6px', margin: '6px 0 10px', alignItems: 'center' }}>
            {product.variants
              .filter((v) => v.color_code)
              .slice(0, 5)
              .map((v, i) => {
                const isSelected = activeSwatchId === v.id;
                return (
                  <button
                    key={v.id || i}
                    type="button"
                    style={{
                      background: v.color_code,
                      width: '14px',
                      height: '14px',
                      borderRadius: '50%',
                      border: isSelected ? '2px solid var(--bethany-navy, #1e2d4a)' : '1px solid #d5cfc1',
                      cursor: 'pointer',
                      padding: 0,
                      outline: isSelected ? '1px solid var(--bethany-ochre, #e5ad42)' : 'none',
                      outlineOffset: '1px',
                      transition: 'transform 0.15s ease'
                    }}
                    title={v.color_name || 'Color option'}
                    onMouseEnter={() => {
                      if (v.image_url) {
                        setActiveSwatchImage(v.image_url);
                        setActiveSwatchId(v.id);
                      }
                    }}
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      if (v.image_url) {
                        setActiveSwatchImage(v.image_url);
                        setActiveSwatchId(v.id);
                      }
                    }}
                  />
                );
              })}
          </div>
        )}

        <div className="product-card-footer" style={{ marginTop: 'auto' }}>
          <span className="product-price-val">{formattedPrice}</span>
          <button
            type="button"
            className="btn-card-add"
            onClick={(e) => onAddToCart(e, product)}
            aria-label={`Add ${product.name} to cart`}
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
}

export default function Home() {
  const [categories, setCategories] = useState([]);
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [addedId, setAddedId] = useState(null);
  const { addToCart } = useCart();

  useEffect(() => {
    let isMounted = true;
    async function loadData() {
      try {
        setLoading(true);
        setError(null);
        // Load categories and products dynamically from database/API
        const [catData, prodData] = await Promise.all([
          productService.getCategories().catch(() => []),
          productService.getProducts({ inStock: 'true' })
        ]);

        if (isMounted) {
          setCategories(Array.isArray(catData) ? catData : []);
          const rawList = Array.isArray(prodData) ? prodData : prodData?.products || [];
          // Only show available stock in the website
          const inStockOnly = rawList.filter(
            (p) => p.stock_quantity === undefined || p.stock_quantity > 0
          );
          setProducts(inStockOnly);
        }
      } catch (err) {
        if (isMounted) setError(err.message);
      } finally {
        if (isMounted) setLoading(false);
      }
    }
    loadData();
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

  // Distinct category showcase: exactly 1 product per each distinct category
  const categoryShowcase = useMemo(() => {
    const seenCategories = new Set();
    const showcase = [];

    for (const p of products) {
      const catKey = (p.category_slug || p.category || 'collection').toLowerCase();
      if (!seenCategories.has(catKey)) {
        seenCategories.add(catKey);
        showcase.push(p);
      }
    }
    return showcase;
  }, [products]);

  return (
    <div className="bethany-homepage">
      {/* Dynamic Circular Category Story Bar (Synced with Database) */}
      <CategoryStoryBar categories={categories} products={products} />

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

            {/* Visual Collage Grid with Real World Photography */}
            <div className="hero-visual-collage">
              {/* Large Hero: Artisan at the Loom */}
              <div className="collage-item large">
                <img
                  src="https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=1200&q=85"
                  alt="Artisan at the handloom weaving pure cotton fabric"
                  className="collage-real-img"
                  loading="eager"
                />
                <span className="photo-label-pill">Artisan at the loom · Bapatla</span>
              </div>
              {/* Top Right: Handcrafted Jhola Bag */}
              <div className="collage-item">
                <img
                  src="https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=800&q=85"
                  alt="Handcrafted classic jhola shoulder bag"
                  className="collage-real-img"
                  loading="eager"
                />
                <span className="photo-label-pill">Classic Jhola Shoulder Bag</span>
              </div>
              {/* Bottom Right: Handwoven Potli Pouch */}
              <div className="collage-item">
                <img
                  src="https://images.unsplash.com/photo-1614252235316-8c857d38b5f4?auto=format&fit=crop&w=800&q=85"
                  alt="Artisanal handwoven festive potli bag"
                  className="collage-real-img"
                  loading="eager"
                />
                <span className="photo-label-pill">Artisan Potli Pouch</span>
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
            {/* Left: Real-world Photo of Maker */}
            <div className="story-card-visual">
              <img
                src="https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=1200&q=85"
                alt="Meet the Maker - Master artisan at Bethany Looms"
                className="story-real-img"
                loading="lazy"
              />
              <span className="photo-label-pill">Meet the maker · Master Weaver</span>
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
          PAGE 2: OUR COLLECTION — EXACTLY 1 PART PER CATEGORY
          (NO PRODUCT COUNT NUMBERS)
          ======================================================== */}
      <section id="collection" className="bethany-collection-section">
        <div className="bethany-container">
          <div className="collection-top-bar">
            <div>
              <span className="bethany-eyebrow">OUR COLLECTION</span>
              <h2>Designed for everyday India</h2>
            </div>
            <Link to="/shop" className="collection-view-all">
              View all products →
            </Link>
          </div>

          {/* Product Grid — 1 Piece per Each Category */}
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
          ) : categoryShowcase.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '40px', background: '#fff', borderRadius: '8px' }}>
              <p>Collection arriving shortly.</p>
              <Link to="/shop" className="btn-ochre">Explore pieces</Link>
            </div>
          ) : (
            <div className="bethany-product-grid">
              {categoryShowcase.map((p) => (
                <HomeCollectionCard
                  key={p.id}
                  product={p}
                  onAddToCart={handleAddToCart}
                  isJustAdded={addedId === p.id}
                />
              ))}
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
              <Link to="/shop" className="btn-ochre">
                Shop now
              </Link>
              <button
                type="button"
                onClick={() => document.querySelector('.donate-pill-btn')?.click()}
                className="btn-donate-white"
                style={{ cursor: 'pointer', border: 'none' }}
              >
                Donate 
              </button>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}

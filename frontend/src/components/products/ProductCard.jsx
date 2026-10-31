import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Heart, ShoppingBag, Share2, Check } from 'lucide-react';
import useWishlist from '../../hooks/useWishlist';
import useCart from '../../hooks/useCart';
import formatPrice from '../../utils/formatPrice';

export default function ProductCard({ product }) {
  const { isInWishlist, toggleWishlist } = useWishlist();
  const { addToCart } = useCart();
  const wished = isInWishlist(product.id);
  const [isHovered, setIsHovered] = useState(false);
  const [adding, setAdding] = useState(false);
  const [shared, setShared] = useState(false);
  const [activeSwatchImage, setActiveSwatchImage] = useState(null);
  const [activeSwatchId, setActiveSwatchId] = useState(null);

  const price = Number(product.price || 0);
  const mrp = Number(product.mrp || price);
  const discount = mrp > price ? Math.round((1 - price / mrp) * 100) : 0;
  
  const primaryImg = product.image || product.images?.[0]?.image_url || 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
  const altImg = product.alt_image || product.images?.[1]?.image_url;

  const handleQuickAdd = async (e) => {
    e.preventDefault();
    e.stopPropagation();
    try {
      setAdding(true);
      const defaultVariant = product.variants?.[0] || null;
      await addToCart(product, defaultVariant, 1);
    } catch (err) {
      console.error('Quick add failed', err);
    } finally {
      setTimeout(() => setAdding(false), 600);
    }
  };

  const handleShare = async (e) => {
    e.preventDefault();
    e.stopPropagation();
    const shareUrl = `${window.location.origin}/product/${product.slug}`;
    if (navigator.share) {
      try {
        await navigator.share({
          title: product.name,
          text: `Check out ${product.name} on Daily Objects`,
          url: shareUrl
        });
      } catch {}
    } else {
      try {
        await navigator.clipboard.writeText(shareUrl);
        setShared(true);
        setTimeout(() => setShared(false), 2000);
      } catch {}
    }
  };

  return (
    <article
      className="product-card"
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <div className="product-image">
        <Link to={`/product/${product.slug}`} className="product-img-link" aria-label={`View details of ${product.name}`}>
          <img
            src={activeSwatchImage || (isHovered && altImg ? altImg : primaryImg)}
            alt={product.name}
            loading="lazy"
            className="main-product-img"
            onError={(e) => {
              e.currentTarget.src =
                'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
            }}
          />
        </Link>

        {product.badge && (
          <span className={`badge ${product.badge.toLowerCase().includes('drop') ? 'badge-drop' : ''}`}>
            {product.badge}
          </span>
        )}

        <div className="card-top-actions">
          <button
            className={`wish-btn ${wished ? 'active' : ''}`}
            onClick={(e) => {
              e.preventDefault();
              toggleWishlist(product);
            }}
            aria-label={wished ? 'Remove from wishlist' : 'Save to wishlist'}
          >
            <Heart size={18} fill={wished ? '#e66b55' : 'none'} color={wished ? '#e66b55' : '#121212'} />
          </button>

          <button
            className="share-btn"
            onClick={handleShare}
            aria-label={`Share ${product.name}`}
            title={shared ? 'Link Copied!' : 'Share piece'}
          >
            {shared ? <Check size={16} color="#2db58e" /> : <Share2 size={16} color="#121212" />}
          </button>
        </div>

        <button
          className="quick-add-btn"
          onClick={handleQuickAdd}
          aria-label={`Add ${product.name} to bag`}
        >
          <ShoppingBag size={14} style={{ marginRight: '6px' }} />
          {adding ? 'ADDED!' : 'QUICK ADD'}
        </button>
      </div>

      <div className="product-meta">
        <span className="product-subtitle-tag">FREE MYSTERY GIFT</span>

        <h3 className="product-title-row" style={{ fontSize: '15px', fontWeight: '700', margin: '4px 0' }}>
          <Link to={`/product/${product.slug}`}>{product.name}</Link>
        </h3>

        <div className="price-line">
          <strong>{formatPrice(price)}</strong>
          {mrp > price && <del>{formatPrice(mrp)}</del>}
          {discount > 0 && <span className="discount-tag">{discount}% OFF</span>}
        </div>

        {product.variants && product.variants.length > 0 && (
          <div className="swatches" style={{ display: 'flex', gap: '6px', marginTop: '6px', alignItems: 'center' }}>
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
      </div>
    </article>
  );
}

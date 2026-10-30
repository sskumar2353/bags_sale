import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Heart, ShoppingBag } from 'lucide-react';
import useWishlist from '../../hooks/useWishlist';
import useCart from '../../hooks/useCart';
import formatPrice from '../../utils/formatPrice';

export default function ProductCard({ product }) {
  const { isInWishlist, toggleWishlist } = useWishlist();
  const { addToCart } = useCart();
  const wished = isInWishlist(product.id);
  const [isHovered, setIsHovered] = useState(false);
  const [adding, setAdding] = useState(false);

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

  return (
    <article
      className="product-card"
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <div className="product-image">
        <Link to={`/product/${product.slug}`} className="product-img-link">
          <img
            src={isHovered && altImg ? altImg : primaryImg}
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
          className="quick-add-btn"
          onClick={handleQuickAdd}
          aria-label="Add to bag"
        >
          <ShoppingBag size={14} style={{ marginRight: '6px' }} />
          {adding ? 'ADDED!' : 'QUICK ADD'}
        </button>
      </div>

      <div className="product-meta">
        {/* DailyObjects Free Mystery Gift Tag */}
        <span className="product-subtitle-tag">FREE MYSTERY GIFT</span>

        <div className="product-title-row">
          <Link to={`/product/${product.slug}`}>{product.name}</Link>
        </div>

        <div className="price-line">
          <strong>{formatPrice(price)}</strong>
          {mrp > price && <del>{formatPrice(mrp)}</del>}
          {discount > 0 && <span className="discount-tag">{discount}% OFF</span>}
        </div>

        {product.variants && product.variants.length > 0 && (
          <div className="swatches">
            {product.variants
              .filter((v) => v.color_code)
              .slice(0, 5)
              .map((v, i) => (
                <i
                  key={v.id || i}
                  style={{ background: v.color_code }}
                  title={v.color_name || 'Color option'}
                />
              ))}
          </div>
        )}
      </div>
    </article>
  );
}

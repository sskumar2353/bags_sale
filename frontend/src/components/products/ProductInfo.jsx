import { useState } from 'react';
import { Heart, Check } from 'lucide-react';
import formatPrice from '../../utils/formatPrice';
import useWishlist from '../../hooks/useWishlist';

export default function ProductInfo({
  product,
  selectedVariant,
  onAddToCart
}) {
  const [quantity, setQuantity] = useState(1);
  const [added, setAdded] = useState(false);
  const { isInWishlist, toggleWishlist } = useWishlist();

  const price = Number(selectedVariant?.price || product.price);
  const mrp = Number(product.mrp || price);
  const discount = mrp > price ? Math.round((1 - price / mrp) * 100) : 0;
  const stock = selectedVariant ? Number(selectedVariant.stock_quantity) : Number(product.stock_quantity ?? 10);
  const isOutOfStock = stock <= 0;
  const wished = isInWishlist(product.id);

  const handleAdd = () => {
    if (isOutOfStock) return;
    onAddToCart(product, selectedVariant, quantity);
    setAdded(true);
    setTimeout(() => setAdded(false), 2500);
  };

  return (
    <div className="detail-info">
      <span className="eyebrow">{product.category?.toUpperCase()}</span>
      <h1>{product.name}</h1>
      {product.rating > 0 && (
        <p className="rating">
          ★ {Number(product.rating).toFixed(1)}{' '}
          <span>({product.review_count || 12} reviews)</span>
        </p>
      )}

      <div className="detail-price">
        <strong>{formatPrice(price)}</strong>
        {mrp > price && <del>{formatPrice(mrp)}</del>}
        {discount > 0 && <em>Save {discount}%</em>}
      </div>

      <p className="detail-desc">{product.description || product.short_description}</p>

      {/* Stock status */}
      <div style={{ margin: '14px 0', fontSize: '13px' }}>
        {isOutOfStock ? (
          <span style={{ color: '#d9534f', fontWeight: 'bold' }}>Out of Stock</span>
        ) : (
          <span style={{ color: '#5cb85c', fontWeight: '500' }}>
            In stock ({stock} units available)
          </span>
        )}
      </div>

      {/* Quantity Selector */}
      {!isOutOfStock && (
        <div className="quantity">
          <span>Quantity</span>
          <div>
            <button
              type="button"
              onClick={() => setQuantity((q) => Math.max(1, q - 1))}
              disabled={quantity <= 1}
              aria-label="Decrease quantity"
            >
              −
            </button>
            <b>{quantity}</b>
            <button
              type="button"
              onClick={() => setQuantity((q) => Math.min(stock, q + 1))}
              disabled={quantity >= stock}
              aria-label="Increase quantity"
            >
              +
            </button>
          </div>
          <small>Ready to ship</small>
        </div>
      )}

      {/* Action Buttons */}
      <div className="detail-actions" style={{ marginTop: '20px' }}>
        <button
          className="button button-dark full"
          onClick={handleAdd}
          disabled={isOutOfStock}
        >
          {added ? (
            <>
              <Check size={18} /> Added to Bag
            </>
          ) : isOutOfStock ? (
            'Sold Out'
          ) : (
            `Add to bag · ${formatPrice(price * quantity)}`
          )}
        </button>

        <button
          type="button"
          className={`button button-outline ${wished ? 'active' : ''}`}
          onClick={() => toggleWishlist(product)}
          aria-label={wished ? 'Remove from wishlist' : 'Save to wishlist'}
        >
          <Heart size={18} fill={wished ? 'currentColor' : 'none'} />
          {wished ? 'Saved' : 'Save'}
        </button>
      </div>

      {/* Accordions */}
      <div className="detail-accordions" style={{ marginTop: '30px' }}>
        <details open>
          <summary>Material & Construction</summary>
          <p>
            {product.material || 'Crafted with premium water-resistant canvas and vegan leather accents. Designed with high-tensile stitching and custom brass-finished hardware.'}
          </p>
        </details>
        <details>
          <summary>Dimensions & Capacity</summary>
          <p>
            {product.dimensions || 'Dimensions: 42cm x 30cm x 14cm. Capacity: Approx. 18 Litres. Fits up to a 16" laptop securely.'}
          </p>
        </details>
        <details>
          <summary>Delivery & Easy Returns</summary>
          <p>
            Complimentary shipping on orders above ₹1,499. Easy 7-day doorstep return policy. Dispatched within 24–48 business hours.
          </p>
        </details>
        <details>
          <summary>Care Instructions</summary>
          <p>
            Wipe clean with a damp cloth using mild soapy water. Do not machine wash or soak. Air dry in the shade.
          </p>
        </details>
      </div>
    </div>
  );
}

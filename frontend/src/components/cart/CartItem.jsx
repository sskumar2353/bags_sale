import { Link } from 'react-router-dom';
import formatPrice from '../../utils/formatPrice';

export default function CartItem({ item, onUpdateQuantity, onRemove }) {
  const price = Number(item.price || 0);
  const qty = Number(item.quantity || 1);
  const total = price * qty;

  return (
    <div className="cart-row">
      <img
        src={item.image || 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=300&q=80'}
        alt={item.name}
      />
      <div className="cart-product">
        <Link to={`/product/${item.slug}`}>{item.name}</Link>
        {item.variant_name && (
          <span style={{ color: 'var(--muted)', fontSize: '11px', display: 'block' }}>
            Variant: {item.variant_name}
          </span>
        )}
        <span>{item.category}</span>
        <strong>{formatPrice(price)}</strong>
        <div className="quantity compact">
          <div>
            <button
              type="button"
              onClick={() => onUpdateQuantity(item.id, qty - 1)}
              aria-label="Decrease quantity"
            >
              −
            </button>
            <b>{qty}</b>
            <button
              type="button"
              onClick={() => onUpdateQuantity(item.id, qty + 1)}
              aria-label="Increase quantity"
            >
              +
            </button>
          </div>
          <button
            type="button"
            className="remove"
            onClick={() => onRemove(item.id)}
            aria-label="Remove item"
          >
            Remove
          </button>
        </div>
      </div>
      <b>{formatPrice(total)}</b>
    </div>
  );
}

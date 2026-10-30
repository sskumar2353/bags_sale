import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import formatPrice from '../../utils/formatPrice';

export default function CartSummary({
  subtotal,
  shipping,
  total,
  itemCount,
  checkoutLink = '/checkout'
}) {
  const freeShippingThreshold = 1499;
  const neededForFreeShipping = Math.max(0, freeShippingThreshold - subtotal);

  return (
    <aside className="summary">
      <h2>Order Summary</h2>
      <div>
        <span>Subtotal ({itemCount} items)</span>
        <b>{formatPrice(subtotal)}</b>
      </div>
      <div>
        <span>Estimated Delivery</span>
        <b>{shipping === 0 ? 'FREE' : formatPrice(shipping)}</b>
      </div>
      {neededForFreeShipping > 0 && (
        <div style={{ fontSize: '11px', color: '#a98761', margin: '4px 0' }}>
          Add {formatPrice(neededForFreeShipping)} more for complimentary shipping.
        </div>
      )}
      <div className="summary-total">
        <span>Total Amount</span>
        <b>{formatPrice(total)}</b>
      </div>
      {checkoutLink && (
        <Link className="button button-dark full" to={checkoutLink}>
          Proceed to Checkout <ArrowRight size={17} />
        </Link>
      )}
      <p style={{ marginTop: '12px', fontSize: '11px', color: 'var(--muted)' }}>
        Prices are inclusive of all applicable taxes.
      </p>
    </aside>
  );
}

import formatPrice from '../../utils/formatPrice';

export default function OrderSummary({ items = [], subtotal = 0, shipping = 0, total = 0 }) {
  return (
    <aside className="summary">
      <h2>Your Order Summary</h2>
      <div style={{ maxHeight: '280px', overflowY: 'auto', marginBottom: '14px', borderBottom: '1px solid var(--line)', paddingBottom: '10px' }}>
        {items.map((x) => {
          const itemPrice = Number(x.price || 0);
          const itemQty = Number(x.quantity || 1);
          return (
            <div key={`${x.product_id || x.id}-${x.variant_id || 'base'}`} style={{ display: 'flex', justifyContent: 'space-between', margin: '8px 0', fontSize: '12px' }}>
              <div>
                <strong>{x.name}</strong> × {itemQty}
                {x.variant_name && <small style={{ display: 'block', color: 'var(--muted)' }}>{x.variant_name}</small>}
              </div>
              <b>{formatPrice(itemPrice * itemQty)}</b>
            </div>
          );
        })}
      </div>

      <div>
        <span>Subtotal</span>
        <b>{formatPrice(subtotal)}</b>
      </div>
      <div>
        <span>Shipping & Handling</span>
        <b>{shipping === 0 ? 'FREE' : formatPrice(shipping)}</b>
      </div>
      <div className="summary-total">
        <span>Total Payable</span>
        <b>{formatPrice(total)}</b>
      </div>
      <p style={{ marginTop: '12px', fontSize: '11px', color: 'var(--muted)' }}>
        Zero surprise fees. Amount payable is verified and locked.
      </p>
    </aside>
  );
}

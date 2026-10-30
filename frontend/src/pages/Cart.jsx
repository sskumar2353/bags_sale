import { Link } from 'react-router-dom';
import { ShoppingBag } from 'lucide-react';
import useCart from '../hooks/useCart';
import CartItem from '../components/cart/CartItem';
import CartSummary from '../components/cart/CartSummary';
import EmptyState from '../components/common/EmptyState';

export default function Cart() {
  const { items, updateQuantity, removeFromCart, subtotal, shipping, total, itemCount } = useCart();

  return (
    <main className="page">
      <h1 className="page-title" style={{ marginTop: '24px' }}>
        Your Bag
      </h1>

      {items.length === 0 ? (
        <EmptyState
          icon={ShoppingBag}
          title="Your bag is taking a breather."
          message="Find something thoughtful to carry your everyday."
          actionText="Explore the Collection"
          actionTo="/shop"
        />
      ) : (
        <div className="cart-layout">
          <div className="cart-items">
            {items.map((item) => (
              <CartItem
                key={item.id}
                item={item}
                onUpdateQuantity={updateQuantity}
                onRemove={removeFromCart}
              />
            ))}
          </div>

          <CartSummary
            subtotal={subtotal}
            shipping={shipping}
            total={total}
            itemCount={itemCount}
            checkoutLink="/checkout"
          />
        </div>
      )}
    </main>
  );
}

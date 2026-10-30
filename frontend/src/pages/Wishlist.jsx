import { Link } from 'react-router-dom';
import { Heart } from 'lucide-react';
import useWishlist from '../hooks/useWishlist';
import ProductGrid from '../components/products/ProductGrid';
import EmptyState from '../components/common/EmptyState';

export default function Wishlist() {
  const { items } = useWishlist();

  return (
    <main className="page">
      <div className="listing-heading" style={{ marginTop: '24px' }}>
        <div>
          <span className="eyebrow">YOUR SHORTLIST</span>
          <h1>Saved for later.</h1>
          <p>Curate your personal collection of everyday pieces.</p>
        </div>
      </div>

      {items.length === 0 ? (
        <EmptyState
          icon={Heart}
          title="Your shortlist is empty"
          message="Save pieces as you browse to revisit them anytime."
          actionText="Discover Bags"
          actionTo="/shop"
        />
      ) : (
        <ProductGrid products={items} />
      )}
    </main>
  );
}

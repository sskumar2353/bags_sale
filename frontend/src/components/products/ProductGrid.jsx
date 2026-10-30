import ProductCard from './ProductCard';
import EmptyState from '../common/EmptyState';

export default function ProductGrid({ products = [], emptyMessage = 'Try adjusting your search or filters.' }) {
  if (!products.length) {
    return (
      <EmptyState
        title="No pieces found"
        message={emptyMessage}
        actionText="Explore all pieces"
        actionTo="/shop"
      />
    );
  }

  return (
    <div className="product-grid">
      {products.map((p) => (
        <ProductCard key={p.id} product={p} />
      ))}
    </div>
  );
}

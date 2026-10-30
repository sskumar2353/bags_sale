import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import ProductGrid from './ProductGrid';

export default function RelatedProducts({ products = [] }) {
  if (!products || products.length === 0) return null;

  return (
    <section className="section" style={{ borderTop: '1px solid var(--line)', marginTop: '40px' }}>
      <div className="section-heading">
        <div>
          <span className="eyebrow">COMPLETE THE SET</span>
          <h2>You might also like</h2>
        </div>
        <Link to="/shop" className="text-link">
          Explore all <ArrowRight size={16} />
        </Link>
      </div>
      <ProductGrid products={products.slice(0, 4)} />
    </section>
  );
}

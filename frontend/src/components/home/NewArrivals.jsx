import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import ProductGrid from '../products/ProductGrid';

export default function NewArrivals({ products = [] }) {
  if (!products.length) return null;

  return (
    <section className="section new-arrivals-section">
      <div className="section-heading">
        <div>
          <span className="eyebrow">JUST IN</span>
          <h2>Fresh drops for the new season</h2>
          <p>Thoughtful additions to our everyday line-up.</p>
        </div>
        <Link to="/shop?sort=newest" className="text-link">
          Explore new drops <ArrowRight size={16} />
        </Link>
      </div>

      <ProductGrid products={products} />
    </section>
  );
}

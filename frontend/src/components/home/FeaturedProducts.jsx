import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import ProductGrid from '../products/ProductGrid';

export default function FeaturedProducts({ products = [] }) {
  return (
    <section className="section featured-section">
      <div className="section-heading">
        <div>
          <span className="eyebrow">THE GOOD CARRY</span>
          <h2>Everyday favourites</h2>
          <p>Pieces people reach for, day after day.</p>
        </div>
        <Link to="/shop" className="text-link">
          View all <ArrowRight size={16} />
        </Link>
      </div>

      <ProductGrid products={products} />
    </section>
  );
}

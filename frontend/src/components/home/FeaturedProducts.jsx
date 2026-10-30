import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import ProductGrid from '../products/ProductGrid';

export default function FeaturedProducts({ products = [] }) {
  return (
    <section className="section featured-section" style={{ maxWidth: 'var(--container)', margin: '0 auto', padding: '0 var(--space)' }}>
      <div
        className="section-heading"
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'flex-end',
          flexWrap: 'wrap',
          gap: '16px',
          marginBottom: '32px'
        }}
      >
        <div>
          <span className="eyebrow">THE GOOD CARRY · CURATED ESSENTIALS</span>
          <h2 style={{ fontSize: 'clamp(24px, 3.2vw, 36px)', fontWeight: '800', letterSpacing: '0.04em', margin: '4px 0 0' }}>
            Everyday favourites
          </h2>
          <p style={{ color: 'var(--ink-muted)', marginTop: '6px', fontSize: '14px' }}>
            One signature piece for every style of carry—from backpacks and totes to crossbodies and pouches.
          </p>
        </div>
        <Link to="/shop" className="text-link" style={{ fontSize: '13px', fontWeight: '700', display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
          Explore All Bags <ArrowRight size={16} />
        </Link>
      </div>

      <ProductGrid products={products} />
    </section>
  );
}

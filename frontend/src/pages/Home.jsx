import { useState, useEffect } from 'react';
import CategoryStoryBar from '../components/common/CategoryStoryBar';
import BrandPromotionSlider from '../components/home/BrandPromotionSlider';
import FeaturedProducts from '../components/home/FeaturedProducts';
import WhyOnlyWe from '../components/home/WhyOnlyWe';
import CustomerReviews from '../components/home/CustomerReviews';
import FeaturedIn from '../components/home/FeaturedIn';
import productService from '../services/productService';

const BAG_CATEGORIES = [
  { slug: 'tote-bags', label: 'Tote Bags', match: ['tote-bags', 'tote'] },
  { slug: 'crossbody-bags', label: 'Crossbody Bags', match: ['crossbody-bags', 'crossbody', 'sling'] },
  { slug: 'backpacks', label: 'Backpacks', match: ['backpacks', 'backpack'] },
  { slug: 'messenger-laptop-bags', label: 'Messenger Bags', match: ['messenger-laptop-bags', 'messenger', 'laptop'] },
  { slug: 'phone-bags', label: 'Phone Bags', match: ['phone-bags', 'phone'] },
  { slug: 'wallets', label: 'Wallets', match: ['wallets', 'wallet'] },
  { slug: 'duffle-bags', label: 'Duffle Bags', match: ['duffle-bags', 'duffle'] },
  { slug: 'pouches', label: 'Pouches', match: ['pouches', 'pouch', 'taxi', 'easy'] },
  { slug: 'bag-accessories', label: 'Bag Accessories', match: ['bag-accessories', 'accessories', 'charm'] }
];

export default function Home() {
  const [sampleProducts, setSampleProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let isMounted = true;
    async function loadHomeData() {
      try {
        setLoading(true);
        setError(null);
        const prods = await productService.getProducts();

        if (isMounted && prods && prods.length > 0) {
          const pickedIds = new Set();
          const samples = [];

          for (const cat of BAG_CATEGORIES) {
            const match = prods.find((p) => {
              if (pickedIds.has(p.id)) return false;
              const catSlug = (p.category_slug || '').toLowerCase();
              const catName = (p.category || '').toLowerCase();
              const prodName = (p.name || '').toLowerCase();

              return cat.match.some((m) =>
                catSlug.includes(m) || catName.includes(m) || prodName.includes(m)
              );
            });

            if (match) {
              pickedIds.add(match.id);
              samples.push(match);
            }
          }

          if (samples.length < 9) {
            for (const p of prods) {
              if (samples.length >= 9) break;
              if (!pickedIds.has(p.id)) {
                pickedIds.add(p.id);
                samples.push(p);
              }
            }
          }

          setSampleProducts(samples);
        }
      } catch (err) {
        if (isMounted) setError(err.message);
      } finally {
        if (isMounted) setLoading(false);
      }
    }

    loadHomeData();
    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <div className="homepage-content">
      {/* 1. Primary Semantic Heading for Accessibility (WCAG 2.1 AA / UX4G) */}
      <h1 className="sr-only">Daily Objects — Everyday Bags, Backpacks, Totes & Carry Accessories</h1>

      {/* 2. Homepage circular category entrance */}
      <CategoryStoryBar />

      {/* 3. Brand Promotion Banner with sliding images */}
      <BrandPromotionSlider />

      {/* 4. Everyday Favourites (with location-based delivery checker & category filters) */}
      {error ? (
        <div className="empty" style={{ padding: '40px 20px', textAlign: 'center' }}>
          <p style={{ color: 'var(--muted)', margin: '10px 0 20px' }}>{error}</p>
          <button className="button button-dark" onClick={() => window.location.reload()}>
            Try again
          </button>
        </div>
      ) : (
        <FeaturedProducts products={sampleProducts} loading={loading} />
      )}

      {/* 5. Why Only We: Core steps / architectural craftsmanship pillars + Mission & Vision */}
      <WhyOnlyWe />

      {/* 6. Verified Customer Reviews */}
      <CustomerReviews />

      {/* 7. As Featured In: Editorial media quotes */}
      <FeaturedIn />
    </div>
  );
}

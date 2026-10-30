import { useState, useEffect } from 'react';
import CategoryStoryBar from '../components/common/CategoryStoryBar';
import FeaturedProducts from '../components/home/FeaturedProducts';
import Loading from '../components/common/Loading';
import productService from '../services/productService';

export default function Home() {
  const [featuredProducts, setFeaturedProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let isMounted = true;
    async function loadHomeData() {
      try {
        setLoading(true);
        setError(null);
        const prods = await productService.getProducts();
        if (isMounted) {
          // Show 12 everyday favourites
          const featured = prods.filter((p) => p.is_featured);
          setFeaturedProducts((featured.length >= 12 ? featured : prods).slice(0, 12));
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

  if (loading) {
    return <Loading message="Loading Everyday Favourites…" />;
  }

  if (error) {
    return (
      <div className="empty" style={{ padding: '80px 20px' }}>
        <h2>Could not connect to catalog</h2>
        <p style={{ color: 'var(--muted)', margin: '10px 0 20px' }}>{error}</p>
        <button className="button button-dark" onClick={() => window.location.reload()}>
          Try again
        </button>
      </div>
    );
  }

  return (
    <main className="homepage-content">
      {/* Homepage entrance with 9 circular category avatars */}
      <CategoryStoryBar />

      {/* Only Everyday favourites section */}
      <FeaturedProducts products={featuredProducts} />
    </main>
  );
}

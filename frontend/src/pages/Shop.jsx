import { useState, useEffect, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import ProductGrid from '../components/products/ProductGrid';
import ProductFilters from '../components/products/ProductFilters';
import ProductSort from '../components/products/ProductSort';
import Pagination from '../components/common/Pagination';
import Loading from '../components/common/Loading';
import productService from '../services/productService';

const PRODUCTS_PER_PAGE = 12;

export default function Shop() {
  const [searchParams, setSearchParams] = useSearchParams();
  const categoryParam = searchParams.get('category') || '';
  const sortParam = searchParams.get('sort') || 'recommended';

  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    let active = true;
    async function fetchData() {
      try {
        setLoading(true);
        setError(null);
        // Only load available stock across the website
        const [cats, prods] = await Promise.all([
          productService.getCategories(),
          productService.getProducts({
            category: categoryParam,
            sort: sortParam,
            inStock: 'true'
          })
        ]);
        if (active) {
          setCategories(cats || []);
          // Ensure strictly in-stock products only
          const availableProducts = (prods || []).filter(
            (p) => p.stock_quantity === undefined || p.stock_quantity > 0
          );
          setProducts(availableProducts);
          setCurrentPage(1);
        }
      } catch (err) {
        if (active) setError(err.message);
      } finally {
        if (active) setLoading(false);
      }
    }

    fetchData();
    return () => {
      active = false;
    };
  }, [categoryParam, sortParam]);

  const handleCategoryChange = (val) => {
    const next = new URLSearchParams(searchParams);
    if (val) next.set('category', val);
    else next.delete('category');
    setSearchParams(next);
    setCurrentPage(1);
  };

  const handleSortChange = (val) => {
    const next = new URLSearchParams(searchParams);
    if (val && val !== 'recommended') next.set('sort', val);
    else next.delete('sort');
    setSearchParams(next);
    setCurrentPage(1);
  };

  // 12 products per page pagination (no total count exposed)
  const totalPages = Math.ceil(products.length / PRODUCTS_PER_PAGE) || 1;
  const paginatedProducts = useMemo(() => {
    const start = (currentPage - 1) * PRODUCTS_PER_PAGE;
    return products.slice(start, start + PRODUCTS_PER_PAGE);
  }, [products, currentPage]);

  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
    window.scrollTo({ top: 120, behavior: 'smooth' });
  };

  return (
    <main className="page listing-page">
      <div className="category-header-banner" style={{ borderBottom: 'none', paddingBottom: '0' }}>
        <span className="bethany-eyebrow" style={{ marginBottom: '8px' }}>BETHANY LOOMS · HANDWOVEN COLLECTION</span>
        <h1 className="category-header-title">All Handwoven Pieces</h1>
        <p style={{ color: 'var(--muted)', fontSize: '14.5px', marginTop: '-8px' }}>
          Thoughtful bags and everyday carry, handwoven by people our mission cares for.
        </p>
      </div>

      {/* Premium Filter & Sort Bar */}
      <div
        className="listing-tools"
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          flexWrap: 'wrap',
          gap: '14px',
          margin: '24px 0 32px'
        }}
      >
        <ProductFilters
          categories={categories}
          selectedCategory={categoryParam}
          onSelectCategory={handleCategoryChange}
        />
        <ProductSort value={sortParam} onChange={handleSortChange} />
      </div>

      {loading ? (
        <Loading message="Fetching collection…" />
      ) : error ? (
        <div className="empty">
          <h3>Failed to load products</h3>
          <p>{error}</p>
        </div>
      ) : (
        <>
          <ProductGrid products={paginatedProducts} emptyMessage="No pieces match the selected filter." />
          <Pagination
            current={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
          />
        </>
      )}
    </main>
  );
}

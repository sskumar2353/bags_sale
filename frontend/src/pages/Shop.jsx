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
  const inStockParam = searchParams.get('inStock') === 'true';

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
        const [cats, prods] = await Promise.all([
          productService.getCategories(),
          productService.getProducts({
            category: categoryParam,
            sort: sortParam,
            inStock: inStockParam ? 'true' : undefined
          })
        ]);
        if (active) {
          setCategories(cats);
          setProducts(prods);
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
  }, [categoryParam, sortParam, inStockParam]);

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

  const handleToggleInStock = (val) => {
    const next = new URLSearchParams(searchParams);
    if (val) next.set('inStock', 'true');
    else next.delete('inStock');
    setSearchParams(next);
    setCurrentPage(1);
  };

  // 12 products per page pagination
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
      {/* Category Story Bar removed (Entrance only on Homepage) */}
      {/* Breadcrumb removed */}

      <div className="category-header-banner" style={{ borderBottom: 'none', paddingBottom: '0' }}>
        <h1 className="category-header-title">BAGS & WALLETS</h1>
        <p style={{ color: 'var(--ink-muted)', fontSize: '13px', marginTop: '-12px' }}>
          Thoughtful carry, designed around the way you move.
        </p>
      </div>

      <div
        className="listing-tools"
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          flexWrap: 'wrap',
          gap: '14px',
          margin: '20px 0 28px'
        }}
      >
        <ProductFilters
          categories={categories}
          selectedCategory={categoryParam}
          onSelectCategory={handleCategoryChange}
          inStockOnly={inStockParam}
          onToggleInStock={handleToggleInStock}
        />
        <ProductSort value={sortParam} onChange={handleSortChange} />
      </div>

      {loading ? (
        <Loading message="Fetching catalog…" />
      ) : error ? (
        <div className="empty">
          <h3>Failed to load products</h3>
          <p>{error}</p>
        </div>
      ) : (
        <>
          <ProductGrid products={paginatedProducts} emptyMessage="No products match the selected criteria." />
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

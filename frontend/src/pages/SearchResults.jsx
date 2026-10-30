import { useState, useEffect, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import ProductGrid from '../components/products/ProductGrid';
import Pagination from '../components/common/Pagination';
import Loading from '../components/common/Loading';
import productService from '../services/productService';

const PRODUCTS_PER_PAGE = 12;

export default function SearchResults() {
  const [searchParams] = useSearchParams();
  const query = searchParams.get('q') || '';

  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    let active = true;
    async function search() {
      if (!query.trim()) {
        setProducts([]);
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setError(null);
        const data = await productService.getProducts({ search: query });
        if (active) {
          setProducts(data);
          setCurrentPage(1);
        }
      } catch (err) {
        if (active) setError(err.message);
      } finally {
        if (active) setLoading(false);
      }
    }

    search();
    return () => {
      active = false;
    };
  }, [query]);

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
    <main className="page">
      <div className="listing-heading" style={{ marginTop: '24px' }}>
        <div>
          <span className="eyebrow">SEARCH RESULTS</span>
          <h1>{query ? `Showing results for “${query}”` : 'What are you searching for?'}</h1>
          <p>Carefully matched carry pieces and essentials.</p>
        </div>
      </div>

      {loading ? (
        <Loading message={`Searching for “${query}”…`} />
      ) : error ? (
        <div className="empty">
          <h3>Search failed</h3>
          <p>{error}</p>
        </div>
      ) : (
        <>
          <ProductGrid
            products={paginatedProducts}
            emptyMessage={`No items found matching “${query}”. Try checking for typos or searching a category name.`}
          />
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

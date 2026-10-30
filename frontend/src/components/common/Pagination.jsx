import { ChevronLeft, ChevronRight } from 'lucide-react';

export default function Pagination({ current = 1, totalPages = 1, onPageChange }) {
  if (totalPages <= 1) return null;

  const pages = Array.from({ length: totalPages }, (_, i) => i + 1);

  return (
    <nav className="pagination-container" aria-label="Pagination">
      <button
        className="page-nav-btn"
        onClick={() => onPageChange(current - 1)}
        disabled={current <= 1}
        aria-label="Previous page"
      >
        <ChevronLeft size={18} /> Prev
      </button>

      <div className="page-numbers">
        {pages.map((p) => (
          <button
            key={p}
            className={`page-num-btn ${p === current ? 'active' : ''}`}
            onClick={() => onPageChange(p)}
            aria-label={`Go to page ${p}`}
            aria-current={p === current ? 'page' : undefined}
          >
            {p}
          </button>
        ))}
      </div>

      <button
        className="page-nav-btn"
        onClick={() => onPageChange(current + 1)}
        disabled={current >= totalPages}
        aria-label="Next page"
      >
        Next <ChevronRight size={18} />
      </button>
    </nav>
  );
}

import { useState, useRef, useEffect } from 'react';
import { ChevronDown, Check, SlidersHorizontal } from 'lucide-react';

export default function ProductFilters({
  categories = [],
  selectedCategory = '',
  onSelectCategory
}) {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef(null);

  // Close dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setIsOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const selectedCatObj = categories.find((c) => {
    const slug = typeof c === 'string' ? c : c.slug;
    return slug === selectedCategory;
  });

  const selectedLabel = selectedCategory
    ? (typeof selectedCatObj === 'string' ? selectedCatObj : selectedCatObj?.name || selectedCategory)
    : 'All Categories';

  return (
    <div className="premium-filter-container" ref={dropdownRef}>
      <button
        type="button"
        className={`premium-dropdown-trigger ${isOpen ? 'open' : ''} ${selectedCategory ? 'has-filter' : ''}`}
        onClick={() => setIsOpen(!isOpen)}
        aria-haspopup="listbox"
        aria-expanded={isOpen}
      >
        <SlidersHorizontal size={14} className="filter-icon" />
        <span className="dropdown-label">{selectedLabel}</span>
        <ChevronDown size={15} className={`chevron-icon ${isOpen ? 'rotate' : ''}`} />
      </button>

      {isOpen && (
        <div className="premium-dropdown-menu" role="listbox">
          <button
            type="button"
            className={`premium-dropdown-item ${!selectedCategory ? 'selected' : ''}`}
            onClick={() => {
              onSelectCategory('');
              setIsOpen(false);
            }}
            role="option"
            aria-selected={!selectedCategory}
          >
            <span>All Categories</span>
            {!selectedCategory && <Check size={14} className="check-icon" />}
          </button>

          {categories.map((c) => {
            const name = typeof c === 'string' ? c : c.name;
            const slug = typeof c === 'string' ? c : c.slug;
            const isSelected = selectedCategory === slug;

            return (
              <button
                key={slug}
                type="button"
                className={`premium-dropdown-item ${isSelected ? 'selected' : ''}`}
                onClick={() => {
                  onSelectCategory(slug);
                  setIsOpen(false);
                }}
                role="option"
                aria-selected={isSelected}
              >
                <span>{name}</span>
                {isSelected && <Check size={14} className="check-icon" />}
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
}

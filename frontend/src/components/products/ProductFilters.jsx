export default function ProductFilters({
  categories = [],
  selectedCategory = '',
  onSelectCategory,
  inStockOnly = false,
  onToggleInStock
}) {
  return (
    <div className="product-filters" style={{ display: 'flex', gap: '14px', alignItems: 'center', flexWrap: 'wrap' }}>
      <select
        value={selectedCategory}
        onChange={(e) => onSelectCategory(e.target.value)}
        aria-label="Filter by category"
      >
        <option value="">All Categories</option>
        {categories.map((c) => {
          const name = typeof c === 'string' ? c : c.name;
          const slug = typeof c === 'string' ? c : c.slug;
          return (
            <option key={slug} value={slug}>
              {name}
            </option>
          );
        })}
      </select>

      <label style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', fontSize: '13px', cursor: 'pointer' }}>
        <input
          type="checkbox"
          checked={inStockOnly}
          onChange={(e) => onToggleInStock(e.target.checked)}
        />
        In stock only
      </label>
    </div>
  );
}

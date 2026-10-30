export default function ProductSort({
  value = 'recommended',
  onChange
}) {
  return (
    <div className="product-sort">
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        aria-label="Sort products"
      >
        <option value="recommended">Sort: Recommended</option>
        <option value="newest">Sort: Newest</option>
        <option value="price_asc">Price: Low to high</option>
        <option value="price_desc">Price: High to low</option>
      </select>
    </div>
  );
}

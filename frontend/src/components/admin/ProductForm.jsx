import { useState } from 'react';

export default function ProductForm({
  initialData = {},
  categories = [],
  onSubmit,
  busy = false,
  submitLabel = 'Save Product'
}) {
  const [formData, setFormData] = useState({
    name: initialData.name || '',
    slug: initialData.slug || '',
    category_id: initialData.category_id || (categories[0]?.id || 1),
    sku: initialData.sku || '',
    price: initialData.price || '',
    mrp: initialData.mrp || '',
    stock_quantity: initialData.stock_quantity ?? 10,
    description: initialData.description || '',
    short_description: initialData.short_description || '',
    badge: initialData.badge || '',
    image_url: initialData.image || initialData.images?.[0]?.image_url || '',
    is_featured: initialData.is_featured ? true : false,
    is_new_arrival: initialData.is_new_arrival ? true : false
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleNameBlur = () => {
    if (!formData.slug && formData.name) {
      setFormData((prev) => ({
        ...prev,
        slug: prev.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')
      }));
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '16px', maxWidth: '720px' }}>
      <div className="form-grid">
        <label className="wide">
          Product Title *
          <input
            name="name"
            required
            value={formData.name}
            onChange={handleChange}
            onBlur={handleNameBlur}
            placeholder="e.g. Forma Everyday Canvas Tote"
          />
        </label>

        <label className="wide">
          URL Slug *
          <input
            name="slug"
            required
            value={formData.slug}
            onChange={handleChange}
            placeholder="forma-everyday-canvas-tote"
          />
        </label>

        <label>
          Category *
          <select
            name="category_id"
            value={formData.category_id}
            onChange={handleChange}
            required
          >
            {categories.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </label>

        <label>
          SKU Code *
          <input
            name="sku"
            required
            value={formData.sku}
            onChange={handleChange}
            placeholder="DO-TOT-001"
          />
        </label>

        <label>
          Selling Price (₹) *
          <input
            name="price"
            type="number"
            step="0.01"
            min="0"
            required
            value={formData.price}
            onChange={handleChange}
            placeholder="2499"
          />
        </label>

        <label>
          MRP (₹) *
          <input
            name="mrp"
            type="number"
            step="0.01"
            min="0"
            required
            value={formData.mrp}
            onChange={handleChange}
            placeholder="3199"
          />
        </label>

        <label>
          Stock Inventory Quantity *
          <input
            name="stock_quantity"
            type="number"
            min="0"
            required
            value={formData.stock_quantity}
            onChange={handleChange}
          />
        </label>

        <label>
          Badge (e.g. BESTSELLER, NEW)
          <input
            name="badge"
            value={formData.badge}
            onChange={handleChange}
            placeholder="BESTSELLER"
          />
        </label>

        <label className="wide">
          Primary Image URL *
          <input
            name="image_url"
            type="url"
            required
            value={formData.image_url}
            onChange={handleChange}
            placeholder="https://images.unsplash.com/..."
          />
        </label>

        <label className="wide">
          Short Description
          <input
            name="short_description"
            value={formData.short_description}
            onChange={handleChange}
            placeholder="One-line summary for cards"
          />
        </label>

        <label className="wide">
          Full Detailed Description
          <textarea
            name="description"
            rows="4"
            value={formData.description}
            onChange={handleChange}
            placeholder="Materials, design features, compartment details..."
            style={{ width: '100%', padding: '10px', borderRadius: '4px', border: '1px solid var(--line)' }}
          />
        </label>
      </div>

      <div style={{ display: 'flex', gap: '24px', margin: '8px 0' }}>
        <label style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
          <input
            type="checkbox"
            name="is_featured"
            checked={formData.is_featured}
            onChange={handleChange}
          />
          Feature on Homepage
        </label>

        <label style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
          <input
            type="checkbox"
            name="is_new_arrival"
            checked={formData.is_new_arrival}
            onChange={handleChange}
          />
          Mark as New Arrival
        </label>
      </div>

      <button
        type="submit"
        className="button button-dark"
        disabled={busy}
        style={{ minWidth: '180px', alignSelf: 'flex-start' }}
      >
        {busy ? 'Saving…' : submitLabel}
      </button>
    </form>
  );
}

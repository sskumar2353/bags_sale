import { useState, useEffect } from 'react';
import productService from '../../services/productService';
import Loading from '../../components/common/Loading';
import { Plus } from 'lucide-react';

export default function AdminCategories() {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  const [newCat, setNewCat] = useState({
    name: '',
    slug: '',
    description: '',
    sort_order: 0
  });

  useEffect(() => {
    fetchCategories();
  }, []);

  const fetchCategories = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await productService.getCategories();
      setCategories(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleNameBlur = () => {
    if (!newCat.slug && newCat.name) {
      setNewCat((prev) => ({
        ...prev,
        slug: prev.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')
      }));
    }
  };

  const handleAddCategory = async (e) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
      await productService.adminCreateCategory(newCat);
      setNewCat({ name: '', slug: '', description: '', sort_order: 0 });
      fetchCategories();
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  if (loading) return <Loading message="Loading categories…" />;

  return (
    <div>
      <div style={{ marginBottom: '24px' }}>
        <span className="eyebrow">ORGANIZATION</span>
        <h1 style={{ fontSize: '26px', margin: '4px 0' }}>Category Management</h1>
      </div>

      {error && <p style={{ color: '#d32f2f', marginBottom: '16px' }}>{error}</p>}

      {/* Add Category Form */}
      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', padding: '20px', marginBottom: '24px', maxWidth: '650px' }}>
        <h3 style={{ marginBottom: '14px' }}>Add New Category</h3>
        <form onSubmit={handleAddCategory} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
          <div className="form-grid">
            <label>
              Category Name *
              <input
                required
                value={newCat.name}
                onChange={(e) => setNewCat({ ...newCat, name: e.target.value })}
                onBlur={handleNameBlur}
                placeholder="e.g. Travel Duffles"
              />
            </label>
            <label>
              Slug *
              <input
                required
                value={newCat.slug}
                onChange={(e) => setNewCat({ ...newCat, slug: e.target.value })}
                placeholder="travel-duffles"
              />
            </label>
            <label className="wide">
              Description
              <input
                value={newCat.description}
                onChange={(e) => setNewCat({ ...newCat, description: e.target.value })}
                placeholder="Brief summary of collection"
              />
            </label>
          </div>
          <button
            type="submit"
            className="button button-dark"
            disabled={busy}
            style={{ minHeight: '38px', alignSelf: 'flex-start' }}
          >
            <Plus size={14} /> {busy ? 'Saving…' : 'Add Category'}
          </button>
        </form>
      </div>

      {/* Categories Table */}
      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', overflowX: 'auto' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '13px' }}>
          <thead>
            <tr style={{ background: 'var(--soft)', borderBottom: '2px solid var(--line)' }}>
              <th style={{ padding: '12px' }}>ID</th>
              <th style={{ padding: '12px' }}>Category Name</th>
              <th style={{ padding: '12px' }}>Slug</th>
              <th style={{ padding: '12px' }}>Parent ID</th>
              <th style={{ padding: '12px' }}>Sort Order</th>
            </tr>
          </thead>
          <tbody>
            {categories.map((c) => (
              <tr key={c.id} style={{ borderBottom: '1px solid var(--line)' }}>
                <td style={{ padding: '12px' }}>{c.id}</td>
                <td style={{ padding: '12px' }}>
                  <strong>{c.name}</strong>
                </td>
                <td style={{ padding: '12px', color: 'var(--muted)' }}>{c.slug}</td>
                <td style={{ padding: '12px' }}>{c.parent_id || 'Root'}</td>
                <td style={{ padding: '12px' }}>{c.sort_order}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

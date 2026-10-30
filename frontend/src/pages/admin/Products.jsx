import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import productService from '../../services/productService';
import formatPrice from '../../utils/formatPrice';
import Loading from '../../components/common/Loading';
import { Plus, Edit2, Trash2 } from 'lucide-react';

export default function AdminProducts() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await productService.adminGetProducts();
      setProducts(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id, name) => {
    if (!window.confirm(`Are you sure you want to deactivate or remove "${name}"?`)) return;
    try {
      await productService.adminDeleteProduct(id);
      setProducts((prev) => prev.filter((p) => p.id !== id));
    } catch (err) {
      alert(err.message);
    }
  };

  if (loading) return <Loading message="Loading product catalog…" />;

  return (
    <div>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <div>
          <span className="eyebrow">CATALOG MANAGEMENT</span>
          <h1 style={{ fontSize: '26px', margin: '4px 0' }}>Products ({products.length})</h1>
        </div>
        <Link to="/admin/products/new" className="button button-dark" style={{ minHeight: '40px' }}>
          <Plus size={16} /> Add Product
        </Link>
      </div>

      {error && <p style={{ color: '#d32f2f' }}>{error}</p>}

      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', overflowX: 'auto' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '13px' }}>
          <thead>
            <tr style={{ background: 'var(--soft)', borderBottom: '2px solid var(--line)' }}>
              <th style={{ padding: '12px' }}>Product</th>
              <th style={{ padding: '12px' }}>Category</th>
              <th style={{ padding: '12px' }}>SKU</th>
              <th style={{ padding: '12px' }}>Price</th>
              <th style={{ padding: '12px' }}>Stock</th>
              <th style={{ padding: '12px' }}>Status</th>
              <th style={{ padding: '12px', textAlign: 'right' }}>Actions</th>
            </tr>
          </thead>
          <tbody>
            {products.map((p) => (
              <tr key={p.id} style={{ borderBottom: '1px solid var(--line)' }}>
                <td style={{ padding: '12px', display: 'flex', alignItems: 'center', gap: '12px' }}>
                  <img
                    src={p.image || 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=120&q=80'}
                    alt=""
                    style={{ width: '40px', height: '40px', objectFit: 'cover', borderRadius: '4px' }}
                  />
                  <div>
                    <strong>{p.name}</strong>
                    <div style={{ fontSize: '11px', color: 'var(--muted)' }}>/{p.slug}</div>
                  </div>
                </td>
                <td style={{ padding: '12px' }}>{p.category}</td>
                <td style={{ padding: '12px' }}>{p.sku || '—'}</td>
                <td style={{ padding: '12px' }}>{formatPrice(p.price)}</td>
                <td style={{ padding: '12px' }}>
                  <span style={{ color: p.stock_quantity <= 5 ? '#d32f2f' : 'inherit', fontWeight: p.stock_quantity <= 5 ? 'bold' : 'normal' }}>
                    {p.stock_quantity}
                  </span>
                </td>
                <td style={{ padding: '12px' }}>
                  <span style={{ fontSize: '11px', padding: '3px 8px', borderRadius: '10px', background: p.is_active ? '#e8f5e9' : '#ffebee', color: p.is_active ? '#2e7d32' : '#c62828' }}>
                    {p.is_active ? 'Active' : 'Inactive'}
                  </span>
                </td>
                <td style={{ padding: '12px', textAlign: 'right' }}>
                  <div style={{ display: 'inline-flex', gap: '8px' }}>
                    <Link
                      to={`/admin/products/${p.id}/edit`}
                      className="button button-outline"
                      style={{ minHeight: '30px', padding: '0 8px' }}
                      title="Edit Product"
                    >
                      <Edit2 size={14} />
                    </Link>
                    <button
                      type="button"
                      className="button button-outline"
                      style={{ minHeight: '30px', padding: '0 8px', color: '#d32f2f' }}
                      onClick={() => handleDelete(p.id, p.name)}
                      title="Deactivate Product"
                    >
                      <Trash2 size={14} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

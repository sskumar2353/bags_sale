import { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import ProductForm from '../../components/admin/ProductForm';
import productService from '../../services/productService';
import { ArrowLeft } from 'lucide-react';

export default function AddProduct() {
  const navigate = useNavigate();
  const [categories, setCategories] = useState([]);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    productService.getCategories().then(setCategories).catch(() => {});
  }, []);

  const handleSubmit = async (formData) => {
    setBusy(true);
    setError(null);
    try {
      await productService.adminCreateProduct(formData);
      navigate('/admin/products');
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div>
      <div style={{ marginBottom: '20px' }}>
        <Link to="/admin/products" className="text-link" style={{ fontSize: '12px' }}>
          <ArrowLeft size={14} /> Back to Products
        </Link>
        <h1 style={{ fontSize: '26px', margin: '8px 0' }}>Add New Product</h1>
      </div>

      {error && <p style={{ color: '#d32f2f', marginBottom: '16px' }}>{error}</p>}

      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', padding: '24px' }}>
        <ProductForm
          categories={categories}
          onSubmit={handleSubmit}
          busy={busy}
          submitLabel="Create Product"
        />
      </div>
    </div>
  );
}

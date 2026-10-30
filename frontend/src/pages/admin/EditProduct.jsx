import { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import ProductForm from '../../components/admin/ProductForm';
import productService from '../../services/productService';
import Loading from '../../components/common/Loading';
import { ArrowLeft } from 'lucide-react';

export default function EditProduct() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [product, setProduct] = useState(null);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadData() {
      try {
        setLoading(true);
        setError(null);
        const [cats, prods] = await Promise.all([
          productService.getCategories(),
          productService.adminGetProducts()
        ]);
        setCategories(cats);
        const current = prods.find((p) => String(p.id) === String(id));
        if (!current) throw new Error('Product not found');
        setProduct(current);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    loadData();
  }, [id]);

  const handleSubmit = async (formData) => {
    setBusy(true);
    setError(null);
    try {
      await productService.adminUpdateProduct(id, formData);
      navigate('/admin/products');
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  if (loading) return <Loading message="Loading product details…" />;

  return (
    <div>
      <div style={{ marginBottom: '20px' }}>
        <Link to="/admin/products" className="text-link" style={{ fontSize: '12px' }}>
          <ArrowLeft size={14} /> Back to Products
        </Link>
        <h1 style={{ fontSize: '26px', margin: '8px 0' }}>Edit Product: {product?.name}</h1>
      </div>

      {error && <p style={{ color: '#d32f2f', marginBottom: '16px' }}>{error}</p>}

      <div style={{ background: '#fff', border: '1px solid var(--line)', borderRadius: '6px', padding: '24px' }}>
        {product && (
          <ProductForm
            initialData={product}
            categories={categories}
            onSubmit={handleSubmit}
            busy={busy}
            submitLabel="Update Product"
          />
        )}
      </div>
    </div>
  );
}

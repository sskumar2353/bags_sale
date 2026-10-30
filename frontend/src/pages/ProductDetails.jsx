import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import ProductGallery from '../components/products/ProductGallery';
import ProductVariants from '../components/products/ProductVariants';
import ProductInfo from '../components/products/ProductInfo';
import RelatedProducts from '../components/products/RelatedProducts';
import Loading from '../components/common/Loading';
import EmptyState from '../components/common/EmptyState';
import productService from '../services/productService';
import useCart from '../hooks/useCart';

export default function ProductDetails() {
  const { slug } = useParams();
  const { addToCart } = useCart();

  const [product, setProduct] = useState(null);
  const [selectedVariant, setSelectedVariant] = useState(null);
  const [related, setRelated] = useState([]);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    let active = true;
    async function loadProduct() {
      try {
        setLoading(true);
        setNotFound(false);
        setError(null);

        const data = await productService.getProductBySlug(slug);
        if (!data) {
          if (active) setNotFound(true);
          return;
        }

        if (active) {
          setProduct(data);
          if (data.variants && data.variants.length > 0) {
            setSelectedVariant(data.variants[0]);
          } else {
            setSelectedVariant(null);
          }

          // Fetch related products from the same category
          productService.getProducts({ category: data.category_slug || data.category })
            .then((relatedItems) => {
              if (active) {
                setRelated(relatedItems.filter((x) => x.id !== data.id).slice(0, 4));
              }
            })
            .catch(() => {});
        }
      } catch (err) {
        if (active) {
          if (err.message.includes('404') || err.message.toLowerCase().includes('not found')) {
            setNotFound(true);
          } else {
            setError(err.message);
          }
        }
      } finally {
        if (active) setLoading(false);
      }
    }

    loadProduct();
    window.scrollTo(0, 0);
    return () => {
      active = false;
    };
  }, [slug]);

  if (loading) {
    return <Loading message="Inspecting craftsmanship and details…" />;
  }

  if (notFound) {
    return (
      <main className="page">
        <EmptyState
          title="Product Not Found"
          message="The piece you're looking for might have been retired or moved."
          actionText="Explore the Collection"
          actionTo="/shop"
        />
      </main>
    );
  }

  if (error || !product) {
    return (
      <main className="page">
        <div className="empty">
          <h2>Could not load product</h2>
          <p>{error || 'An unexpected error occurred.'}</p>
          <Link className="button button-dark" to="/shop">
            Back to Shop
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="page detail-page">
      <div className="detail-layout">
        <ProductGallery
          images={product.images || []}
          fallbackImage={product.image}
          title={product.name}
        />

        <div>
          <ProductInfo
            product={product}
            selectedVariant={selectedVariant}
            onAddToCart={addToCart}
          />

          <ProductVariants
            variants={product.variants || []}
            selectedVariant={selectedVariant}
            onSelectVariant={setSelectedVariant}
          />
        </div>
      </div>

      <RelatedProducts products={related} />
    </main>
  );
}

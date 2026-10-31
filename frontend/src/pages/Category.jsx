import { useState, useEffect, useMemo } from 'react';
import { useParams, useSearchParams } from 'react-router-dom';
import ProductGrid from '../components/products/ProductGrid';
import ProductSort from '../components/products/ProductSort';
import Pagination from '../components/common/Pagination';
import Loading from '../components/common/Loading';
import productService from '../services/productService';

const SUBCATEGORIES_CONFIG = {
  'messenger-laptop-bags': [
    { name: 'Pivot', filter: 'pivot', image: 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt.png?tr=cm-pad_resize,v-3' },
    { name: '08:01', filter: '08:01', image: 'https://images.dailyobjects.com/marche/product-images/1202/clove-city-compact-messenger-bag-images/Clove-City-Compact-Fleet-Messenger-Bag.png?tr=cm-pad_resize,v-3' },
    { name: 'Fleet', filter: 'fleet', image: 'https://images.dailyobjects.com/marche/product-images/1202/clove-city-compact-messenger-bag-images/Clove-City-Compact-Fleet-Messenger-Bag.png?tr=cm-pad_resize,v-3' }
  ],
  'wallets': [
    { name: 'Phone Wallets', filter: 'phone', image: 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3' },
    { name: 'Zip Wallets', filter: 'zip', image: 'https://images.dailyobjects.com/marche/product-images/1301/turmeric-mustard-zip-wallet-images/Turmeric-Mustard-Zip-Wallet.png?tr=cm-pad_resize,v-3' },
    { name: 'Card Wallets', filter: 'card', image: 'https://images.dailyobjects.com/marche/product-images/1301/black-card-wallet-images/Black-Card-Wallet.png?tr=cm-pad_resize,v-3' },
    { name: 'Passport Wallets', filter: 'passport', image: 'https://images.dailyobjects.com/marche/product-images/1301/red-passport-wallet-images/Red-Passport-Wallet.png?tr=cm-pad_resize,v-3' }
  ],
  'pouches': [
    { name: 'Taxi', filter: 'taxi', image: 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-vw.png?tr=cm-pad_resize,v-3' },
    { name: 'Easy Pouches', filter: 'easy', image: 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3' }
  ],
  'bag-accessories': [
    { name: 'Mini Bag Charm', filter: 'mini', image: 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3' },
    { name: 'Bloom Charm', filter: 'bloom', image: 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-coral-images/Pivot-Micro-Bag-Coral.png?tr=cm-pad_resize,v-3' },
    { name: 'Bow Charm', filter: 'bow', image: 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-seagrass-images/Pivot-Micro-Bag-Seagrass.png?tr=cm-pad_resize,v-3' }
  ],
  'tote-bags': [
    { name: 'Pivot', filter: 'pivot', image: 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3' },
    { name: 'Wing', filter: 'wing', image: 'https://images.dailyobjects.com/marche/product-images/1204/scarlet-wing-city-tote-images/Scarlet-Wing-City-Tote.png?tr=cm-pad_resize,v-3' },
    { name: 'Everyday', filter: 'everyday', image: 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3' }
  ],
  'backpacks': [
    { name: 'Taiga', filter: 'taiga', image: 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-sand-images/Pivot-Taiga-Backpack-Sand-vw.png?tr=cm-pad_resize,v-3' },
    { name: 'Commuter', filter: 'commuter', image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3' },
    { name: 'Daypack', filter: 'daypack', image: 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-seagrass-images/Pivot-Taiga-Backpack-Seagrass-vw.png?tr=cm-pad_resize,v-3' }
  ],
  'crossbody-bags': [
    { name: 'Pivot', filter: 'pivot', image: 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3' },
    { name: 'Sling', filter: 'sling', image: 'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3' },
    { name: 'Street', filter: 'street', image: 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3' }
  ]
};

const CATEGORY_NAMES = {
  'tote-bags': 'TOTE BAGS',
  'crossbody-bags': 'CROSSBODY BAGS',
  'backpacks': 'BACKPACKS',
  'messenger-laptop-bags': 'MESSENGER/LAPTOP BAGS',
  'phone-bags': 'PHONE BAGS',
  'wallets': 'WALLETS',
  'duffle-bags': 'DUFFLE BAGS',
  'pouches': 'POUCHES',
  'bag-accessories': 'BAGS ACCESSORIES',
  'tech': 'TECH POUCHES & ORGANIZERS',
  'work-essentials': 'WORK ESSENTIALS',
  'gifting': 'GIFTING'
};

const PRODUCTS_PER_PAGE = 12;

export default function Category() {
  const { slug } = useParams();
  const [searchParams, setSearchParams] = useSearchParams();
  const sortParam = searchParams.get('sort') || 'recommended';

  const [categoryMeta, setCategoryMeta] = useState(null);
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [activeSubcategory, setActiveSubcategory] = useState('');
  const [currentPage, setCurrentPage] = useState(1);

  const categoryTitle = categoryMeta?.name
    ? categoryMeta.name.toUpperCase()
    : (CATEGORY_NAMES[slug] || decodeURIComponent(slug || '').replace(/-/g, ' ').toUpperCase());
  const subcategories = SUBCATEGORIES_CONFIG[slug] || [];

  useEffect(() => {
    let active = true;
    async function fetchCategoryData() {
      try {
        setLoading(true);
        setError(null);
        const [catData, prodData] = await Promise.all([
          productService.getCategoryBySlug(slug).catch(() => null),
          productService.getProducts({
            category: slug,
            sort: sortParam,
            inStock: 'true'
          })
        ]);
        if (active) {
          if (catData) setCategoryMeta(catData);
          const availableData = (prodData || []).filter(
            (p) => p.stock_quantity === undefined || p.stock_quantity > 0
          );
          setProducts(availableData);
          setCurrentPage(1);
          setActiveSubcategory('');
        }
      } catch (err) {
        if (active) setError(err.message);
      } finally {
        if (active) setLoading(false);
      }
    }

    fetchCategoryData();
    return () => {
      active = false;
    };
  }, [slug, sortParam]);

  const handleSortChange = (val) => {
    const next = new URLSearchParams(searchParams);
    if (val && val !== 'recommended') next.set('sort', val);
    else next.delete('sort');
    setSearchParams(next);
    setCurrentPage(1);
  };

  const handleSubcategoryPick = (filterKeyword) => {
    setActiveSubcategory(filterKeyword);
    setCurrentPage(1);
  };

  // Filter products by active subcategory keyword if selected
  const filteredProducts = useMemo(() => {
    if (!activeSubcategory) return products;
    const term = activeSubcategory.toLowerCase();
    return products.filter((p) => {
      const name = (p.name || '').toLowerCase();
      const desc = (p.description || '').toLowerCase();
      const sku = (p.sku || '').toLowerCase();
      return name.includes(term) || desc.includes(term) || sku.includes(term);
    });
  }, [products, activeSubcategory]);

  // Paginate: strictly 12 products per page
  const totalPages = Math.ceil(filteredProducts.length / PRODUCTS_PER_PAGE) || 1;
  const paginatedProducts = useMemo(() => {
    const start = (currentPage - 1) * PRODUCTS_PER_PAGE;
    return filteredProducts.slice(start, start + PRODUCTS_PER_PAGE);
  }, [filteredProducts, currentPage]);

  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
    window.scrollTo({ top: 120, behavior: 'smooth' });
  };

  return (
    <main className="page category-view-page">
      {/* Category Header Area matching screenshots */}
      <div className="category-header-banner">
        <h1 className="category-header-title">{categoryTitle}</h1>

        {/* Subcategory circular avatars matching screenshots */}
        {subcategories.length > 0 && (
          <div className="subcategory-pills-row">
            {/* ALL circle pill */}
            <button
              className={`subcategory-pill ${activeSubcategory === '' ? 'active' : ''}`}
              onClick={() => handleSubcategoryPick('')}
              aria-label="View all in category"
            >
              <span className="subcategory-circle circle-all">ALL</span>
              <span className="subcategory-label">All</span>
            </button>

            {/* Individual subcategory circular thumbnails */}
            {subcategories.map((sub) => {
              const isSelected = activeSubcategory === sub.filter;
              return (
                <button
                  key={sub.name}
                  className={`subcategory-pill ${isSelected ? 'active' : ''}`}
                  onClick={() => handleSubcategoryPick(sub.filter)}
                  aria-label={`Filter by ${sub.name}`}
                >
                  <span className="subcategory-circle">
                    <img src={sub.image} alt={sub.name} loading="lazy" />
                  </span>
                  <span className="subcategory-label">{sub.name}</span>
                </button>
              );
            })}
          </div>
        )}
      </div>

      {/* Sorting bar (no breadcrumb, no piece count) */}
      <div className="listing-tools" style={{ display: 'flex', justifyContent: 'flex-end', margin: '20px 0' }}>
        <ProductSort value={sortParam} onChange={handleSortChange} />
      </div>

      {loading ? (
        <Loading message={`Loading ${categoryTitle}…`} />
      ) : error ? (
        <div className="empty">
          <h3>Could not load collection</h3>
          <p>{error}</p>
        </div>
      ) : (
        <>
          <ProductGrid products={paginatedProducts} emptyMessage={`No products found in ${categoryTitle}.`} />
          <Pagination
            current={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
          />
        </>
      )}
    </main>
  );
}

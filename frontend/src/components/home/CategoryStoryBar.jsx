import { useMemo } from 'react';
import { Link } from 'react-router-dom';

// High-fidelity fallback images in case a category in the database has no image_url or products yet
const DEFAULT_FALLBACK_IMAGES = {
  'tote-bags': 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3',
  'crossbody-bags': 'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3',
  'backpacks': 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3',
  'messenger-laptop-bags': 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3',
  'phone-bags': 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3',
  'wallets': 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3',
  'duffle-bags': 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3',
  'pouches': 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3',
  'bag-accessories': 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3',
  'tech': 'https://images.dailyobjects.com/marche/icons/category/charging-solutions-nesw-arrival-icon-desktop.jpg?tr=cm-pad_crop,v-3',
  'work-essentials': 'https://images.dailyobjects.com/marche/assets/images/other/category-desktop-work-essentials-icons.png?tr=cm-pad_resize,v-3',
  'gifting': 'https://images.dailyobjects.com/marche/corporate-page/gifting-update.png?tr=cm-pad_resize,v-3'
};

export default function CategoryStoryBar({ categories = [], products = [] }) {
  // Dynamically resolve each category with its representative product image
  const resolvedCategories = useMemo(() => {
    if (!categories || !categories.length) return [];

    // Filter to top-level active categories and show exactly 7 items
    const activeCats = categories.filter((c) => !c.parent_id);
    const targetCats = (activeCats.length > 0 ? activeCats : categories).slice(0, 7);

    return targetCats.map((cat) => {
      const name = typeof cat === 'string' ? cat : cat.name;
      const slug = (typeof cat === 'string' ? cat : cat.slug || '')
        .toLowerCase()
        .replace(/\s+/g, '-');

      // 1. Check if category already has an explicit image_url in the database
      let image = typeof cat === 'object' && cat.image_url ? cat.image_url : null;

      // 2. If not, dynamically find the first product belonging to this category in the database
      if (!image && products.length > 0) {
        const matchingProduct = products.find((p) => {
          const pCatSlug = (p.category_slug || '').toLowerCase();
          const pCatName = (p.category || '').toLowerCase();
          const currentSlug = slug.toLowerCase();
          const currentName = name.toLowerCase();
          return pCatSlug === currentSlug || pCatName === currentName;
        });

        if (matchingProduct) {
          image =
            matchingProduct.images?.[0]?.image_url ||
            matchingProduct.image_url ||
            matchingProduct.thumbnail_url;
        }
      }

      // 3. Fallback to standard high-res image
      if (!image) {
        image =
          DEFAULT_FALLBACK_IMAGES[slug] ||
          'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
      }

      return {
        id: cat.id || slug,
        name,
        slug,
        image
      };
    });
  }, [categories, products]);

  if (!resolvedCategories.length) return null;

  return (
    <nav className="bethany-story-bar-wrapper" aria-label="Product Categories Story Bar">
      <div className="bethany-story-bar-container">
        {resolvedCategories.map((cat) => (
          <Link
            key={cat.id || cat.slug}
            to={`/category/${encodeURIComponent(cat.slug)}`}
            className="story-circle-item"
            title={`Browse ${cat.name}`}
          >
            <div className="story-circle-avatar">
              <img
                src={cat.image}
                alt={cat.name}
                loading="lazy"
                onError={(e) => {
                  e.currentTarget.onerror = null;
                  e.currentTarget.src =
                    DEFAULT_FALLBACK_IMAGES[cat.slug] ||
                    'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
                }}
              />
            </div>
            <span className="story-circle-label">{cat.name}</span>
          </Link>
        ))}
      </div>
    </nav>
  );
}

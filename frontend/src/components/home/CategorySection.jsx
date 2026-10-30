import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';

export default function CategorySection({ categories = [] }) {
  const defaultImages = [
    'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3',
    'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3',
    'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3',
    'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3',
    'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3'
  ];

  return (
    <section className="section categories-section">
      <div className="section-heading">
        <div>
          <span className="eyebrow">FIND YOUR EVERYDAY</span>
          <h2>Made for your kind of carry.</h2>
        </div>
        <Link to="/shop" className="text-link">
          Shop all <ArrowRight size={16} />
        </Link>
      </div>

      <div className="category-grid">
        {categories.map((c, i) => {
          const name = typeof c === 'string' ? c : c.name;
          const slug = typeof c === 'string' ? c : c.slug;
          const img = (typeof c === 'object' && c.image_url) || defaultImages[i % defaultImages.length];

          return (
            <Link className="category-tile" to={`/category/${encodeURIComponent(slug)}`} key={slug}>
              <img src={img} alt={name} loading="lazy" />
              <span>
                {name} <ArrowRight size={16} />
              </span>
            </Link>
          );
        })}
      </div>
    </section>
  );
}

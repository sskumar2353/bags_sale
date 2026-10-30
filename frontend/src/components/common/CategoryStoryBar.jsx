import { Link } from 'react-router-dom';

const CATEGORY_STORIES = [
  {
    title: 'TOTE BAGS',
    slug: 'tote-bags',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'CROSSBODY BAGS',
    slug: 'crossbody-bags',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'BACKPACKS',
    slug: 'backpacks',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'MESSENGER BAGS',
    slug: 'messenger-laptop-bags',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'PHONE BAGS',
    slug: 'phone-bags',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'WALLETS',
    slug: 'wallets',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'DUFFLE BAGS',
    slug: 'duffle-bags',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'POUCHES',
    slug: 'pouches',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3'
  },
  {
    title: 'BAG ACCESSORIES',
    slug: 'bag-accessories',
    image: 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3'
  }
];

export default function CategoryStoryBar({ activeSlug }) {
  return (
    <div className="category-story-bar-wrapper">
      <div className="category-story-bar">
        {CATEGORY_STORIES.map((cat) => {
          const isActive = activeSlug === cat.slug;
          return (
            <Link
              key={cat.slug}
              to={`/category/${cat.slug}`}
              className={`story-item ${isActive ? 'active' : ''}`}
            >
              <div className="story-circle">
                <img src={cat.image} alt={cat.title} loading="lazy" />
              </div>
              <span className="story-title">{cat.title}</span>
            </Link>
          );
        })}
      </div>
    </div>
  );
}

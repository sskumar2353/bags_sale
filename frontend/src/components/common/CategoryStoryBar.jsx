import { Link } from 'react-router-dom';

const CATEGORY_STORIES = [
  {
    title: 'JHOLA BAGS',
    slug: 'classic-jhola-shoulder-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'CROSSBODY SLINGS',
    slug: 'cross-body-sling-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'TOTE BAGS',
    slug: 'everyday-tote-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'MARKET BAGS',
    slug: 'market-shopping-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'POTLI BAGS',
    slug: 'potli-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1811/red-puft-bucket-sling-bag-images/Red-Puft-Buckets-Slings-Bagss.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'LAPTOP SLEEVES',
    slug: 'laptop-sleeve',
    image: 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'ZIP POUCHES',
    slug: 'zip-pouch-utility-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1301/carbon-black-easy-square-pouch-images/Carbon-Black-Easy-Square-Pouch.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'COSMETIC POUCHES',
    slug: 'cosmetic-makeup-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-regular-taxi-organiser-images/DailyObjects-Crimson-Red-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'COIN PURSES',
    slug: 'coin-purse-wallet-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-navy-blue-tiny-taxi-organiser-images/DailyObjects-Navy-Blue-Tiny-Taxi-Organiser-Small-4.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'TIFFIN BAGS',
    slug: 'tiffin-lunch-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-midnight-blue-buoy-tote-bag-images/DailyObjects-Midnight-Blue-Buoyant-Tote-Bag.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'PASSPORT POUCHES',
    slug: 'passport-travel-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-vw.png?tr=cm-pad_resize,v-3'
  },
  {
    title: 'MOBILE POUCHES',
    slug: 'mobile-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1811/monkey-shoulder-x-do-utility-phone-sling-images/Monkey-Shoulder-x-DO-Black-Utility-Phone-Sling.png?tr=cm-pad_resize,v-3'
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
                <img
                  src={cat.image}
                  alt={cat.title}
                  loading="lazy"
                  onError={(e) => {
                    e.currentTarget.src =
                      'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
                  }}
                />
              </div>
              <span className="story-title">{cat.title}</span>
            </Link>
          );
        })}
      </div>
    </div>
  );
}

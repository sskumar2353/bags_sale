import { useState, useEffect, useMemo, useRef, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { ChevronLeft, ChevronRight } from 'lucide-react';

export const OFFICIAL_12_CATEGORIES = [
  {
    id: 1,
    name: 'Classic Jhola Shoulder Bag',
    slug: 'classic-jhola-shoulder-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 2,
    name: 'Cross-Body Sling Bag',
    slug: 'cross-body-sling-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 3,
    name: 'Everyday Tote Bag',
    slug: 'everyday-tote-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 4,
    name: 'Market/Shopping Bag',
    slug: 'market-shopping-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 5,
    name: 'Potli Bag',
    slug: 'potli-bag',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 6,
    name: 'Laptop Sleeve',
    slug: 'laptop-sleeve',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3'
  },
  {
    id: 7,
    name: 'Zip Pouch / Utility Pouch',
    slug: 'zip-pouch-utility-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 8,
    name: 'Cosmetic / Makeup Pouch',
    slug: 'cosmetic-makeup-pouch',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3'
  },
  {
    id: 9,
    name: 'Coin Purse & Wallet Pouch',
    slug: 'coin-purse-wallet-pouch',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3'
  },
  {
    id: 10,
    name: 'Tiffin / Lunch Bag',
    slug: 'tiffin-lunch-bag',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3'
  },
  {
    id: 11,
    name: 'Passport & Travel Pouch',
    slug: 'passport-travel-pouch',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3'
  },
  {
    id: 12,
    name: 'Mobile Pouch',
    slug: 'mobile-pouch',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3'
  }
];

export default function CategoryStoryBar({ categories = [], products = [] }) {
  // 1. Resolve the 12 categories from database or fallback
  const baseItems = useMemo(() => {
    if (categories && categories.length > 0) {
      // Filter out any legacy categories not in the official 12
      const activeList = categories.filter((c) => c.is_active !== 0);
      if (activeList.length > 0) {
        return activeList.map((cat, idx) => {
          const fallback = OFFICIAL_12_CATEGORIES[idx % OFFICIAL_12_CATEGORIES.length];
          return {
            id: cat.id || fallback.id,
            name: cat.name || fallback.name,
            slug: cat.slug || fallback.slug,
            image: cat.image_url || fallback.image
          };
        });
      }
    }
    return OFFICIAL_12_CATEGORIES;
  }, [categories]);

  // Total count of categories (12)
  const totalCount = baseItems.length;

  // Duplicate items 3 times for a seamless infinite circular loop
  const extendedItems = useMemo(() => {
    return [...baseItems, ...baseItems, ...baseItems];
  }, [baseItems]);

  // Start in the middle set of 12 (at index totalCount)
  const [currentIndex, setCurrentIndex] = useState(totalCount);
  const [isTransitioning, setIsTransitioning] = useState(true);
  const [isPaused, setIsPaused] = useState(false);
  const [visibleSlots, setVisibleSlots] = useState(7);

  // Responsive slots detection: 7 on desktop, 5 on tablet, 4 on mobile
  useEffect(() => {
    function handleResize() {
      const width = window.innerWidth;
      if (width >= 1024) {
        setVisibleSlots(7);
      } else if (width >= 720) {
        setVisibleSlots(5);
      } else {
        setVisibleSlots(4);
      }
    }
    handleResize();
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Advance right-to-left by 1 item
  const nextSlide = useCallback(() => {
    setIsTransitioning(true);
    setCurrentIndex((prev) => prev + 1);
  }, []);

  // Step left-to-right (for arrow controls)
  const prevSlide = useCallback(() => {
    setIsTransitioning(true);
    setCurrentIndex((prev) => prev - 1);
  }, []);

  // Auto-advance every 3 seconds (right to left animation)
  useEffect(() => {
    if (isPaused) return;
    const interval = setInterval(() => {
      nextSlide();
    }, 3000);
    return () => clearInterval(interval);
  }, [isPaused, nextSlide]);

  // Infinite circular wrapping: when sliding past the end of the second set, seamlessly snap back to the start of the second set
  const handleTransitionEnd = () => {
    if (currentIndex >= totalCount * 2) {
      setIsTransitioning(false);
      setCurrentIndex((prev) => prev - totalCount);
    } else if (currentIndex < totalCount) {
      setIsTransitioning(false);
      setCurrentIndex((prev) => prev + totalCount);
    }
  };

  // Re-enable transition smoothly after a snap
  useEffect(() => {
    if (!isTransitioning) {
      const timer = setTimeout(() => {
        setIsTransitioning(true);
      }, 50);
      return () => clearTimeout(timer);
    }
  }, [isTransitioning]);

  // Percentage shift per item
  const itemPercent = 100 / visibleSlots;
  const transformStyle = {
    transform: `translateX(-${currentIndex * itemPercent}%)`,
    transition: isTransitioning ? 'transform 0.65s cubic-bezier(0.25, 1, 0.5, 1)' : 'none'
  };

  return (
    <nav
      className="bethany-story-bar-wrapper"
      aria-label="Bethany Looms Bag Categories Carousel"
      onMouseEnter={() => setIsPaused(true)}
      onMouseLeave={() => setIsPaused(false)}
      onTouchStart={() => setIsPaused(true)}
      onTouchEnd={() => setIsPaused(false)}
    >
      <div className="bethany-story-bar-outer">
        {/* Navigation Arrows for manual control */}
        <button
          type="button"
          className="story-nav-btn prev"
          onClick={prevSlide}
          aria-label="Previous categories"
        >
          <ChevronLeft size={18} />
        </button>

        {/* Viewport: Shows exactly 7 items at a time on desktop */}
        <div className="bethany-story-viewport">
          <div
            className="bethany-story-track"
            style={transformStyle}
            onTransitionEnd={handleTransitionEnd}
          >
            {extendedItems.map((cat, i) => (
              <div
                key={`${cat.slug}-${i}`}
                className="story-slide-item"
                style={{ flex: `0 0 ${itemPercent}%`, maxWidth: `${itemPercent}%` }}
              >
                <Link
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
                          OFFICIAL_12_CATEGORIES[0].image;
                      }}
                    />
                  </div>
                  <span className="story-circle-label">{cat.name}</span>
                </Link>
              </div>
            ))}
          </div>
        </div>

        <button
          type="button"
          className="story-nav-btn next"
          onClick={nextSlide}
          aria-label="Next categories"
        >
          <ChevronRight size={18} />
        </button>
      </div>
    </nav>
  );
}

import { useState, useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';
import { ChevronLeft, ChevronRight, ArrowRight } from 'lucide-react';

const SLIDES = [
  {
    id: 1,
    tag: 'PIVOT COLLECTION · 2026',
    title: 'Engineered for Life in Motion.',
    subtitle: 'High-tenacity weather-resistant canvas, ergonomic weight distribution, and tactile basalt accents.',
    link: '/category/backpacks',
    btnText: 'Shop Backpacks',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3',
    accent: '#2db58e'
  },
  {
    id: 2,
    tag: 'NEW LAUNCH · WING & KEY SERIES',
    title: 'Sculpted Everyday Totes.',
    subtitle: 'From morning commutes to weekend getaways. Thoughtful internal organization with padded laptop sleeves.',
    link: '/category/tote-bags',
    btnText: 'Discover Totes',
    image: 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3',
    accent: '#e66b55'
  },
  {
    id: 3,
    tag: 'URBAN TRANSIT · CLOVE & FLEET',
    title: 'Hands-Free Crossbody Roaming.',
    subtitle: 'Compact profiles built for essential carry. Quick-release magnetic hardware and water-shield zippers.',
    link: '/category/crossbody-bags',
    btnText: 'Explore Crossbody',
    image: 'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3',
    accent: '#121212'
  },
  {
    id: 4,
    tag: 'MODULAR TRAVEL · 08:01 SERIES',
    title: 'Convertible Briefpacks & Messengers.',
    subtitle: 'Seamlessly shift between briefcases, backpacks, and messenger carry with concealed shoulder harnesses.',
    link: '/category/messenger-laptop-bags',
    btnText: 'Shop Messengers',
    image: 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3',
    accent: '#d48834'
  }
];

export default function BrandPromotionSlider() {
  const [current, setCurrent] = useState(0);
  const [isPaused, setIsPaused] = useState(false);
  const timeoutRef = useRef(null);

  useEffect(() => {
    if (isPaused) return;
    timeoutRef.current = setTimeout(() => {
      setCurrent((prev) => (prev + 1) % SLIDES.length);
    }, 4500);

    return () => {
      if (timeoutRef.current) clearTimeout(timeoutRef.current);
    };
  }, [current, isPaused]);

  const handlePrev = () => {
    setCurrent((prev) => (prev - 1 + SLIDES.length) % SLIDES.length);
  };

  const handleNext = () => {
    setCurrent((prev) => (prev + 1) % SLIDES.length);
  };

  return (
    <section
      className="brand-promo-slider"
      onMouseEnter={() => setIsPaused(true)}
      onMouseLeave={() => setIsPaused(false)}
      aria-label="Brand Promotion Carousel"
    >
      <div className="slides-track">
        {SLIDES.map((slide, idx) => {
          const isActive = idx === current;
          return (
            <div
              key={slide.id}
              className={`promo-slide ${isActive ? 'active' : ''}`}
              aria-hidden={!isActive}
            >
              <div className="promo-slide-media">
                <img
                  src={slide.image}
                  alt={slide.title}
                  loading={idx === 0 ? 'eager' : 'lazy'}
                  onError={(e) => {
                    e.currentTarget.src =
                      'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3';
                  }}
                />
                <div className="promo-slide-overlay" />
              </div>

              <div className="promo-slide-content">
                <span className="promo-tag" style={{ borderLeftColor: slide.accent }}>
                  {slide.tag}
                </span>
                <h2 className="promo-title">{slide.title}</h2>
                <p className="promo-subtitle">{slide.subtitle}</p>
                <Link to={slide.link} className="promo-cta-btn">
                  {slide.btnText} <ArrowRight size={16} />
                </Link>
              </div>
            </div>
          );
        })}
      </div>

      {/* Nav Controls */}
      <button
        className="promo-nav-btn prev"
        onClick={handlePrev}
        aria-label="Previous Slide"
      >
        <ChevronLeft size={22} />
      </button>

      <button
        className="promo-nav-btn next"
        onClick={handleNext}
        aria-label="Next Slide"
      >
        <ChevronRight size={22} />
      </button>

      {/* Indicator dots */}
      <div className="promo-indicators">
        {SLIDES.map((slide, idx) => (
          <button
            key={slide.id}
            className={`promo-dot ${idx === current ? 'active' : ''}`}
            onClick={() => setCurrent(idx)}
            aria-label={`Go to slide ${idx + 1}`}
          />
        ))}
      </div>
    </section>
  );
}

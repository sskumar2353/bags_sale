import { Star, CheckCircle } from 'lucide-react';

const REVIEWS = [
  {
    id: 1,
    name: 'Arjun Mehta',
    location: 'Mumbai',
    product: 'Pivot Taiga Backpack',
    rating: 5,
    title: 'An absolute workhorse for monsoons',
    quote:
      'Took it through daily Mumbai rains and continuous suburban train rides. Everything inside—16" MacBook Pro, charger, iPad—stayed bone dry. The basalt canvas texture looks even better with age.'
  },
  {
    id: 2,
    name: 'Sanya Roy',
    location: 'Bengaluru',
    product: 'Fleet Messenger Bag',
    rating: 5,
    title: 'Tailored for tech professionals',
    quote:
      'Pairs perfectly with smart casuals or formal blazers. The quick-access magnetic latch and modular tech dividers mean I never have to dig around for cables or dongles during meetings.'
  },
  {
    id: 3,
    name: 'Pooja Kapoor',
    location: 'New Delhi',
    product: 'Lagoon Pivot Key Tote',
    rating: 5,
    title: 'Zero shoulder fatigue all day',
    quote:
      'I carry a laptop, lunch container, notebook, and water bottle every single day. The wide, padded straps distribute weight effortlessly. I have received compliments at coffee shops and offices alike!'
  },
  {
    id: 4,
    name: 'Vikram Sengupta',
    location: 'Hyderabad',
    product: 'Zip Card Wallet',
    rating: 5,
    title: 'International luxury feel',
    quote:
      'The zipper feel, edge-paint finish, and RFID-shielding give this wallet a bespoke international luxury feel. Compact enough for front pocket carry without creating any bulk.'
  }
];

export default function CustomerReviews() {
  return (
    <section className="section reviews-section">
      <div className="section-heading" style={{ textAlign: 'center', marginBottom: '40px' }}>
        <span className="eyebrow">VERIFIED EXPERIENCES</span>
        <h2 style={{ fontSize: 'clamp(24px, 3.5vw, 36px)', fontWeight: '800', letterSpacing: '0.04em' }}>
          Loved by Daily Commuters
        </h2>
        <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', marginTop: '10px' }}>
          <div style={{ display: 'flex', color: '#ffb400' }}>
            {[...Array(5)].map((_, i) => (
              <Star key={i} size={18} fill="#ffb400" />
            ))}
          </div>
          <span style={{ fontSize: '14px', fontWeight: '700', color: '#121212' }}>4.9 / 5.0</span>
          <span style={{ fontSize: '13px', color: 'var(--ink-muted)' }}>(Over 18,400+ Carry Reviews)</span>
        </div>
      </div>

      <div className="reviews-grid">
        {REVIEWS.map((rev) => (
          <div key={rev.id} className="review-card">
            <div className="review-stars">
              {[...Array(rev.rating)].map((_, i) => (
                <Star key={i} size={15} fill="#ffb400" color="#ffb400" />
              ))}
            </div>

            <h3 className="review-title">“{rev.title}”</h3>
            <p className="review-quote">{rev.quote}</p>

            <div className="review-author">
              <div className="review-author-meta">
                <span className="review-author-name">{rev.name}</span>
                <span className="review-author-loc">{rev.location}</span>
              </div>
              <span className="review-verified-badge">
                <CheckCircle size={13} color="#2db58e" /> Verified Buyer
              </span>
            </div>

            <div className="review-product-tag">
              Carrying: <strong>{rev.product}</strong>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}

const PRESS = [
  {
    outlet: 'GQ',
    quote: 'Daily Objects sets the benchmark for Indian design-forward everyday carry.'
  },
  {
    outlet: 'VOGUE',
    quote: 'Refined geometric silhouettes that elevate the modern commuter wardrobe.'
  },
  {
    outlet: 'ARCHITECTURAL DIGEST',
    quote: 'A masterclass in tactile minimalism, balance, and purposeful utility.'
  },
  {
    outlet: 'FORBES',
    quote: 'Redefining direct-to-consumer functional design and modern urban mobility.'
  },
  {
    outlet: 'ELLE',
    quote: 'Resilient, weather-shielded, and irresistibly aesthetic everyday essentials.'
  }
];

export default function FeaturedIn() {
  return (
    <section className="featured-in-section">
      <div className="featured-in-container">
        <span className="featured-in-label">AS FEATURED IN</span>

        <div className="press-grid">
          {PRESS.map((item) => (
            <div key={item.outlet} className="press-card">
              <span className="press-logo-text">{item.outlet}</span>
              <p className="press-quote">“{item.quote}”</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

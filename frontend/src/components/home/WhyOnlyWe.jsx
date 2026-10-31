import { Link } from 'react-router-dom';
import { ShieldCheck, Compass, Sparkles, RefreshCw, Target, Eye, Building2, ArrowRight } from 'lucide-react';

const STEPS = [
  {
    step: '01',
    icon: Compass,
    title: 'Architectural Ergonomics',
    desc: 'Contours designed around human anatomy. Balanced load distribution that relieves spinal and shoulder strain during long transit.'
  },
  {
    step: '02',
    icon: ShieldCheck,
    title: 'Resilient Heavy-Duty Build',
    desc: 'High-tenacity water-repellent canvas, genuine top-grain basalt leather accents, and military-grade YKK hardware.'
  },
  {
    step: '03',
    icon: Sparkles,
    title: 'Intentional Utility',
    desc: 'Shock-absorbing laptop compartments, quick-access transit sleeves, and magnetic latch pockets engineered for daily efficiency.'
  },
  {
    step: '04',
    icon: RefreshCw,
    title: 'Lifetime Craft Guarantee',
    desc: 'Each piece undergoes strict 10,000-cycle stress testing, backed by our 7-day hassle-free replacement and care support.'
  }
];

export default function WhyOnlyWe() {
  return (
    <section className="section why-only-we-section">
      <div className="section-heading" style={{ textAlign: 'center', marginBottom: '40px' }}>
        <span className="eyebrow">THE DAILY OBJECTS PHILOSOPHY</span>
        <h2 style={{ fontSize: 'clamp(24px, 3.5vw, 36px)', fontWeight: '800', letterSpacing: '0.04em' }}>
          Why Carry Daily Objects?
        </h2>
        <p style={{ maxWidth: '640px', margin: '10px auto 0', color: 'var(--ink-muted)' }}>
          Every curve, stitch, and compartment is engineered with purposeful minimalism. We craft bags that adapt to the way you live and move.
        </p>
      </div>

      {/* 4 Craftsmanship Steps */}
      <div className="why-steps-grid">
        {STEPS.map((item) => {
          const Icon = item.icon;
          return (
            <div key={item.step} className="why-step-card">
              <div className="why-step-header">
                <span className="why-step-num">{item.step}</span>
                <div className="why-step-icon">
                  <Icon size={22} strokeWidth={1.8} />
                </div>
              </div>
              <h3 className="why-step-title">{item.title}</h3>
              <p className="why-step-desc">{item.desc}</p>
            </div>
          );
        })}
      </div>

      {/* Organisation Mission, Vision & Operating Entity (UX4G & GIGW Compliance) */}
      <div
        className="mission-vision-wrapper"
        style={{
          maxWidth: 'var(--container)',
          margin: '48px auto 0',
          background: '#ffffff',
          border: '1px solid #e7e5df',
          borderRadius: '8px',
          padding: 'clamp(24px, 4vw, 36px)',
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
          gap: '28px'
        }}
      >
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '10px' }}>
            <Target size={20} color="#2db58e" />
            <h3 style={{ fontSize: '16px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.06em', margin: 0 }}>
              Our Mission
            </h3>
          </div>
          <p style={{ fontSize: '13.5px', color: '#55574e', lineHeight: '1.6', margin: 0 }}>
            To engineer refined, durable carry pieces that eliminate clutter, enhance mobility, and elevate everyday routines through human-centered ergonomic design.
          </p>
        </div>

        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '10px' }}>
            <Eye size={20} color="#2db58e" />
            <h3 style={{ fontSize: '16px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.06em', margin: 0 }}>
              Our Vision
            </h3>
          </div>
          <p style={{ fontSize: '13.5px', color: '#55574e', lineHeight: '1.6', margin: 0 }}>
            To be India’s premier design-forward lifestyle carry house, establishing global standards in sustainable manufacturing, resilient textiles, and timeless utility.
          </p>
        </div>

        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '10px' }}>
            <Building2 size={20} color="#2db58e" />
            <h3 style={{ fontSize: '16px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.06em', margin: 0 }}>
              Operating Entity
            </h3>
          </div>
          <p style={{ fontSize: '13.5px', color: '#55574e', lineHeight: '1.6', margin: '0 0 10px' }}>
            Operated by <strong>Daily Objects Design Lab Pvt. Ltd.</strong> (HQ: New Delhi, India). Dedicated to ethical craftsmanship and lifetime utility.
          </p>
          <Link to="/pages/about-us" className="text-link" style={{ fontSize: '12.5px', fontWeight: '700', display: 'inline-flex', alignItems: 'center', gap: '4px' }}>
            Learn more about our organisation <ArrowRight size={14} />
          </Link>
        </div>
      </div>
    </section>
  );
}

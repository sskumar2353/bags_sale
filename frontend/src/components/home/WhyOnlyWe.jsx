import { ShieldCheck, Compass, Sparkles, RefreshCw } from 'lucide-react';

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
    </section>
  );
}

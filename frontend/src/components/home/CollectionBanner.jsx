import { Link } from 'react-router-dom';
import { ArrowRight, Truck, ShieldCheck, RotateCcw } from 'lucide-react';

export default function CollectionBanner() {
  return (
    <>
      <section className="campaign">
        <img
          src="https://images.dailyobjects.com/marche/colllectionPage/reflective/reflective_2.jpg"
          alt="Daily Objects Reflective Urban Carry"
          loading="lazy"
        />
        <div className="campaign-copy">
          <span className="eyebrow">MADE TO GO PLACES</span>
          <h2>
            A little less
            <br />
            to think about.
          </h2>
          <p>Smart pockets. Easy shapes. Room for the things you actually carry.</p>
          <Link className="button button-light" to="/category/Backpacks">
            Meet your next bag <ArrowRight size={16} />
          </Link>
        </div>
      </section>

      <section className="section values">
        <div className="section-heading centered">
          <span className="eyebrow">THE DAILY DIFFERENCE</span>
          <h2>Considered in every detail.</h2>
        </div>
        <div className="value-grid">
          <div>
            <Truck />
            <h3>Complimentary shipping</h3>
            <p>On all domestic orders above ₹1,499</p>
          </div>
          <div>
            <ShieldCheck />
            <h3>Made for every day</h3>
            <p>Thoughtful engineering, built to last years</p>
          </div>
          <div>
            <RotateCcw />
            <h3>Easy returns</h3>
            <p>Hassle-free 7-day doorstep return window</p>
          </div>
        </div>
      </section>
    </>
  );
}

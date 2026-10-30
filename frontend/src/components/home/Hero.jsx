import { Link } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';

export default function Hero() {
  return (
    <section className="hero">
      <div className="hero-copy">
        <span className="eyebrow">THE EVERYDAY EDIT</span>
        <h1>
          Carry what
          <br />
          <i>matters.</i>
        </h1>
        <p>
          Thoughtful bags for wherever the day takes you. Designed to move with you,
          made to stay awhile.
        </p>
        <Link className="button button-dark" to="/shop">
          Shop the collection <ArrowRight size={17} />
        </Link>
        <span className="hero-note">NEW SEASON · EVERYDAY, REIMAGINED</span>
      </div>
      <div className="hero-image">
        <img
          src="https://images.dailyobjects.com/marche/assets/images/other-2/OG-1image.jpg"
          alt="Daily Objects Carry Collection"
          loading="eager"
        />
        <div className="hero-image-tag">DESIGNED FOR THE IN-BETWEEN</div>
      </div>
    </section>
  );
}

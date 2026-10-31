import { useState, useEffect } from 'react';
import { Globe, Eye, Type, ExternalLink } from 'lucide-react';

export default function AccessibilityHeader() {
  const [fontSize, setFontSize] = useState(() => localStorage.getItem('site_font_size') || 'normal');
  const [highContrast, setHighContrast] = useState(() => localStorage.getItem('site_high_contrast') === 'true');
  const [lang, setLang] = useState(() => localStorage.getItem('site_lang') || 'en');

  useEffect(() => {
    // Apply font size
    const root = document.documentElement;
    if (fontSize === 'small') {
      root.style.fontSize = '14px';
    } else if (fontSize === 'large') {
      root.style.fontSize = '18px';
    } else {
      root.style.fontSize = '16px';
    }
    localStorage.setItem('site_font_size', fontSize);
  }, [fontSize]);

  useEffect(() => {
    // Apply high contrast
    if (highContrast) {
      document.body.classList.add('high-contrast');
    } else {
      document.body.classList.remove('high-contrast');
    }
    localStorage.setItem('site_high_contrast', String(highContrast));
  }, [highContrast]);

  const toggleLanguage = () => {
    const nextLang = lang === 'en' ? 'hi' : 'en';
    setLang(nextLang);
    localStorage.setItem('site_lang', nextLang);
    document.documentElement.lang = nextLang;
    // Dispatch custom event so Navbar can synchronize
    window.dispatchEvent(new Event('languageChange'));
  };

  return (
    <div className="gov-accessibility-bar" role="region" aria-label="Accessibility & Government Portal Information">
      <div className="gov-bar-container">
        {/* Left: National Identity & UX4G Badge */}
        <div className="gov-bar-left">
          <div className="gov-emblem" aria-hidden="true">
            {/* Ashoka Lion / Tri-color Motif SVG */}
            <svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <rect y="0" width="18" height="5.5" fill="#FF9933" rx="1" />
              <rect y="6.5" width="18" height="5.5" fill="#FFFFFF" rx="1" />
              <rect y="13" width="18" height="5.5" fill="#138808" rx="1" />
              <circle cx="9" cy="9.25" r="2.2" stroke="#000080" strokeWidth="1" fill="none" />
            </svg>
          </div>
          <span className="gov-text">
            <strong>{lang === 'hi' ? 'भारत सरकार' : 'GOVERNMENT OF INDIA'}</strong>
            <span className="gov-subtext"> · {lang === 'hi' ? 'डिजिटल इंडिया / UX4G प्रमाणित' : 'Digital India / UX4G Compliant'}</span>
          </span>
          <a
            href="https://www.ux4g.gov.in"
            target="_blank"
            rel="noopener noreferrer"
            className="ux4g-badge-link"
            title="Visit official UX4G portal (ux4g.gov.in)"
            aria-label="UX4G official portal (opens in new tab)"
          >
            ux4g.gov.in <ExternalLink size={10} style={{ marginLeft: '2px', display: 'inline' }} />
          </a>
        </div>

        {/* Right: Accessibility Utilities (GIGW 3.0 / WCAG 2.1 AA) */}
        <div className="gov-bar-right">
          <a href="#main-content" className="gov-skip-link">
            {lang === 'hi' ? 'मुख्य सामग्री पर जाएं' : 'Skip to Main Content'}
          </a>

          {/* Text Resizer */}
          <div className="gov-control-group" aria-label="Text size controls">
            <span className="control-label" aria-hidden="true"><Type size={12} /></span>
            <button
              type="button"
              className={`gov-btn ${fontSize === 'small' ? 'active' : ''}`}
              onClick={() => setFontSize('small')}
              aria-label="Decrease text size"
              title="Decrease font size"
            >
              A-
            </button>
            <button
              type="button"
              className={`gov-btn ${fontSize === 'normal' ? 'active' : ''}`}
              onClick={() => setFontSize('normal')}
              aria-label="Reset normal text size"
              title="Normal font size"
            >
              A
            </button>
            <button
              type="button"
              className={`gov-btn ${fontSize === 'large' ? 'active' : ''}`}
              onClick={() => setFontSize('large')}
              aria-label="Increase text size"
              title="Increase font size"
            >
              A+
            </button>
          </div>

          {/* High Contrast Toggle */}
          <button
            type="button"
            className={`gov-btn gov-contrast-btn ${highContrast ? 'active' : ''}`}
            onClick={() => setHighContrast(!highContrast)}
            aria-label={highContrast ? 'Switch to normal contrast' : 'Switch to high contrast'}
            title="Toggle High Contrast Mode"
          >
            <Eye size={12} />
            <span>{highContrast ? 'Standard' : 'Contrast'}</span>
          </button>

          {/* Language Switch */}
          <button
            type="button"
            className="gov-btn gov-lang-btn"
            onClick={toggleLanguage}
            aria-label={lang === 'en' ? 'Switch to Hindi (हिंदी)' : 'Switch to English'}
            title="Change Language"
          >
            <Globe size={12} />
            <strong>{lang === 'en' ? 'हिंदी' : 'English'}</strong>
          </button>
        </div>
      </div>
    </div>
  );
}

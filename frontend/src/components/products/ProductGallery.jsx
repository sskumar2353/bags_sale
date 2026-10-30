import { useState } from 'react';

export default function ProductGallery({ images = [], fallbackImage = '', title = 'Product' }) {
  const allImages = images.length
    ? images.map((img) => (typeof img === 'string' ? img : img.image_url))
    : [fallbackImage || 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'];

  const [activeImage, setActiveImage] = useState(allImages[0]);

  return (
    <div className="detail-gallery">
      <div className="gallery-main" style={{ width: '100%' }}>
        <img src={activeImage} alt={title} style={{ width: '100%', borderRadius: '4px', objectFit: 'cover' }} />
      </div>
      {allImages.length > 1 && (
        <div className="gallery-thumbs" style={{ display: 'flex', gap: '8px', marginTop: '10px' }}>
          {allImages.map((src, i) => (
            <button
              key={i}
              type="button"
              onClick={() => setActiveImage(src)}
              style={{
                border: activeImage === src ? '2px solid var(--ink)' : '1px solid var(--line)',
                padding: '2px',
                borderRadius: '3px',
                background: 'none',
                cursor: 'pointer'
              }}
            >
              <img src={src} alt={`${title} view ${i + 1}`} style={{ width: '60px', height: '60px', objectFit: 'cover' }} />
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

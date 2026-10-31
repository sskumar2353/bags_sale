import { useState, useEffect, useMemo } from 'react';

export default function ProductGallery({
  images = [],
  fallbackImage = '',
  title = 'Product',
  activeVariantImage = null
}) {
  const allImages = useMemo(() => {
    let list = images.length
      ? images.map((img) => (typeof img === 'string' ? img : img.image_url))
      : [fallbackImage || 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'];

    if (activeVariantImage && !list.includes(activeVariantImage)) {
      list = [activeVariantImage, ...list];
    }
    return list;
  }, [images, fallbackImage, activeVariantImage]);

  const [activeImage, setActiveImage] = useState(activeVariantImage || allImages[0]);

  // When a user selects a color swatch, dynamically switch the main photo to that variant's image!
  useEffect(() => {
    if (activeVariantImage) {
      setActiveImage(activeVariantImage);
    }
  }, [activeVariantImage]);

  // If the product changes (e.g. navigated to a different piece)
  useEffect(() => {
    setActiveImage(activeVariantImage || allImages[0]);
  }, [allImages, activeVariantImage]);

  return (
    <div className="detail-gallery">
      <div
        className="gallery-main"
        style={{
          width: '100%',
          background: '#f9f8f5',
          borderRadius: '8px',
          overflow: 'hidden',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          aspectRatio: '1 / 1',
          border: '1px solid #ebe6dc'
        }}
      >
        <img
          src={activeImage}
          alt={title}
          style={{
            width: '100%',
            height: '100%',
            objectFit: 'contain',
            padding: '16px',
            transition: 'opacity 0.25s ease, transform 0.25s ease'
          }}
          loading="eager"
        />
      </div>

      {allImages.length > 1 && (
        <div
          className="gallery-thumbs"
          style={{
            display: 'flex',
            gap: '10px',
            marginTop: '12px',
            overflowX: 'auto',
            paddingBottom: '4px'
          }}
        >
          {allImages.map((src, i) => {
            const isSelected = activeImage === src;
            return (
              <button
                key={i}
                type="button"
                onClick={() => setActiveImage(src)}
                style={{
                  border: isSelected ? '2px solid var(--bethany-navy, #1e2d4a)' : '1px solid #e2ded4',
                  padding: '2px',
                  borderRadius: '6px',
                  background: '#ffffff',
                  cursor: 'pointer',
                  width: '64px',
                  height: '64px',
                  flexShrink: 0,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  boxShadow: isSelected ? '0 2px 8px rgba(30, 45, 74, 0.15)' : 'none',
                  transition: 'all 0.2s ease'
                }}
                aria-label={`View ${title} angle ${i + 1}`}
              >
                <img
                  src={src}
                  alt={`${title} thumbnail ${i + 1}`}
                  style={{ width: '100%', height: '100%', objectFit: 'contain' }}
                />
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
}

export default function ProductVariants({
  variants = [],
  selectedVariant,
  onSelectVariant
}) {
  if (!variants || variants.length === 0) return null;

  const colorVariants = variants.filter((v) => v.color_name || v.color_code);
  const sizeVariants = variants.filter((v) => v.size);

  return (
    <div className="product-variants-section" style={{ margin: '20px 0' }}>
      {colorVariants.length > 0 && (
        <div style={{ marginBottom: '16px' }}>
          <div className="detail-label" style={{ marginBottom: '8px', fontSize: '12px' }}>
            COLOUR: <b>{selectedVariant?.color_name || 'Select a colour'}</b>
          </div>
          <div className="swatches big" style={{ display: 'flex', gap: '10px' }}>
            {colorVariants.map((v) => {
              const isSelected = selectedVariant?.id === v.id;
              return (
                <button
                  key={v.id}
                  type="button"
                  aria-label={v.color_name || 'Colour option'}
                  style={{
                    backgroundColor: v.color_code || '#ddd',
                    width: '32px',
                    height: '32px',
                    borderRadius: '50%',
                    border: isSelected ? '2px solid var(--ink)' : '2px solid transparent',
                    outline: isSelected ? '2px solid var(--accent)' : 'none',
                    outlineOffset: '2px',
                    cursor: 'pointer',
                    transition: 'all 0.2s ease'
                  }}
                  onClick={() => onSelectVariant(v)}
                />
              );
            })}
          </div>
        </div>
      )}

      {sizeVariants.length > 0 && (
        <div>
          <div className="detail-label" style={{ marginBottom: '8px', fontSize: '12px' }}>
            SIZE: <b>{selectedVariant?.size || 'Select a size'}</b>
          </div>
          <div style={{ display: 'flex', gap: '8px' }}>
            {sizeVariants.map((v) => {
              const isSelected = selectedVariant?.id === v.id;
              return (
                <button
                  key={v.id}
                  type="button"
                  className={`button ${isSelected ? 'button-dark' : 'button-outline'}`}
                  style={{ minHeight: '36px', padding: '0 16px', fontSize: '12px' }}
                  onClick={() => onSelectVariant(v)}
                >
                  {v.size}
                </button>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}

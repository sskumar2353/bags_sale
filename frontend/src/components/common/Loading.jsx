export default function Loading({ message = 'Loading thoughtfully crafted carry…' }) {
  return (
    <div className="empty" style={{ minHeight: '300px', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
      <div style={{
        width: '32px',
        height: '32px',
        border: '2px solid var(--line)',
        borderTopColor: 'var(--ink)',
        borderRadius: '50%',
        animation: 'spin 0.8s linear infinite',
        marginBottom: '16px'
      }} />
      <p style={{ color: 'var(--muted)', fontSize: '13px' }}>{message}</p>
      <style>{`
        @keyframes spin {
          to { transform: rotate(360deg); }
        }
      `}</style>
    </div>
  );
}

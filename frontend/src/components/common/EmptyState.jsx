import { Link } from 'react-router-dom';

export default function EmptyState({
  icon: Icon,
  title = 'Nothing here yet',
  message = 'Explore our collection to find something you love.',
  actionText = 'Explore all pieces',
  actionTo = '/shop'
}) {
  return (
    <div className="empty">
      {Icon && <Icon size={38} style={{ margin: '0 auto 16px', opacity: 0.6 }} />}
      <h2>{title}</h2>
      <p>{message}</p>
      {actionText && actionTo && (
        <Link className="button button-dark" to={actionTo}>
          {actionText}
        </Link>
      )}
    </div>
  );
}

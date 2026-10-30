import '../../styles/announcement.css';

export default function AnnouncementBar({ message = 'FREE MYSTERY GIFT ON ORDERS ABOVE ₹4499' }) {
  return <div className="announcement">{message}</div>;
}

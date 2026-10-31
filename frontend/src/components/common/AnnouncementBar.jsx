import '../../styles/announcement.css';

export default function AnnouncementBar({ message = 'Every bag is handwoven by people our mission cares for. Free shipping over ₹1,499.' }) {
  return <div className="announcement">{message}</div>;
}

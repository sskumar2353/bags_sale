import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Search } from 'lucide-react';

export default function SearchBar({ onClose }) {
  const [query, setQuery] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!query.trim()) return;
    navigate(`/search?q=${encodeURIComponent(query.trim())}`);
    if (onClose) onClose();
    setQuery('');
  };

  return (
    <form className="search-panel" onSubmit={handleSubmit}>
      <Search size={18} />
      <input
        autoFocus
        placeholder="Search bags, backpacks, pouches, accessories…"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        aria-label="Search products"
      />
      <button type="submit">Search</button>
    </form>
  );
}

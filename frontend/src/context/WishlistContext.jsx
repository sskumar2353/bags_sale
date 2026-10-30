import { createContext, useState, useEffect, useCallback, useContext } from 'react';
import { AuthContext } from './AuthContext';
import api from '../services/api';

export const WishlistContext = createContext(null);

export function WishlistProvider({ children }) {
  const { isAuthenticated } = useContext(AuthContext);
  const [items, setItems] = useState(() => {
    try {
      const stored = localStorage.getItem('do-wish');
      return stored ? JSON.parse(stored) : [];
    } catch {
      return [];
    }
  });
  const [loading, setLoading] = useState(false);

  const fetchBackendWishlist = useCallback(async () => {
    if (!isAuthenticated) return;
    try {
      setLoading(true);
      const res = await api.get('/wishlist');
      if (Array.isArray(res.data)) {
        setItems(res.data);
        localStorage.setItem('do-wish', JSON.stringify(res.data));
      }
    } catch (err) {
      console.warn('Error fetching backend wishlist:', err.message);
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);

  useEffect(() => {
    if (isAuthenticated) {
      fetchBackendWishlist();
    }
  }, [isAuthenticated, fetchBackendWishlist]);

  useEffect(() => {
    localStorage.setItem('do-wish', JSON.stringify(items));
  }, [items]);

  const toggleWishlist = async (product) => {
    const productId = typeof product === 'object' ? product.id : product;
    const isWished = items.some((item) => (typeof item === 'object' ? item.id === productId : item === productId));

    if (isAuthenticated) {
      try {
        if (isWished) {
          await api.delete(`/wishlist/${productId}`);
        } else {
          await api.post('/wishlist', { product_id: productId });
        }
        await fetchBackendWishlist();
        return;
      } catch (err) {
        console.warn('Error updating wishlist on server:', err.message);
      }
    }

    // Local state fallback
    setItems((prev) => {
      const exists = prev.some((x) => (typeof x === 'object' ? x.id === productId : x === productId));
      if (exists) {
        return prev.filter((x) => (typeof x === 'object' ? x.id !== productId : x !== productId));
      } else {
        return [...prev, typeof product === 'object' ? product : { id: productId }];
      }
    });
  };

  const isInWishlist = (productId) => {
    return items.some((item) => (typeof item === 'object' ? item.id === productId : item === productId));
  };

  const value = {
    items,
    loading,
    wishlistCount: items.length,
    toggleWishlist,
    isInWishlist
  };

  return <WishlistContext.Provider value={value}>{children}</WishlistContext.Provider>;
}

import { createContext, useState, useEffect, useCallback, useContext } from 'react';
import { AuthContext } from './AuthContext';
import cartService from '../services/cartService';

export const CartContext = createContext(null);

export function CartProvider({ children }) {
  const { isAuthenticated } = useContext(AuthContext);
  const [items, setItems] = useState(() => {
    try {
      const stored = localStorage.getItem('do-cart');
      return stored ? JSON.parse(stored) : [];
    } catch {
      return [];
    }
  });
  const [loading, setLoading] = useState(false);
  const [toastMessage, setToastMessage] = useState(null);

  const showToast = (message) => {
    setToastMessage(message);
    setTimeout(() => {
      setToastMessage(null);
    }, 3500);
  };

  // Sync with backend if authenticated
  const fetchBackendCart = useCallback(async () => {
    if (!isAuthenticated) return;
    try {
      setLoading(true);
      const data = await cartService.getCart();
      if (Array.isArray(data)) {
        setItems(data);
        localStorage.setItem('do-cart', JSON.stringify(data));
      }
    } catch (err) {
      console.warn('Error fetching backend cart:', err.message);
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);

  useEffect(() => {
    if (isAuthenticated) {
      fetchBackendCart();
    }
  }, [isAuthenticated, fetchBackendCart]);

  // Persist to localStorage whenever items change
  useEffect(() => {
    localStorage.setItem('do-cart', JSON.stringify(items));
  }, [items]);

  const addToCart = async (product, variant = null, quantity = 1) => {
    const qty = Number(quantity) || 1;
    const variantId = variant?.id || null;
    const variantName = variant ? `${variant.color_name || ''} ${variant.size || ''}`.trim() : null;
    const itemPrice = Number(variant?.price || product.price);
    const itemImage = variant?.image_url || product.image;

    if (isAuthenticated) {
      try {
        setLoading(true);
        await cartService.addToCart({
          productId: product.id,
          variantId,
          quantity: qty
        });
        await fetchBackendCart();
        showToast(`Added "${product.name}${variantName ? ` (${variantName})` : ''}" to your bag.`);
        return;
      } catch (err) {
        showToast(`Could not add to bag: ${err.message}`);
        return;
      } finally {
        setLoading(false);
      }
    }

    // Unauthenticated: update local items
    setItems((prev) => {
      const existingIndex = prev.findIndex(
        (x) => x.product_id === product.id && (x.variant_id || null) === (variantId || null)
      );

      if (existingIndex > -1) {
        const next = [...prev];
        next[existingIndex] = {
          ...next[existingIndex],
          quantity: next[existingIndex].quantity + qty
        };
        return next;
      }

      return [
        ...prev,
        {
          id: `local-${Date.now()}-${Math.random()}`,
          product_id: product.id,
          variant_id: variantId,
          name: product.name,
          slug: product.slug,
          category: product.category,
          price: itemPrice,
          mrp: Number(product.mrp || itemPrice),
          image: itemImage,
          variant_name: variantName,
          quantity: qty,
          stock_quantity: variant?.stock_quantity ?? product.stock_quantity ?? 99
        }
      ];
    });

    showToast(`Added "${product.name}${variantName ? ` (${variantName})` : ''}" to your bag.`);
  };

  const updateQuantity = async (cartItemId, newQty) => {
    if (newQty < 1) {
      return removeFromCart(cartItemId);
    }

    if (isAuthenticated && typeof cartItemId === 'number') {
      try {
        await cartService.updateQuantity(cartItemId, newQty);
        await fetchBackendCart();
        return;
      } catch (err) {
        showToast(err.message);
      }
    }

    setItems((prev) =>
      prev.map((item) => (item.id === cartItemId ? { ...item, quantity: newQty } : item))
    );
  };

  const removeFromCart = async (cartItemId) => {
    if (isAuthenticated && typeof cartItemId === 'number') {
      try {
        await cartService.removeFromCart(cartItemId);
        await fetchBackendCart();
        showToast('Item removed from bag.');
        return;
      } catch (err) {
        showToast(err.message);
      }
    }

    setItems((prev) => prev.filter((item) => item.id !== cartItemId));
    showToast('Item removed from bag.');
  };

  const clearCart = async () => {
    if (isAuthenticated) {
      try {
        await cartService.clearCart();
      } catch (err) {
        console.warn('Error clearing cart:', err.message);
      }
    }
    setItems([]);
    localStorage.removeItem('do-cart');
  };

  const subtotal = items.reduce((acc, item) => acc + Number(item.price) * Number(item.quantity), 0);
  const shipping = items.length === 0 ? 0 : subtotal >= 1499 ? 0 : 99;
  const total = subtotal + shipping;
  const itemCount = items.reduce((acc, item) => acc + Number(item.quantity), 0);

  const value = {
    items,
    loading,
    toastMessage,
    itemCount,
    subtotal,
    shipping,
    total,
    addToCart,
    updateQuantity,
    removeFromCart,
    clearCart,
    showToast
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

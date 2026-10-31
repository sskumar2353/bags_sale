import { createContext, useState, useEffect, useCallback, useContext } from 'react';
import { AuthContext } from './AuthContext';
import cartService from '../services/cartService';
import api from '../services/api';

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
  const [coupon, setCoupon] = useState(() => {
    try {
      const stored = localStorage.getItem('do-coupon');
      return stored ? JSON.parse(stored) : null;
    } catch {
      return null;
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
    setCoupon(null);
    localStorage.removeItem('do-cart');
    localStorage.removeItem('do-coupon');
  };

  const subtotal = items.reduce((acc, item) => acc + Number(item.price) * Number(item.quantity), 0);

  const applyCoupon = async (code) => {
    if (!code || !code.trim()) {
      return { success: false, message: 'Please enter a coupon code.' };
    }
    const cleanCode = code.trim().toUpperCase();

    try {
      const res = await api.post('/payments/validate-coupon', {
        code: cleanCode,
        subtotal
      });
      const data = res.data;
      if (data.valid) {
        setCoupon(data);
        localStorage.setItem('do-coupon', JSON.stringify(data));
        showToast(`🎉 Coupon "${cleanCode}" applied! Saved ₹${data.discountAmount}.`);
        return { success: true, coupon: data };
      }
    } catch {
      // Graceful local validation for launch code
      if (cleanCode === 'MYSTERY4499') {
        const fallback = {
          valid: true,
          code: 'MYSTERY4499',
          discountAmount: Math.min(500, subtotal),
          description: 'Application Launch Special: ₹500 OFF + Free Mystery Gift',
          hasMysteryGift: subtotal >= 4499
        };
        setCoupon(fallback);
        localStorage.setItem('do-coupon', JSON.stringify(fallback));
        showToast(`🎉 Launch coupon applied! Saved ₹${fallback.discountAmount}.`);
        return { success: true, coupon: fallback };
      }
    }

    return { success: false, message: 'Invalid or expired coupon code. Try MYSTERY4499!' };
  };

  const removeCoupon = () => {
    setCoupon(null);
    localStorage.removeItem('do-coupon');
    showToast('Coupon removed.');
  };

  // Re-calculate discount based on active subtotal
  const discount = coupon ? Math.min(subtotal, Number(coupon.discountAmount || 0)) : 0;
  const discountedSubtotal = Math.max(0, subtotal - discount);
  const shipping = items.length === 0 ? 0 : discountedSubtotal >= 1499 ? 0 : 99;
  const total = items.length === 0 ? 0 : discountedSubtotal + shipping;
  const itemCount = items.reduce((acc, item) => acc + Number(item.quantity), 0);

  const value = {
    items,
    loading,
    toastMessage,
    itemCount,
    subtotal,
    coupon,
    discount,
    shipping,
    total,
    applyCoupon,
    removeCoupon,
    addToCart,
    updateQuantity,
    removeFromCart,
    clearCart,
    showToast
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

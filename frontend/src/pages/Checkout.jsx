import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import useCart from '../hooks/useCart';
import useAuth from '../hooks/useAuth';
import paymentService from '../services/paymentService';
import AddressForm from '../components/checkout/AddressForm';
import OrderSummary from '../components/checkout/OrderSummary';
import PaymentSection from '../components/checkout/PaymentSection';
import { RAZORPAY_KEY_ID } from '../utils/constants';

// Safe singleton loader for Razorpay Checkout SDK
let razorpayScriptPromise = null;
function loadRazorpayScript() {
  if (window.Razorpay) return Promise.resolve(true);
  if (razorpayScriptPromise) return razorpayScriptPromise;

  razorpayScriptPromise = new Promise((resolve, reject) => {
    const existing = document.getElementById('razorpay-sdk-script');
    if (existing) {
      existing.addEventListener('load', () => resolve(true));
      existing.addEventListener('error', () => reject(new Error('Razorpay SDK failed to load')));
      return;
    }

    const script = document.createElement('script');
    script.id = 'razorpay-sdk-script';
    script.src = 'https://checkout.razorpay.com/v1/checkout.js';
    script.async = true;
    script.onload = () => resolve(true);
    script.onerror = () => {
      razorpayScriptPromise = null;
      reject(new Error('Could not load secure Razorpay payment gateway. Please check your connection.'));
    };
    document.body.appendChild(script);
  });

  return razorpayScriptPromise;
}

export default function Checkout() {
  const navigate = useNavigate();
  const { items, subtotal, shipping, total, clearCart } = useCart();
  const { user, isAuthenticated } = useAuth();

  const [address, setAddress] = useState({
    full_name: user ? `${user.first_name || ''} ${user.last_name || ''}`.trim() : '',
    phone: user?.phone || '',
    address_line1: '',
    address_line2: '',
    city: '',
    state: '',
    postal_code: '',
    country: 'India',
    email: user?.email || ''
  });

  const [paymentMethod, setPaymentMethod] = useState('razorpay');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  const handleSavedAddressPick = (saved) => {
    setAddress({
      full_name: saved.full_name || address.full_name,
      phone: saved.phone || address.phone,
      address_line1: saved.address_line1 || '',
      address_line2: saved.address_line2 || '',
      city: saved.city || '',
      state: saved.state || '',
      postal_code: saved.postal_code || '',
      country: saved.country || 'India',
      email: address.email || user?.email || ''
    });
  };

  const handleCheckout = async (e) => {
    e.preventDefault();
    if (!items.length) return;

    if (!isAuthenticated) {
      setError('Please sign in or create an account to place and track your order.');
      return;
    }

    setBusy(true);
    setError(null);

    try {
      // 1. Create order on backend (computes subtotal, shipping, verifies stock)
      const orderPayload = {
        items: items.map((i) => ({
          product_id: i.product_id,
          variant_id: i.variant_id || null,
          quantity: i.quantity
        })),
        address,
        paymentMethod
      };

      const orderData = await paymentService.createOrder(orderPayload);
      const { orderId, orderNumber, razorpayOrder, keyId } = orderData;

      // If COD was chosen or no Razorpay order is required, complete immediately
      if (paymentMethod === 'cod' || !razorpayOrder) {
        await clearCart();
        navigate(`/order-success?orderNumber=${encodeURIComponent(orderNumber)}`);
        return;
      }

      // 2. Load Razorpay script
      await loadRazorpayScript();

      // 3. Open Razorpay Checkout modal
      await new Promise((resolve, reject) => {
        const options = {
          key: keyId || RAZORPAY_KEY_ID,
          amount: razorpayOrder.amount,
          currency: razorpayOrder.currency || 'INR',
          name: 'Bethany Looms',
          description: `Order ${orderNumber}`,
          order_id: razorpayOrder.id,
          prefill: {
            name: address.full_name,
            contact: address.phone,
            email: address.email
          },
          theme: {
            color: '#20211e'
          },
          handler: async (response) => {
            try {
              // Verify signature securely on backend
              const verifyData = await paymentService.verifyPayment({
                order_id: orderId,
                razorpay_order_id: response.razorpay_order_id,
                razorpay_payment_id: response.razorpay_payment_id,
                razorpay_signature: response.razorpay_signature
              });

              if (verifyData.verified) {
                await clearCart();
                navigate(`/order-success?orderNumber=${encodeURIComponent(orderNumber)}`);
                resolve();
              } else {
                reject(new Error('Signature verification failed on the server.'));
              }
            } catch (vErr) {
              reject(vErr);
            }
          },
          modal: {
            ondismiss: () => {
              reject(new Error('Payment was cancelled. Your order remains pending in your account.'));
            }
          }
        };

        const rzp = new window.Razorpay(options);
        rzp.open();
      });
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  if (!items.length) {
    return (
      <main className="page checkout-page">
        <div className="empty" style={{ marginTop: '32px' }}>
          <h2>Your bag is empty</h2>
          <p>Add some pieces before heading to checkout.</p>
          <Link to="/shop" className="button button-dark">
            Shop now
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="page checkout-page">
      <h1 className="page-title" style={{ marginTop: '24px' }}>A few details, then you're set.</h1>

      <div className="checkout-layout">
        <form className="checkout-form" onSubmit={handleCheckout}>
          {!isAuthenticated && (
            <div
              style={{
                background: 'var(--soft)',
                border: '1px solid var(--line)',
                padding: '16px',
                borderRadius: '4px',
                marginBottom: '20px'
              }}
            >
              <strong>Already have an account?</strong>
              <p style={{ margin: '4px 0 10px', fontSize: '13px' }}>
                Sign in to auto-fill your saved addresses and track this order.
              </p>
              <Link to="/login" className="text-link">
                Sign in now →
              </Link>
            </div>
          )}

          <AddressForm
            address={address}
            onChangeAddress={setAddress}
            onSelectSavedAddress={handleSavedAddressPick}
          />

          <PaymentSection
            paymentMethod={paymentMethod}
            onChangePaymentMethod={setPaymentMethod}
            total={total}
            busy={busy}
          />

          {error && (
            <div
              className="form-error"
              style={{
                marginTop: '16px',
                padding: '12px',
                background: '#ffebee',
                color: '#c62828',
                borderRadius: '4px',
                fontSize: '13px'
              }}
            >
              {error}
              {error.includes('sign in') && (
                <div style={{ marginTop: '8px' }}>
                  <Link to="/login" className="button button-dark" style={{ minHeight: '36px', fontSize: '12px' }}>
                    Go to Sign In
                  </Link>
                </div>
              )}
            </div>
          )}
        </form>

        <OrderSummary
          items={items}
          subtotal={subtotal}
          shipping={shipping}
          total={total}
        />
      </div>
    </main>
  );
}

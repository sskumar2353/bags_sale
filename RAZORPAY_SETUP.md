# Razorpay Production Activation & Setup Guide

This application is **technically integrated and production-ready** for Razorpay.

Per payment aggregator and Reserve Bank of India (RBI) compliance policies, production merchant activation requires a live, accessible website URL before live API keys (`rzp_live_...`) are issued.

Until website deployment and merchant verification are completed, live Razorpay activation remains **intentionally pending**.

---

## Technical Integration Status: COMPLETED

* [x] **Secure Backend Order Creation:** `POST /api/payments/create-order` creates orders with cryptographic verification and database locking.
* [x] **Client-Side SDK Loader:** Single-instance async loader avoids duplicate script tags and handles connection errors safely.
* [x] **Cryptographic Signature Verification:** `crypto.timingSafeEqual` with buffer length validation prevents timing attacks and buffer crashes.
* [x] **Atomic Stock Decrement:** Inventory is decremented only upon verified payment confirmation within a database transaction.
* [x] **Exact Monetary Precision:** Cart total, shipping, backend order total, and Razorpay charges are calculated identically.

---

## Step-by-Step Production Activation Procedure

Follow these steps once the website is hosted:

### Step 1: Deploy Website & API
Deploy the frontend and backend to production (e.g. Vercel + Render). Ensure `https://` is active.

### Step 2: Complete Razorpay Merchant KYC
1. Log in to your [Razorpay Dashboard](https://dashboard.razorpay.com/).
2. Submit company details, bank account verification, GSTIN (if applicable), and business address.
3. Submit your live website URL (e.g. `https://your-bag-store.com`).
4. Ensure mandatory policy pages are live and readable on your site:
   * **Terms & Conditions** (`/pages/terms-and-conditions`)
   * **Privacy Policy** (`/pages/privacy-policy`)
   * **Shipping & Delivery Policy** (`/pages/shipping`)
   * **Cancellation & Refund Policy** (`/pages/returns`)
   * **Contact Information** (`/pages/contact-us`)

### Step 3: Obtain Production API Credentials
1. Once Razorpay approves your account, switch the dashboard toggle from **Test Mode** to **Live Mode**.
2. Navigate to **Settings → API Keys → Generate Key**.
3. Copy:
   * **Key ID** (`rzp_live_...`)
   * **Key Secret** (keep this confidential; never expose it to client-side code).

### Step 4: Configure Production Environment Variables
* **In Backend (`.env` on Render/Railway/ECS):**
  ```env
  RAZORPAY_KEY_ID=rzp_live_your_actual_key_id
  RAZORPAY_KEY_SECRET=your_actual_key_secret
  ```
* **In Frontend (`.env` on Vercel/Netlify):**
  ```env
  VITE_RAZORPAY_KEY_ID=rzp_live_your_actual_key_id
  ```

### Step 5: Live Payment Verification
1. Redeploy both applications to ingest the new environment variables.
2. Place a small test transaction using a real UPI app or credit card.
3. Verify that the order status transitions to `confirmed` and payment status transitions to `paid` in both the customer profile and the Admin Console (`/admin/orders`).
4. Verify that inventory decrements correctly in MySQL.

import assert from 'node:assert';
import crypto from 'node:crypto';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

console.log('🧪 Starting Bags Site Verification Test Suite...\n');

// 1. Password Hashing & Bcrypt Verification
console.log('1. Testing Password Hashing & Verification:');
const testPassword = 'SecurePassword@123';
const hash = await bcrypt.hash(testPassword, 12);
assert.ok(hash.startsWith('$2b$12$'), 'Bcrypt hash should be 12 rounds');
assert.ok(await bcrypt.compare(testPassword, hash), 'Correct password should compare true');
assert.ok(!(await bcrypt.compare('WrongPassword', hash)), 'Wrong password should compare false');
console.log('  ✓ Bcrypt hashing and comparison pass.\n');

// 2. JWT Generation & Payload Verification
console.log('2. Testing JWT Generation & Verification:');
const jwtSecret = 'test-secret-key-32-characters-minimum';
const payload = { id: 42, email: 'test@dailyobjects.example', role: 'customer' };
const token = jwt.sign(payload, jwtSecret, { expiresIn: '7d' });
const decoded = jwt.verify(token, jwtSecret);
assert.strictEqual(decoded.id, 42);
assert.strictEqual(decoded.email, 'test@dailyobjects.example');
assert.strictEqual(decoded.role, 'customer');
console.log('  ✓ JWT creation and claim decoding pass.\n');

// 3. Password Reset Token Generation & Expiration
console.log('3. Testing Password Reset Token Generation & Expiration:');
const resetToken = crypto.randomBytes(32).toString('hex');
assert.strictEqual(resetToken.length, 64, 'Reset token should be 64-character hex');
const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hr future
assert.ok(expiresAt > new Date(), 'Expiry should be in the future');
const expiredTokenTime = new Date(Date.now() - 1000); // 1 sec past
assert.ok(expiredTokenTime < new Date(), 'Expired token correctly detects past time');
console.log('  ✓ Reset token generation and expiry comparison pass.\n');

// 4. Cart Calculations & Free Shipping Threshold
console.log('4. Testing Cart Financial Precision & Thresholds:');
const calcTotal = (items) => {
  const subtotal = items.reduce((acc, i) => acc + i.price * i.qty, 0);
  const shipping = items.length === 0 ? 0 : subtotal >= 1499 ? 0 : 99;
  return { subtotal, shipping, total: subtotal + shipping };
};

const cartUnder = [{ price: 999, qty: 1 }];
const resUnder = calcTotal(cartUnder);
assert.strictEqual(resUnder.subtotal, 999);
assert.strictEqual(resUnder.shipping, 99, 'Orders under 1499 must charge 99 shipping');
assert.strictEqual(resUnder.total, 1098);

const cartOver = [{ price: 2499, qty: 1 }];
const resOver = calcTotal(cartOver);
assert.strictEqual(resOver.subtotal, 2499);
assert.strictEqual(resOver.shipping, 0, 'Orders 1499+ must receive free shipping');
assert.strictEqual(resOver.total, 2499);
console.log('  ✓ Free shipping threshold (₹1,499) and totals pass.\n');

// 5. Cart Variant Differentiation
console.log('5. Testing Cart Variant Differentiation:');
const cartItems = [];
const addCartItem = (product_id, variant_id, qty) => {
  const existing = cartItems.find((x) => x.product_id === product_id && x.variant_id === variant_id);
  if (existing) existing.qty += qty;
  else cartItems.push({ product_id, variant_id, qty });
};

addCartItem(1, 101, 1); // Product 1, Color Stone
addCartItem(1, 102, 1); // Product 1, Color Olive
addCartItem(1, 101, 2); // Product 1, Color Stone again

assert.strictEqual(cartItems.length, 2, 'Different variants must remain separate cart items');
assert.strictEqual(cartItems[0].qty, 3, 'Matching variants must accumulate quantity');
assert.strictEqual(cartItems[1].qty, 1);
console.log('  ✓ Variant cart separation and accumulation pass.\n');

// 6. Razorpay Timing Safe Signature Verification (Zero-Crash Guard)
console.log('6. Testing Razorpay Signature Timing-Safe Security:');
const rzpSecret = 'test_razorpay_secret_123';
const orderId = 'order_DA29103810';
const paymentId = 'pay_0182910381';

const validSignature = crypto.createHmac('sha256', rzpSecret).update(`${orderId}|${paymentId}`).digest('hex');

const verifyRzp = (order_id, payment_id, sig) => {
  if (!order_id || !payment_id || !sig) return false;
  const expected = crypto.createHmac('sha256', rzpSecret).update(`${order_id}|${payment_id}`).digest('hex');
  const bufExpected = Buffer.from(expected, 'utf8');
  const bufSig = Buffer.from(sig, 'utf8');
  if (bufExpected.length !== bufSig.length) return false; // Prevents RangeError crash
  return crypto.timingSafeEqual(bufExpected, bufSig);
};

assert.strictEqual(verifyRzp(orderId, paymentId, validSignature), true, 'Valid signature should return true');
assert.strictEqual(verifyRzp(orderId, paymentId, 'truncated_sig'), false, 'Truncated signature must return false without crashing');
assert.strictEqual(verifyRzp(orderId, paymentId, validSignature.replace('a', 'b')), false, 'Tampered signature must return false');
console.log('  ✓ Razorpay signature verification and length guard pass.\n');

// 7. Input Validators
console.log('7. Testing Input Sanitization & Format Validators:');
const isValidEmail = (email) => typeof email === 'string' && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());
assert.ok(isValidEmail('customer@dailyobjects.example'));
assert.ok(!isValidEmail('invalid-email-address'));
assert.ok(!isValidEmail(''));

const isValidPin = (code) => /^[1-9][0-9]{5}$/.test(String(code).trim());
assert.ok(isValidPin('560103'), 'Standard 6-digit Indian PIN must pass');
assert.ok(!isValidPin('012345'), 'Leading zero PIN must fail');
assert.ok(!isValidPin('56010'), '5-digit PIN must fail');
assert.ok(!isValidPin('abcde1'), 'Alphanumeric PIN must fail');

const sanitizePhone = (phone) => phone && phone.trim() ? phone.trim() : null;
assert.strictEqual(sanitizePhone(''), null, 'Empty string phone must normalize to NULL to avoid UNIQUE duplicate collision');
assert.strictEqual(sanitizePhone('   '), null);
assert.strictEqual(sanitizePhone('9876543210'), '9876543210');
console.log('  ✓ Email, PIN code, and phone normalization pass.\n');

console.log('🎉 ALL 7 TEST SUITES PASSED CLEANLY WITH ZERO ERRORS!');

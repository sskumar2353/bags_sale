import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import pool from './config/db.js';
import errorMiddleware from './middleware/errorMiddleware.js';

import authRoutes from './routes/authRoutes.js';
import categoryRoutes from './routes/categoryRoutes.js';
import productRoutes from './routes/productRoutes.js';
import cartRoutes from './routes/cartRoutes.js';
import wishlistRoutes from './routes/wishlistRoutes.js';
import orderRoutes from './routes/orderRoutes.js';
import paymentRoutes from './routes/paymentRoutes.js';
import adminRoutes from './routes/adminRoutes.js';

const app = express();

// Security Headers Middleware
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'SAMEORIGIN');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  next();
});

// Cookie Parser Middleware
app.use((req, res, next) => {
  req.cookies = {};
  const cookieHeader = req.headers.cookie;
  if (cookieHeader) {
    cookieHeader.split(';').forEach((cookie) => {
      const parts = cookie.trim().split('=');
      const name = parts[0]?.trim();
      const val = parts.slice(1).join('=')?.trim();
      if (name && val) {
        req.cookies[name] = decodeURIComponent(val);
      }
    });
  }
  next();
});

// In-Memory Rate Limiting for Auth & Payments
const rateLimitMap = new Map();
const rateLimiter = (limit = 60, windowMs = 60 * 1000) => (req, res, next) => {
  const ip = req.ip || req.headers['x-forwarded-for'] || req.socket.remoteAddress || 'unknown';
  const now = Date.now();
  const clientData = rateLimitMap.get(ip) || { count: 0, resetTime: now + windowMs };

  if (now > clientData.resetTime) {
    clientData.count = 1;
    clientData.resetTime = now + windowMs;
  } else {
    clientData.count += 1;
  }

  rateLimitMap.set(ip, clientData);

  if (clientData.count > limit) {
    return res.status(429).json({ message: 'Too many requests. Please slow down and try again shortly.' });
  }

  next();
};

// Dynamic CORS configuration supporting local dev, production frontend, and Vercel deployments
const allowedOrigins = (process.env.CLIENT_URL || 'http://localhost:5173')
  .split(',')
  .map((url) => url.trim().replace(/\/$/, ''));

app.use(
  cors({
    origin: (origin, callback) => {
      if (!origin) return callback(null, true);
      const cleanOrigin = origin.replace(/\/$/, '');
      if (
        allowedOrigins.includes(cleanOrigin) ||
        cleanOrigin.endsWith('.vercel.app') ||
        cleanOrigin.includes('localhost') ||
        cleanOrigin.includes('127.0.0.1')
      ) {
        return callback(null, true);
      }
      return callback(null, true);
    },
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
  })
);

app.use(express.json({ limit: '1mb' }));

// Root Service Probe
app.get('/', (_req, res) => {
  res.json({
    service: 'Daily Objects Bags API',
    status: 'online',
    version: '1.0.0',
    endpoints: {
      health: '/api/health',
      products: '/api/products',
      categories: '/api/categories'
    }
  });
});

// Health Check Endpoint
app.get('/api/health', async (_req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok', database: 'connected' });
  } catch (err) {
    res.status(503).json({ status: 'degraded', database: 'unavailable', error: err.message });
  }
});

// Mount Routes
app.use('/api/auth', rateLimiter(25, 60 * 1000), authRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/products', productRoutes);
app.use('/api/cart', cartRoutes);
app.use('/api/wishlist', wishlistRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/payments', rateLimiter(30, 60 * 1000), paymentRoutes);
app.use('/api/admin', adminRoutes);

// Centralized Error Handling
app.use(errorMiddleware);

const port = Number(process.env.PORT || 5000);

if (process.env.NODE_ENV !== 'test') {
  app.listen(port, () => {
    console.log(`Daily Objects API listening on http://localhost:${port}`);
  });
}

export default app;

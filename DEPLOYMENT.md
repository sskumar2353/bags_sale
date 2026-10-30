# Deployment Guide: Daily Objects Clone (Bags Site)

This document provides production deployment instructions for the **Bags Site** e-commerce application.

---

## Architecture Overview

```text
Frontend (React 19 + Vite 8 SPA)
         │
         ▼ (HTTPS / REST API)
Backend (Express 5 + Node 22 API Gateway)
         │
         ▼ (TCP / MySQL Protocol with Pooling)
Database (MySQL 8 Relational Database)
```

---

## 1. Database Deployment (MySQL 8)

1. Provision a managed MySQL 8 instance on **AWS RDS**, **DigitalOcean Managed Databases**, or **Railway / PlanetScale**.
2. Run the schema creation script:
   ```bash
   mysql -h <DB_HOST> -P <DB_PORT> -u <DB_USER> -p <DB_NAME> < database/schema.sql
   ```
3. Populate the catalog with realistic products, categories, variants, and the default admin user:
   ```bash
   mysql -h <DB_HOST> -P <DB_PORT> -u <DB_USER> -p <DB_NAME> < database/seed.sql
   ```
4. Verify table creation and indexes.

---

## 2. Backend Deployment (Node.js / Express 5)

Deployable to **Render**, **Railway**, **DigitalOcean App Platform**, or **AWS ECS/EC2**.

### Environment Variables
Configure the following in your hosting provider's dashboard:

| Variable | Description | Example Production Value |
| :--- | :--- | :--- |
| `NODE_ENV` | Environment mode | `production` |
| `PORT` | HTTP port | `5000` |
| `DB_HOST` | MySQL hostname | `db.production.example.com` |
| `DB_PORT` | MySQL port | `3306` |
| `DB_USER` | MySQL user | `app_user` |
| `DB_PASSWORD` | Strong database password | `[REDACTED]` |
| `DB_NAME` | Database name | `daily_objects_db` |
| `JWT_SECRET` | 32+ character random secret | `[REDACTED_SECURE_KEY]` |
| `CLIENT_URL` | Production frontend domain | `https://dailyobjects.example.com` |
| `RAZORPAY_KEY_ID` | Production Razorpay key | `rzp_live_xxxxxxxx` (pending approval) |
| `RAZORPAY_KEY_SECRET`| Production Razorpay secret | `[REDACTED]` (pending approval) |

### Build & Run Commands
- **Install command:** `npm install --prefix backend`
- **Build / Seed command:** `npm run db:seed --prefix backend` (optional if already seeded)
- **Start command:** `npm start --prefix backend` (runs `node src/server.js`)

---

## 3. Frontend Deployment (React 19 / Vite)

Deployable to **Vercel**, **Netlify**, **Cloudflare Pages**, or **AWS S3 + CloudFront**.

### Environment Variables
| Variable | Description | Example Value |
| :--- | :--- | :--- |
| `VITE_API_URL` | Public URL of Backend API | `https://api.dailyobjects.example.com/api` |
| `VITE_RAZORPAY_KEY_ID` | Public Razorpay Key ID | `rzp_live_xxxxxxxx` (pending approval) |

### Build Settings
- **Root Directory:** `frontend`
- **Build Command:** `npm run build`
- **Output Directory:** `dist`

### SPA Routing Rule (Vercel / Netlify / NGINX)
Ensure all routes fallback to `index.html` for client-side routing.
For Netlify (`_redirects`):
```text
/*    /index.html   200
```
For Vercel (`vercel.json`):
```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
```

---

## 4. Default Seed Accounts

After running `database/seed.sql`:

* **Administrator:**
  * **Email:** `admin@dailyobjects.example`
  * **Password:** `Admin@123456`
  * **Portal Route:** `/admin/login`
* **Demo Customer:**
  * **Email:** `customer@dailyobjects.example`
  * **Password:** `Customer@123456`
  * **Portal Route:** `/login`

*Note: Immediately update passwords in production.*

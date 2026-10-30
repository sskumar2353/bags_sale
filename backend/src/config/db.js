import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

// Support both DATABASE_URL (Railway standard / cloud URI) and granular env vars
const dbConfig = process.env.DATABASE_URL
  ? {
      uri: process.env.DATABASE_URL,
      waitForConnections: true,
      connectionLimit: 10,
      decimalNumbers: true,
      ...(process.env.DB_SSL === 'true' ? { ssl: { rejectUnauthorized: false } } : {})
    }
  : {
      host: process.env.DB_HOST || process.env.MYSQLHOST || 'localhost',
      port: Number(process.env.DB_PORT || process.env.MYSQLPORT || 3306),
      user: process.env.DB_USER || process.env.MYSQLUSER || 'root',
      password: process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || '',
      database: process.env.DB_NAME || process.env.MYSQLDATABASE || 'daily_objects_db',
      waitForConnections: true,
      connectionLimit: 10,
      decimalNumbers: true,
      ...(process.env.DB_SSL === 'true' ? { ssl: { rejectUnauthorized: false } } : {})
    };

const pool = mysql.createPool(dbConfig);

export default pool;

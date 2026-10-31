import fs from 'node:fs';
import path from 'node:path';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

async function runSqlFile(connection, filePath) {
  const sql = fs.readFileSync(filePath, 'utf8');
  const statements = sql
    .replace(/--.*$/gm, '') // Remove comments
    .split(/;\s*[\r\n]+/)
    .map((s) => s.trim())
    .filter((s) => s.length > 0);

  for (const stmt of statements) {
    try {
      await connection.query(stmt);
    } catch (err) {
      if (err.code !== 'ER_DUP_ENTRY' && err.code !== 'ER_TABLE_EXISTS_ERROR') {
        console.warn(`[SQL Notice in ${path.basename(filePath)}]:`, err.message);
      }
    }
  }
}

export async function setupDatabase() {
  let connection;
  try {
    if (process.env.DATABASE_URL) {
      console.log('Connecting to cloud database via DATABASE_URL...');
      connection = await mysql.createConnection({
        uri: process.env.DATABASE_URL,
        multipleStatements: true,
        ...(process.env.DB_SSL === 'true' ? { ssl: { rejectUnauthorized: false } } : {})
      });
    } else {
      const host = process.env.DB_HOST || process.env.MYSQLHOST || 'localhost';
      const port = Number(process.env.DB_PORT || process.env.MYSQLPORT || 3306);
      const user = process.env.DB_USER || process.env.MYSQLUSER || 'root';
      const password = process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || '';
      const database = process.env.DB_NAME || process.env.MYSQLDATABASE || 'daily_objects_db';

      console.log(`Connecting to MySQL on ${host}:${port} as ${user}...`);
      connection = await mysql.createConnection({
        host,
        port,
        user,
        password,
        multipleStatements: true
      });
      await connection.query(
        `CREATE DATABASE IF NOT EXISTS \`${database}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
      );
      await connection.query(`USE \`${database}\`;`);
    }

    const schemaPath = fs.existsSync(path.resolve('database', 'schema.sql'))
      ? path.resolve('database', 'schema.sql')
      : path.resolve('..', 'database', 'schema.sql');
    const seedPath = fs.existsSync(path.resolve('database', 'seed.sql'))
      ? path.resolve('database', 'seed.sql')
      : path.resolve('..', 'database', 'seed.sql');

    if (fs.existsSync(schemaPath)) {
      console.log('Applying schema from schema.sql...');
      await runSqlFile(connection, schemaPath);
    }

    if (fs.existsSync(seedPath)) {
      console.log('Seeding products, variants, images, and admin from seed.sql...');
      await runSqlFile(connection, seedPath);
    }

    const bethanySeedPath = fs.existsSync(path.resolve('database', 'seed_bethany_catalog.sql'))
      ? path.resolve('database', 'seed_bethany_catalog.sql')
      : path.resolve('..', 'database', 'seed_bethany_catalog.sql');

    if (fs.existsSync(bethanySeedPath)) {
      console.log('Applying official Bethany Looms catalog from seed_bethany_catalog.sql...');
      await runSqlFile(connection, bethanySeedPath);
    }

    console.log('✓ Database setup and seeding complete.');
  } catch (err) {
    console.error('Database setup failed:', err.message);
  } finally {
    if (connection) await connection.end();
  }
}

if (process.argv[1]?.includes('setupDb.js')) {
  setupDatabase();
}

import fs from 'node:fs';
import path from 'node:path';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

async function runSqlFile(connection, filePath) {
  const sql = fs.readFileSync(filePath, 'utf8');
  // Split statements by semicolon that are followed by a newline or end of file
  const statements = sql
    .replace(/--.*$/gm, '') // Remove comments
    .split(/;\s*[\r\n]+/)
    .map((s) => s.trim())
    .filter((s) => s.length > 0);

  for (const stmt of statements) {
    try {
      await connection.query(stmt);
    } catch (err) {
      // Ignore "already exists" or duplicate entry warnings during setup
      if (err.code !== 'ER_DUP_ENTRY' && err.code !== 'ER_TABLE_EXISTS_ERROR') {
        console.warn(`[SQL Notice in ${path.basename(filePath)}]:`, err.message);
      }
    }
  }
}

export async function setupDatabase() {
  const host = process.env.DB_HOST || 'localhost';
  const port = Number(process.env.DB_PORT || 3306);
  const user = process.env.DB_USER || 'root';
  const password = process.env.DB_PASSWORD || '';
  const database = process.env.DB_NAME || 'daily_objects_db';

  console.log(`Connecting to MySQL on ${host}:${port} as ${user}...`);

  let connection;
  try {
    connection = await mysql.createConnection({ host, port, user, password, multipleStatements: true });
    await connection.query(`CREATE DATABASE IF NOT EXISTS \`${database}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`);
    await connection.query(`USE \`${database}\`;`);

    const schemaPath = path.resolve('database', 'schema.sql');
    const seedPath = path.resolve('database', 'seed.sql');

    if (fs.existsSync(schemaPath)) {
      console.log('Applying schema from schema.sql...');
      await runSqlFile(connection, schemaPath);
    }

    if (fs.existsSync(seedPath)) {
      console.log('Seeding products, variants, images, and admin from seed.sql...');
      await runSqlFile(connection, seedPath);
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

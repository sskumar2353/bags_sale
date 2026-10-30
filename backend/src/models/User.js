import pool from '../config/db.js';

export const User = {
  async findByEmail(email) {
    const [rows] = await pool.query(
      'SELECT id, first_name, last_name, email, phone, password_hash, role, is_active, created_at FROM users WHERE email = ?',
      [String(email).toLowerCase().trim()]
    );
    return rows[0] || null;
  },

  async findById(id) {
    const [rows] = await pool.query(
      'SELECT id, first_name, last_name, email, phone, role, is_active, created_at FROM users WHERE id = ?',
      [id]
    );
    return rows[0] || null;
  },

  async create({ firstName, lastName, email, phone, passwordHash, role = 'customer' }) {
    const [result] = await pool.query(
      'INSERT INTO users (first_name, last_name, email, phone, password_hash, role) VALUES (?, ?, ?, ?, ?, ?)',
      [firstName, lastName || null, email.toLowerCase().trim(), phone || null, passwordHash, role]
    );
    return result.insertId;
  },

  async setResetPasswordToken(email, token, expiresAt) {
    const [result] = await pool.query(
      'UPDATE users SET reset_password_token = ?, reset_password_expires = ? WHERE email = ? AND is_active = 1',
      [token, expiresAt, String(email).toLowerCase().trim()]
    );
    return result.affectedRows > 0;
  },

  async findByResetToken(token) {
    const [rows] = await pool.query(
      'SELECT id, first_name, last_name, email, reset_password_expires FROM users WHERE reset_password_token = ? AND reset_password_expires > NOW() AND is_active = 1',
      [token]
    );
    return rows[0] || null;
  },

  async resetPassword(id, passwordHash) {
    await pool.query(
      'UPDATE users SET password_hash = ?, reset_password_token = NULL, reset_password_expires = NULL WHERE id = ?',
      [passwordHash, id]
    );
  },

  async count() {
    const [rows] = await pool.query('SELECT COUNT(*) as total FROM users WHERE role = "customer"');
    return rows[0]?.total || 0;
  },

  async findAll() {
    const [rows] = await pool.query(
      'SELECT id, first_name, last_name, email, phone, role, is_active, created_at FROM users ORDER BY created_at DESC'
    );
    return rows;
  }
};

export default User;

import pool from '../config/db.js';

export const Address = {
  async findByUserId(userId) {
    const [rows] = await pool.query(
      'SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, created_at DESC',
      [userId]
    );
    return rows;
  },

  async findById(id, userId) {
    const [rows] = await pool.query(
      'SELECT * FROM addresses WHERE id = ? AND user_id = ?',
      [id, userId]
    );
    return rows[0] || null;
  },

  async create({
    userId,
    fullName,
    phone,
    addressLine1,
    addressLine2 = null,
    city,
    state,
    postalCode,
    country = 'India',
    addressType = 'home',
    isDefault = false
  }) {
    if (isDefault) {
      await pool.query('UPDATE addresses SET is_default = 0 WHERE user_id = ?', [userId]);
    }

    const [result] = await pool.query(
      `INSERT INTO addresses (user_id, full_name, phone, address_line1, address_line2, city, state, postal_code, country, address_type, is_default)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [userId, fullName, phone, addressLine1, addressLine2, city, state, postalCode, country, addressType, isDefault ? 1 : 0]
    );
    return result.insertId;
  },

  async delete(id, userId) {
    await pool.query('DELETE FROM addresses WHERE id = ? AND user_id = ?', [id, userId]);
  }
};

export default Address;

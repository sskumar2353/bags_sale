import pool from '../config/db.js';

export const Category = {
  async findAllActive() {
    const [rows] = await pool.query(
      `SELECT id, parent_id, name, slug, description, image_url, sort_order 
       FROM categories 
       WHERE is_active = 1 
       ORDER BY COALESCE(parent_id, id), parent_id IS NOT NULL, sort_order`
    );
    return rows;
  },

  async findBySlug(slug) {
    const [rows] = await pool.query(
      'SELECT id, parent_id, name, slug, description, image_url, sort_order FROM categories WHERE slug = ? AND is_active = 1',
      [slug]
    );
    return rows[0] || null;
  },

  async findById(id) {
    const [rows] = await pool.query(
      'SELECT id, parent_id, name, slug, description, image_url, sort_order FROM categories WHERE id = ?',
      [id]
    );
    return rows[0] || null;
  },

  async create({ parent_id = null, name, slug, description = null, image_url = null, sort_order = 0 }) {
    const [result] = await pool.query(
      'INSERT INTO categories (parent_id, name, slug, description, image_url, sort_order) VALUES (?, ?, ?, ?, ?, ?)',
      [parent_id || null, name, slug, description, image_url, sort_order]
    );
    return result.insertId;
  },

  async update(id, { name, slug, description, sort_order, is_active }) {
    await pool.query(
      'UPDATE categories SET name = ?, slug = ?, description = ?, sort_order = ?, is_active = ? WHERE id = ?',
      [name, slug, description, sort_order, is_active, id]
    );
  }
};

export default Category;

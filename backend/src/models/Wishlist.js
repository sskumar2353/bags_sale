import pool from '../config/db.js';

export const Wishlist = {
  async getOrCreateWishlist(userId) {
    const [existing] = await pool.query('SELECT id FROM wishlists WHERE user_id = ?', [userId]);
    if (existing.length > 0) return existing[0].id;

    const [result] = await pool.query('INSERT INTO wishlists (user_id) VALUES (?)', [userId]);
    return result.insertId;
  },

  async getItems(userId) {
    const wishlistId = await this.getOrCreateWishlist(userId);
    const [rows] = await pool.query(
      `SELECT 
        p.*,
        c.name AS category,
        c.slug AS category_slug,
        (SELECT image_url FROM product_images WHERE product_id = p.id ORDER BY is_primary DESC, sort_order ASC LIMIT 1) AS image
       FROM wishlist_items wi
       JOIN products p ON p.id = wi.product_id
       JOIN categories c ON c.id = p.category_id
       WHERE wi.wishlist_id = ? AND p.is_active = 1`,
      [wishlistId]
    );
    return rows;
  },

  async addItem(userId, productId) {
    const wishlistId = await this.getOrCreateWishlist(userId);
    await pool.query(
      'INSERT IGNORE INTO wishlist_items (wishlist_id, product_id) VALUES (?, ?)',
      [wishlistId, productId]
    );
  },

  async removeItem(userId, productId) {
    const wishlistId = await this.getOrCreateWishlist(userId);
    await pool.query(
      'DELETE FROM wishlist_items WHERE wishlist_id = ? AND product_id = ?',
      [wishlistId, productId]
    );
  }
};

export default Wishlist;

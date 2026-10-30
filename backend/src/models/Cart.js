import pool from '../config/db.js';

export const Cart = {
  async getOrCreateCart(userId, connection = pool) {
    const [existing] = await connection.query('SELECT id FROM carts WHERE user_id = ?', [userId]);
    if (existing.length > 0) return existing[0].id;

    const [result] = await connection.query('INSERT INTO carts (user_id) VALUES (?)', [userId]);
    return result.insertId;
  },

  async getItems(userId) {
    const cartId = await this.getOrCreateCart(userId);
    const [rows] = await pool.query(
      `SELECT 
        ci.id,
        ci.product_id,
        ci.variant_id,
        ci.quantity,
        p.name,
        p.slug,
        p.sku,
        p.stock_quantity AS product_stock,
        c.name AS category,
        COALESCE(v.price, p.price) AS price,
        p.mrp,
        COALESCE(v.image_url, (SELECT image_url FROM product_images WHERE product_id = p.id ORDER BY is_primary DESC, sort_order ASC LIMIT 1)) AS image,
        v.variant_name,
        COALESCE(v.stock_quantity, p.stock_quantity) AS stock_quantity
       FROM cart_items ci
       JOIN products p ON p.id = ci.product_id
       JOIN categories c ON c.id = p.category_id
       LEFT JOIN product_variants v ON v.id = ci.variant_id
       WHERE ci.cart_id = ? AND p.is_active = 1`,
      [cartId]
    );
    return rows;
  },

  async addItem(userId, { productId, variantId = null, quantity = 1 }) {
    const cartId = await this.getOrCreateCart(userId);
    const [existing] = await pool.query(
      'SELECT id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ? AND (variant_id = ? OR (variant_id IS NULL AND ? IS NULL))',
      [cartId, productId, variantId, variantId]
    );

    if (existing.length > 0) {
      const newQty = existing[0].quantity + quantity;
      await pool.query('UPDATE cart_items SET quantity = ? WHERE id = ?', [newQty, existing[0].id]);
      return existing[0].id;
    }

    const [result] = await pool.query(
      'INSERT INTO cart_items (cart_id, product_id, variant_id, quantity) VALUES (?, ?, ?, ?)',
      [cartId, productId, variantId, quantity]
    );
    return result.insertId;
  },

  async updateItemQuantity(userId, itemId, quantity) {
    const cartId = await this.getOrCreateCart(userId);
    if (quantity <= 0) {
      await pool.query('DELETE FROM cart_items WHERE id = ? AND cart_id = ?', [itemId, cartId]);
    } else {
      await pool.query('UPDATE cart_items SET quantity = ? WHERE id = ? AND cart_id = ?', [quantity, itemId, cartId]);
    }
  },

  async removeItem(userId, itemId) {
    const cartId = await this.getOrCreateCart(userId);
    await pool.query('DELETE FROM cart_items WHERE id = ? AND cart_id = ?', [itemId, cartId]);
  },

  async clearCart(userId, connection = pool) {
    const cartId = await this.getOrCreateCart(userId, connection);
    await connection.query('DELETE FROM cart_items WHERE cart_id = ?', [cartId]);
  }
};

export default Cart;

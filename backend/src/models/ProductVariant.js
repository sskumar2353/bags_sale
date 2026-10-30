import pool from '../config/db.js';

export const ProductVariant = {
  async findByProductId(productId, connection = pool) {
    const [rows] = await connection.query(
      'SELECT * FROM product_variants WHERE product_id = ? AND is_active = 1',
      [productId]
    );
    return rows;
  },

  async findById(id, connection = pool) {
    const [rows] = await connection.query(
      'SELECT * FROM product_variants WHERE id = ? AND is_active = 1',
      [id]
    );
    return rows[0] || null;
  },

  async create({ productId, variantName, colorName, colorCode, size, sku, price, stockQuantity, imageUrl }) {
    const [result] = await pool.query(
      `INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [productId, variantName, colorName, colorCode, size, sku, price, stockQuantity, imageUrl]
    );
    return result.insertId;
  }
};

export default ProductVariant;

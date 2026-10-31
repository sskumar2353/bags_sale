import pool from '../config/db.js';

export const Product = {
  async findAll({ category, search, featured, newest, inStock, sort } = {}) {
    const where = ['p.is_active = 1'];
    const args = [];

    if (category) {
      if (category === 'tech') {
        where.push('(c.slug IN ("tech", "pouches") OR c.name IN ("Tech", "Pouches"))');
      } else if (category === 'work-essentials') {
        where.push('(c.slug IN ("work-essentials", "messenger-laptop-bags", "backpacks") OR c.name IN ("Work Essentials", "Messenger / Laptop Bags", "Backpacks"))');
      } else if (category === 'gifting') {
        where.push('(c.slug IN ("gifting", "bag-accessories", "wallets") OR c.name IN ("Gifting", "Bag Accessories", "Wallets"))');
      } else {
        where.push('(c.slug = ? OR c.name = ?)');
        args.push(category, category);
      }
    }

    if (search) {
      where.push('(p.name LIKE ? OR p.description LIKE ? OR p.sku LIKE ? OR c.name LIKE ?)');
      const term = `%${search}%`;
      args.push(term, term, term, term);
    }

    if (featured === 'true' || featured === true) {
      where.push('p.is_featured = 1');
    }

    if (newest === 'true' || newest === true) {
      where.push('p.is_new_arrival = 1');
    }

    if (inStock === 'true' || inStock === true) {
      where.push('p.stock_quantity > 0');
    }

    let orderBy = 'p.created_at DESC';
    if (sort === 'price_asc') {
      orderBy = 'p.price ASC';
    } else if (sort === 'price_desc') {
      orderBy = 'p.price DESC';
    } else if (sort === 'newest') {
      orderBy = 'p.id DESC';
    }

    const query = `
      SELECT 
        p.*,
        c.name AS category,
        c.slug AS category_slug,
        (
          SELECT image_url 
          FROM product_images 
          WHERE product_id = p.id 
          ORDER BY is_primary DESC, sort_order ASC 
          LIMIT 1
        ) AS image,
        (
          SELECT image_url 
          FROM product_images 
          WHERE product_id = p.id 
          ORDER BY is_primary DESC, sort_order ASC 
          LIMIT 1
        ) AS primary_image,
        (
          SELECT image_url 
          FROM product_images 
          WHERE product_id = p.id 
          ORDER BY is_primary DESC, sort_order ASC 
          LIMIT 1
        ) AS image_url,
        (
          SELECT image_url 
          FROM product_images 
          WHERE product_id = p.id AND is_primary = 0
          ORDER BY sort_order ASC 
          LIMIT 1
        ) AS alt_image,
        (
          SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
              'id', v.id,
              'variant_name', v.variant_name,
              'color_name', v.color_name,
              'color_code', v.color_code,
              'size', v.size,
              'price', v.price,
              'stock_quantity', v.stock_quantity,
              'image_url', v.image_url
            )
          )
          FROM product_variants v 
          WHERE v.product_id = p.id AND v.is_active = 1
        ) AS variants
      FROM products p
      JOIN categories c ON c.id = p.category_id
      WHERE ${where.join(' AND ')}
      ORDER BY ${orderBy}
    `;

    const [rows] = await pool.query(query, args);

    // Normalize JSON variants if parsed as string or null
    return rows.map((row) => ({
      ...row,
      variants: Array.isArray(row.variants) ? row.variants : []
    }));
  },

  async findBySlug(slug) {
    const [rows] = await pool.query(
      `SELECT p.*, c.name AS category, c.slug AS category_slug
       FROM products p
       JOIN categories c ON c.id = p.category_id
       WHERE p.slug = ? AND p.is_active = 1`,
      [slug]
    );

    const product = rows[0] || null;
    if (!product) return null;

    const [[images], [variants]] = await Promise.all([
      pool.query(
        'SELECT id, image_url, alt_text, is_primary FROM product_images WHERE product_id = ? ORDER BY is_primary DESC, sort_order ASC',
        [product.id]
      ),
      pool.query(
        'SELECT id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url FROM product_variants WHERE product_id = ? AND is_active = 1',
        [product.id]
      )
    ]);

    return {
      ...product,
      image: images[0]?.image_url || null,
      primary_image: images[0]?.image_url || null,
      image_url: images[0]?.image_url || null,
      images,
      variants
    };
  },

  async findById(id, connection = pool) {
    const [rows] = await connection.query(
      `SELECT p.*, c.name AS category, c.slug AS category_slug
       FROM products p
       JOIN categories c ON c.id = p.category_id
       WHERE p.id = ?`,
      [id]
    );
    return rows[0] || null;
  },

  async create({
    category_id,
    name,
    slug,
    description,
    short_description,
    sku,
    price,
    mrp,
    stock_quantity,
    badge,
    image_url,
    is_featured = false,
    is_new_arrival = false
  }) {
    const discount = mrp > price ? ((mrp - price) / mrp) * 100 : 0;
    const [result] = await pool.query(
      `INSERT INTO products (
        category_id, name, slug, description, short_description, sku,
        price, mrp, discount_percentage, stock_quantity, badge,
        is_featured, is_new_arrival
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        category_id,
        name,
        slug,
        description,
        short_description,
        sku,
        price,
        mrp,
        discount,
        stock_quantity,
        badge || null,
        is_featured ? 1 : 0,
        is_new_arrival ? 1 : 0
      ]
    );

    const productId = result.insertId;

    if (image_url) {
      await pool.query(
        'INSERT INTO product_images (product_id, image_url, is_primary) VALUES (?, ?, 1)',
        [productId, image_url]
      );
    }

    return productId;
  },

  async update(id, data) {
    const {
      category_id,
      name,
      slug,
      description,
      short_description,
      sku,
      price,
      mrp,
      stock_quantity,
      badge,
      image_url,
      is_featured,
      is_new_arrival,
      is_active = 1
    } = data;

    const discount = mrp > price ? ((mrp - price) / mrp) * 100 : 0;

    await pool.query(
      `UPDATE products SET
        category_id = ?, name = ?, slug = ?, description = ?, short_description = ?,
        sku = ?, price = ?, mrp = ?, discount_percentage = ?, stock_quantity = ?,
        badge = ?, is_featured = ?, is_new_arrival = ?, is_active = ?
       WHERE id = ?`,
      [
        category_id,
        name,
        slug,
        description,
        short_description,
        sku,
        price,
        mrp,
        discount,
        stock_quantity,
        badge || null,
        is_featured ? 1 : 0,
        is_new_arrival ? 1 : 0,
        is_active ? 1 : 0,
        id
      ]
    );

    if (image_url) {
      await pool.query(
        `INSERT INTO product_images (product_id, image_url, is_primary)
         VALUES (?, ?, 1)
         ON DUPLICATE KEY UPDATE image_url = ?`,
        [id, image_url, image_url]
      );
    }
  },

  async delete(id) {
    // Soft delete
    await pool.query('UPDATE products SET is_active = 0 WHERE id = ?', [id]);
  },

  async count() {
    const [rows] = await pool.query('SELECT COUNT(*) AS total FROM products WHERE is_active = 1');
    return rows[0]?.total || 0;
  },

  async countLowStock(threshold = 5) {
    const [rows] = await pool.query(
      'SELECT COUNT(*) AS total FROM products WHERE is_active = 1 AND stock_quantity <= ?',
      [threshold]
    );
    return rows[0]?.total || 0;
  }
};

export default Product;

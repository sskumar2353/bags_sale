-- =========================================================
-- USERS
-- =========================================================

CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    reset_password_token VARCHAR(255) NULL,
    reset_password_expires TIMESTAMP NULL,
    role ENUM('customer', 'admin') NOT NULL DEFAULT 'customer',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- =========================================================
-- CATEGORIES
-- Supports main categories + subcategories
-- Example:
-- Bags & Wallets
--   └── Tote Bags
--       └── Pivot
-- =========================================================

CREATE TABLE IF NOT EXISTS categories (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_id INT UNSIGNED NULL,
    name VARCHAR(150) NOT NULL,
    slug VARCHAR(180) NOT NULL UNIQUE,
    description TEXT,
    image_url VARCHAR(500),
    sort_order INT NOT NULL DEFAULT 0,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_categories_parent
        FOREIGN KEY (parent_id)
        REFERENCES categories(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- =========================================================
-- PRODUCTS
-- =========================================================

CREATE TABLE IF NOT EXISTS products (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id INT UNSIGNED NOT NULL,

    name VARCHAR(255) NOT NULL,
    slug VARCHAR(280) NOT NULL UNIQUE,

    description TEXT,
    short_description VARCHAR(500),

    sku VARCHAR(100) UNIQUE,

    price DECIMAL(10,2) NOT NULL,
    mrp DECIMAL(10,2) NOT NULL,

    discount_percentage DECIMAL(5,2) DEFAULT 0.00,

    stock_quantity INT UNSIGNED NOT NULL DEFAULT 0,

    badge VARCHAR(50),
    offer_text VARCHAR(255),

    is_featured BOOLEAN NOT NULL DEFAULT FALSE,
    is_new_arrival BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    rating DECIMAL(3,2) DEFAULT 0.00,
    review_count INT UNSIGNED NOT NULL DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_product_price
        CHECK (price >= 0),

    CONSTRAINT chk_product_mrp
        CHECK (mrp >= 0),

    CONSTRAINT chk_product_discount
        CHECK (discount_percentage >= 0 AND discount_percentage <= 100)
);


-- =========================================================
-- PRODUCT IMAGES
-- =========================================================

CREATE TABLE IF NOT EXISTS product_images (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,

    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),

    sort_order INT NOT NULL DEFAULT 0,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_images_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- PRODUCT VARIANTS
-- Colors / sizes / SKU / individual stock
-- =========================================================

CREATE TABLE IF NOT EXISTS product_variants (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,

    variant_name VARCHAR(150),
    color_name VARCHAR(100),
    color_code VARCHAR(20),
    size VARCHAR(50),

    sku VARCHAR(100) UNIQUE,

    price DECIMAL(10,2),
    stock_quantity INT UNSIGNED NOT NULL DEFAULT 0,

    image_url VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_variants_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_variant_price
        CHECK (price IS NULL OR price >= 0)
);


-- =========================================================
-- ADDRESSES
-- =========================================================

CREATE TABLE IF NOT EXISTS addresses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,

    full_name VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,

    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),

    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'India',

    address_type ENUM('home', 'work', 'other') DEFAULT 'home',
    is_default BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_addresses_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- CARTS
-- =========================================================

CREATE TABLE IF NOT EXISTS carts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_carts_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- CART ITEMS
-- =========================================================

CREATE TABLE IF NOT EXISTS cart_items (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cart_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    variant_id INT UNSIGNED NULL,

    quantity INT UNSIGNED NOT NULL DEFAULT 1,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_cart_items_cart
        FOREIGN KEY (cart_id)
        REFERENCES carts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_cart_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_cart_items_variant
        FOREIGN KEY (variant_id)
        REFERENCES product_variants(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_cart_quantity
        CHECK (quantity > 0),

    UNIQUE KEY unique_cart_product_variant (cart_id, product_id, variant_id)
);


-- =========================================================
-- WISHLISTS
-- =========================================================

CREATE TABLE IF NOT EXISTS wishlists (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_wishlists_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- WISHLIST ITEMS
-- =========================================================

CREATE TABLE IF NOT EXISTS wishlist_items (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    wishlist_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_wishlist_items_wishlist
        FOREIGN KEY (wishlist_id)
        REFERENCES wishlists(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_wishlist_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE KEY unique_wishlist_product (wishlist_id, product_id)
);


-- =========================================================
-- ORDERS
-- =========================================================

CREATE TABLE IF NOT EXISTS orders (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NOT NULL,

    order_number VARCHAR(50) NOT NULL UNIQUE,

    status ENUM(
        'pending',
        'confirmed',
        'processing',
        'shipped',
        'delivered',
        'cancelled',
        'returned'
    ) NOT NULL DEFAULT 'pending',

    payment_status ENUM(
        'pending',
        'paid',
        'failed',
        'refunded'
    ) NOT NULL DEFAULT 'pending',

    payment_method ENUM(
        'razorpay',
        'cod'
    ) NOT NULL DEFAULT 'razorpay',

    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    shipping_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    tax_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    -- Shipping address snapshot
    shipping_name VARCHAR(200) NOT NULL,
    shipping_phone VARCHAR(20) NOT NULL,
    shipping_address_line1 VARCHAR(255) NOT NULL,
    shipping_address_line2 VARCHAR(255),
    shipping_city VARCHAR(100) NOT NULL,
    shipping_state VARCHAR(100) NOT NULL,
    shipping_postal_code VARCHAR(20) NOT NULL,
    shipping_country VARCHAR(100) NOT NULL DEFAULT 'India',

    notes TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_order_subtotal
        CHECK (subtotal >= 0),

    CONSTRAINT chk_order_total
        CHECK (total_amount >= 0)
);


-- =========================================================
-- ORDER ITEMS
-- Product information is stored as a snapshot
-- so old orders remain correct even if products change.
-- =========================================================

CREATE TABLE IF NOT EXISTS order_items (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NULL,
    variant_id INT UNSIGNED NULL,

    product_name VARCHAR(255) NOT NULL,
    variant_name VARCHAR(150),

    sku VARCHAR(100),

    quantity INT UNSIGNED NOT NULL DEFAULT 1,

    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_items_variant
        FOREIGN KEY (variant_id)
        REFERENCES product_variants(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_item_price
        CHECK (unit_price >= 0 AND total_price >= 0)
);


-- =========================================================
-- PAYMENTS
-- Razorpay information
-- =========================================================

CREATE TABLE IF NOT EXISTS payments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    order_id INT UNSIGNED NOT NULL UNIQUE,

    provider VARCHAR(50) NOT NULL DEFAULT 'razorpay',

    razorpay_order_id VARCHAR(255) UNIQUE,
    razorpay_payment_id VARCHAR(255) UNIQUE,
    razorpay_signature VARCHAR(500),

    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'INR',

    status ENUM(
        'created',
        'authorized',
        'captured',
        'failed',
        'refunded'
    ) NOT NULL DEFAULT 'created',

    payment_method VARCHAR(100),

    error_code VARCHAR(100),
    error_description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0)
);


-- =========================================================
-- INDEXES
-- =========================================================

CREATE INDEX idx_products_category
ON products(category_id);

CREATE INDEX idx_products_active
ON products(is_active);

CREATE INDEX idx_products_featured
ON products(is_featured);

CREATE INDEX idx_products_new_arrival
ON products(is_new_arrival);

CREATE INDEX idx_products_price
ON products(price);

CREATE INDEX idx_product_images_product
ON product_images(product_id);

CREATE INDEX idx_product_variants_product
ON product_variants(product_id);

CREATE INDEX idx_addresses_user
ON addresses(user_id);

CREATE INDEX idx_cart_items_cart
ON cart_items(cart_id);

CREATE INDEX idx_wishlist_items_wishlist
ON wishlist_items(wishlist_id);

CREATE INDEX idx_orders_user
ON orders(user_id);

CREATE INDEX idx_orders_status
ON orders(status);

CREATE INDEX idx_orders_created_at
ON orders(created_at);

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_payments_status
ON payments(status);

CREATE INDEX idx_payments_razorpay_order
ON payments(razorpay_order_id);


-- =========================================================
-- MAIN CATEGORY SEED DATA
-- =========================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
VALUES
    (NULL, 'Tote Bags', 'tote-bags', 'Everyday and work-ready tote bags.', 1),
    (NULL, 'Crossbody Bags', 'crossbody-bags', 'Compact crossbody bags for everyday carry.', 2),
    (NULL, 'Backpacks', 'backpacks', 'Backpacks for work, travel and everyday use.', 3),
    (NULL, 'Messenger / Laptop Bags', 'messenger-laptop-bags', 'Messenger and laptop bags for work and travel.', 4),
    (NULL, 'Phone Bags', 'phone-bags', 'Compact bags designed for carrying phones and essentials.', 5),
    (NULL, 'Wallets', 'wallets', 'Wallets and compact everyday organizers.', 6),
    (NULL, 'Duffle Bags', 'duffle-bags', 'Duffle bags for travel, gym and weekends.', 7),
    (NULL, 'Pouches', 'pouches', 'Compact pouches and cases for organizing essentials.', 8),
    (NULL, 'Bag Accessories', 'bag-accessories', 'Accessories and charms for bags.', 9);


-- =========================================================
-- WALLET SUBCATEGORIES
-- =========================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Phone Wallets', 'phone-wallets', 'Wallets designed to carry phones and cards.', 1
FROM categories
WHERE slug = 'wallets';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Zip Wallets', 'zip-wallets', 'Compact zip-around wallets.', 2
FROM categories
WHERE slug = 'wallets';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Card Wallets', 'card-wallets', 'Slim wallets designed for cards.', 3
FROM categories
WHERE slug = 'wallets';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Passport Wallets', 'passport-wallets', 'Travel wallets for passports and documents.', 4
FROM categories
WHERE slug = 'wallets';


-- =========================================================
-- POUCH SUBCATEGORIES
-- =========================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Taxi', 'taxi-pouches', 'Compact everyday pouches.', 1
FROM categories
WHERE slug = 'pouches';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Easy', 'easy-pouches', 'Simple utility pouches.', 2
FROM categories
WHERE slug = 'pouches';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Eyewear Cases', 'eyewear-cases', 'Protective cases for eyewear.', 3
FROM categories
WHERE slug = 'pouches';


-- =========================================================
-- BAG ACCESSORY SUBCATEGORIES
-- =========================================================

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Mini Bag Charm', 'mini-bag-charm', 'Small decorative bag charms.', 1
FROM categories
WHERE slug = 'bag-accessories';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Bloom Charm', 'bloom-charm', 'Decorative bloom-style charms.', 2
FROM categories
WHERE slug = 'bag-accessories';

INSERT INTO categories
    (parent_id, name, slug, description, sort_order)
SELECT id, 'Bow Charm', 'bow-charm', 'Decorative bow-style charms.', 3
FROM categories
WHERE slug = 'bag-accessories';


-- =========================================================
-- VERIFY
-- =========================================================

SELECT
    c.id,
    c.parent_id,
    c.name,
    c.slug
FROM categories c
ORDER BY
    COALESCE(c.parent_id, c.id),
    c.parent_id IS NOT NULL,
    c.sort_order;
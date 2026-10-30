USE daily_objects_db;

-- =========================================================
-- SEED CATEGORIES (Idempotent Top-Level & Subcategories)
-- =========================================================

INSERT INTO categories (parent_id, name, slug, description, image_url, sort_order)
VALUES
    (NULL, 'Tote Bags', 'tote-bags', 'Everyday and work-ready tote bags.', 'https://images.dailyobjects.com/marche/assets/images/other-2/CP-desktop.jpg?tr=cm-pad_crop,v-3', 1),
    (NULL, 'Crossbody Bags', 'crossbody-bags', 'Compact crossbody bags for everyday carry.', 'https://images.dailyobjects.com/marche/assets/images/other/new-crossbody-bags.jpg?tr=cm-pad_crop,v-3', 2),
    (NULL, 'Backpacks', 'backpacks', 'Backpacks for work, travel and everyday use.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3', 3),
    (NULL, 'Messenger / Laptop Bags', 'messenger-laptop-bags', 'Messenger and laptop bags for work and travel.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3', 4),
    (NULL, 'Phone Bags', 'phone-bags', 'Compact bags designed for carrying phones and essentials.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 5),
    (NULL, 'Wallets', 'wallets', 'Wallets and compact everyday organizers.', 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 6),
    (NULL, 'Duffle Bags', 'duffle-bags', 'Duffle bags for travel, gym and weekends.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3', 7),
    (NULL, 'Pouches', 'pouches', 'Compact pouches and cases for organizing essentials.', 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 8),
    (NULL, 'Bag Accessories', 'bag-accessories', 'Accessories and charms for bags.', 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3', 9),
    (NULL, 'Tech', 'tech', 'Tech accessories, organizers, and sleeves.', 'https://images.dailyobjects.com/marche/icons/category/charging-solutions-nesw-arrival-icon-desktop.jpg?tr=cm-pad_crop,v-3', 10),
    (NULL, 'Work Essentials', 'work-essentials', 'Curated bags, folios and organizers for work.', 'https://images.dailyobjects.com/marche/assets/images/other/category-desktop-work-essentials-icons.png?tr=cm-pad_resize,v-3', 11),
    (NULL, 'Gifting', 'gifting', 'Curated gifts and luxury accessories.', 'https://images.dailyobjects.com/marche/corporate-page/gifting-update.png?tr=cm-pad_resize,v-3', 12)
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), image_url = VALUES(image_url), sort_order = VALUES(sort_order);

-- =========================================================
-- SEED USERS (Admin & Demo Customer)
-- Admin Password: Admin@123456
-- Customer Password: Customer@123456
-- =========================================================

INSERT INTO users (first_name, last_name, email, phone, password_hash, role, is_active)
VALUES
    ('Store', 'Administrator', 'admin@dailyobjects.example', '9876543210', '$2b$12$U6EMCBc3ZAlV45/ipRViM.Priwd89.xvz0RW8IGolZ2RD3SUoMzsi', 'admin', 1),
    ('Priya', 'Sharma', 'customer@dailyobjects.example', '9876543211', '$2b$12$TgejtsxNhg813.UbWywYNON9IogvDtdX3ct.Ee8JuBZi9p3w8qod.', 'customer', 1)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- Demo Customer Address
INSERT INTO addresses (user_id, full_name, phone, address_line1, address_line2, city, state, postal_code, country, address_type, is_default)
SELECT id, 'Priya Sharma', '9876543211', 'Flat 402, Green Glen Heights', 'Outer Ring Road, Bellandur', 'Bengaluru', 'Karnataka', '560103', 'India', 'home', 1
FROM users
WHERE email = 'customer@dailyobjects.example'
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- =========================================================
-- SEED REAL DAILY OBJECTS PRODUCTS (30 Products per Category = 270 Total)
-- With exact Daily Objects CDN image URLs stored directly in the database
-- =========================================================

-- ---------------------------------------------------------
-- Category: Tote Bags (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Scarlet Wing City Tote', 'scarlet-wing-city-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-001', 2299.00, 2999.00, 23.34, 18, 'PRICE DROP', 1, 0, 4.40, 25
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Lagoon-Basalt Pivot Key Tote', 'lagoon-basalt-pivot-key-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-002', 3999.00, 4999.00, 20.00, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Sand-Basalt Pivot Key Tote', 'sand-basalt-pivot-key-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-003', 3999.00, 4999.00, 20.00, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Coral-Basalt Pivot Key Tote', 'coral-basalt-pivot-key-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-004', 3999.00, 4999.00, 20.00, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Black Wing Tote', 'black-wing-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-005', 1999.00, 2999.00, 33.34, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Classic Tote - Coral', 'pivot-classic-tote-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-006', 3999.00, 4999.00, 20.00, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Classic Tote - Basalt', 'pivot-classic-tote-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-007', 3999.00, 4999.00, 20.00, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Cardinal Love Idyll Tote Bag', 'cardinal-love-idyll-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-008', 3299.00, 4699.00, 29.79, 32, 'PRICE DROP', 0, 0, 4.49, 116
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Space Blue Idyll Tote', 'space-blue-idyll-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-009', 3299.00, 4499.00, 26.67, 39, 'PRICE DROP', 0, 0, 4.66, 129
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Idyll Tote', 'carbon-black-idyll-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-010', 3299.00, 4499.00, 26.67, 46, 'PRICE DROP', 0, 1, 4.83, 142
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green-Clove Field Tote Bag', 'olive-green-clove-field-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-011', 1999.00, 2343.00, 14.68, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Ivory-Crimson Red Field Tote Bag', 'ivory-crimson-red-field-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-012', 1999.00, 2343.00, 14.68, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green-Navy Field Tote Bag', 'forest-green-navy-field-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-013', 1999.00, 2343.00, 14.68, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Slate Gray Idyll Tote', 'slate-gray-idyll-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-014', 3499.00, 4499.00, 22.23, 39, '', 0, 1, 4.41, 194
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Field Tote Bag', 'crimson-red-field-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-015', 1799.00, 2343.00, 23.22, 46, 'PRICE DROP', 0, 0, 4.58, 27
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Ivory-Green Vessel Leather Pocket Tote', 'ivory-green-vessel-leather-pocket-tote', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-016', 1899.00, 2343.00, 18.95, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Midnight Blue Buoy Tote Bag', 'midnight-blue-buoy-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-017', 2499.00, 4687.00, 46.68, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Buoy Tote Bag', 'khaki-beige-buoy-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-018', 2499.00, 4687.00, 46.68, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Green Buoy Tote Bag', 'mint-green-buoy-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-019', 2499.00, 4687.00, 46.68, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Buoy Tote Bag', 'mustard-buoy-tote-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-020', 2499.00, 4687.00, 46.68, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Scarlet Wing City Tote Edition 2', 'scarlet-wing-city-tote-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-021', 2299.00, 2999.00, 23.34, 18, 'PRICE DROP', 0, 0, 4.50, 105
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Lagoon-Basalt Pivot Key Tote Edition 2', 'lagoon-basalt-pivot-key-tote-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-022', 3999.00, 4999.00, 20.00, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Sand-Basalt Pivot Key Tote Edition 2', 'sand-basalt-pivot-key-tote-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-023', 3999.00, 4999.00, 20.00, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Coral-Basalt Pivot Key Tote Edition 2', 'coral-basalt-pivot-key-tote-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-024', 3999.00, 4999.00, 20.00, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Black Wing Tote Edition 2', 'black-wing-tote-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-025', 1999.00, 2999.00, 33.34, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Classic Tote - Coral Edition 2', 'pivot-classic-tote-coral-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-026', 3999.00, 4999.00, 20.00, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Classic Tote - Basalt Edition 2', 'pivot-classic-tote-basalt-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-027', 3999.00, 4999.00, 20.00, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Cardinal Love Idyll Tote Bag Edition 2', 'cardinal-love-idyll-tote-bag-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-028', 3299.00, 4699.00, 29.79, 32, 'PRICE DROP', 0, 0, 4.59, 196
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Space Blue Idyll Tote Edition 2', 'space-blue-idyll-tote-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-029', 3299.00, 4499.00, 26.67, 39, 'PRICE DROP', 0, 0, 4.76, 29
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Idyll Tote Edition 2', 'carbon-black-idyll-tote-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium tote bag with durable construction and smart quick-access storage.', 'DO-TOT-030', 3299.00, 4499.00, 26.67, 46, 'PRICE DROP', 0, 1, 4.93, 42
FROM categories WHERE slug = 'tote-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Crossbody Bags (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Sand', 'pivot-crossbody-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-001', 2199.00, 2499.00, 12.00, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Basalt', 'pivot-crossbody-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-002', 2199.00, 2499.00, 12.00, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Seagrass', 'pivot-crossbody-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-003', 2199.00, 2499.00, 12.00, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Coral', 'pivot-crossbody-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-004', 2199.00, 2499.00, 12.00, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Lagoon', 'pivot-crossbody-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-005', 2199.00, 2499.00, 12.00, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Scarlet Wing Crossbody', 'scarlet-wing-crossbody', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-006', 1799.00, 2799.00, 35.73, 18, 'PRICE DROP', 0, 1, 4.70, 90
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Retreat Crossbody Bag', 'carbon-black-retreat-crossbody-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-007', 1099.00, 2499.00, 56.02, 25, 'PRICE DROP', 1, 0, 4.87, 103
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige March Crossbody Bag Large', 'khaki-beige-march-crossbody-bag-large', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-008', 1799.00, 2155.00, 16.52, 32, 'PRICE DROP', 0, 0, 4.49, 116
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Black Wing Crossbody', 'black-wing-crossbody', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-009', 1799.00, 2799.00, 35.73, 39, 'PRICE DROP', 0, 0, 4.66, 129
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Basalt Pivot Orbit Fanny', 'basalt-pivot-orbit-fanny', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-010', 1999.00, 2599.00, 23.09, 46, '', 0, 1, 4.83, 142
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Coral Pivot Orbit Fanny', 'coral-pivot-orbit-fanny', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-011', 1999.00, 2599.00, 23.09, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Seagrass Pivot Orbit Fanny', 'seagrass-pivot-orbit-fanny', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-012', 1999.00, 2599.00, 23.09, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Sand Pivot Orbit Fanny', 'sand-pivot-orbit-fanny', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-013', 1999.00, 2599.00, 23.09, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Lagoon Pivot Orbit Fanny', 'lagoon-pivot-orbit-fanny', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-014', 1999.00, 2599.00, 23.09, 39, '', 0, 1, 4.41, 194
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Lagoon', 'pivot-travel-sling-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-015', 1999.00, 2999.00, 33.34, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Coral', 'pivot-travel-sling-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-016', 1999.00, 2999.00, 33.34, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Sand', 'pivot-travel-sling-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-017', 1799.00, 2999.00, 40.01, 25, 'PRICE DROP', 0, 0, 4.92, 53
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Seagrass', 'pivot-travel-sling-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-018', 1799.00, 2999.00, 40.01, 32, 'PRICE DROP', 0, 1, 4.54, 66
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Basalt', 'pivot-travel-sling-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-019', 1799.00, 2999.00, 40.01, 39, 'PRICE DROP', 1, 0, 4.71, 79
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Cardinal Love March Crossbody Bag Regular', 'cardinal-love-march-crossbody-bag-regular', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-020', 1299.00, 1968.00, 33.99, 46, 'PRICE DROP', 0, 0, 4.88, 92
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Sand Edition 2', 'pivot-crossbody-sand-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-021', 2199.00, 2499.00, 12.00, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Basalt Edition 2', 'pivot-crossbody-basalt-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-022', 2199.00, 2499.00, 12.00, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Seagrass Edition 2', 'pivot-crossbody-seagrass-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-023', 2199.00, 2499.00, 12.00, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Coral Edition 2', 'pivot-crossbody-coral-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-024', 2199.00, 2499.00, 12.00, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Lagoon Edition 2', 'pivot-crossbody-lagoon-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-025', 2199.00, 2499.00, 12.00, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Scarlet Wing Crossbody Edition 2', 'scarlet-wing-crossbody-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-026', 1799.00, 2799.00, 35.73, 18, 'PRICE DROP', 0, 1, 4.80, 170
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Retreat Crossbody Bag Edition 2', 'carbon-black-retreat-crossbody-bag-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-027', 1099.00, 2499.00, 56.02, 25, 'PRICE DROP', 0, 0, 4.42, 183
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige March Crossbody Bag Large Edition 2', 'khaki-beige-march-crossbody-bag-large-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-028', 1799.00, 2155.00, 16.52, 32, 'PRICE DROP', 0, 0, 4.59, 196
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Black Wing Crossbody Edition 2', 'black-wing-crossbody-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-029', 1799.00, 2799.00, 35.73, 39, 'PRICE DROP', 0, 0, 4.76, 29
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Basalt Pivot Orbit Fanny Edition 2', 'basalt-pivot-orbit-fanny-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium crossbody bag with durable construction and smart quick-access storage.', 'DO-CRS-030', 1999.00, 2599.00, 23.09, 46, '', 0, 1, 4.93, 42
FROM categories WHERE slug = 'crossbody-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Backpacks (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Sand', 'pivot-taiga-backpack-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-001', 4499.00, 5499.00, 18.19, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Seagrass', 'pivot-taiga-backpack-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-002', 4499.00, 5499.00, 18.19, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Coral', 'pivot-taiga-backpack-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-003', 4499.00, 5499.00, 18.19, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Basalt', 'pivot-taiga-backpack-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-004', 4499.00, 5499.00, 18.19, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Lagoon', 'pivot-taiga-backpack-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-005', 4499.00, 5499.00, 18.19, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Beige Pedal Daypack', 'beige-pedal-daypack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-006', 1799.00, 2343.00, 23.22, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Backpack', 'navy-field-backpack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-007', 3499.00, 3749.00, 6.67, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Clove Field Backpack', 'clove-field-backpack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-008', 3499.00, 3749.00, 6.67, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Field Backpack', 'khaki-beige-field-backpack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-009', 3499.00, 3749.00, 6.67, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Field Backpack', 'crimson-red-field-backpack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-010', 3499.00, 3749.00, 6.67, 46, '', 0, 1, 4.83, 142
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Black Wing Backpack', 'black-wing-backpack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-011', 3499.00, 4499.00, 22.23, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Lunar Daypack - Basalt', 'pivot-lunar-daypack-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-012', 3999.00, 4999.00, 20.00, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Sand', 'pivot-meridian-convertible-briefpack-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-013', 6999.00, 7999.00, 12.50, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Basalt', 'pivot-meridian-convertible-briefpack-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-014', 6999.00, 7999.00, 12.50, 39, '', 0, 1, 4.41, 194
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Coral', 'pivot-meridian-convertible-briefpack-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-015', 6999.00, 7999.00, 12.50, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Seagrass', 'pivot-meridian-convertible-briefpack-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-016', 6999.00, 7999.00, 12.50, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Lagoon', 'pivot-meridian-convertible-briefpack-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-017', 6999.00, 7999.00, 12.50, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green Pedal Daypack', 'forest-green-pedal-daypack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-018', 1799.00, 2343.00, 23.22, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Ivory Pedal Daypack', 'ivory-pedal-daypack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-019', 1799.00, 2343.00, 23.22, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Green Pedal Daypack', 'mint-green-pedal-daypack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-020', 1799.00, 2343.00, 23.22, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Sand Edition 2', 'pivot-taiga-backpack-sand-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-021', 4499.00, 5499.00, 18.19, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Seagrass Edition 2', 'pivot-taiga-backpack-seagrass-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-022', 4499.00, 5499.00, 18.19, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Coral Edition 2', 'pivot-taiga-backpack-coral-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-023', 4499.00, 5499.00, 18.19, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Basalt Edition 2', 'pivot-taiga-backpack-basalt-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-024', 4499.00, 5499.00, 18.19, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Taiga Backpack - Lagoon Edition 2', 'pivot-taiga-backpack-lagoon-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-025', 4499.00, 5499.00, 18.19, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Beige Pedal Daypack Edition 2', 'beige-pedal-daypack-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-026', 1799.00, 2343.00, 23.22, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Backpack Edition 2', 'navy-field-backpack-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-027', 3499.00, 3749.00, 6.67, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Clove Field Backpack Edition 2', 'clove-field-backpack-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-028', 3499.00, 3749.00, 6.67, 32, '', 0, 0, 4.59, 196
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Field Backpack Edition 2', 'khaki-beige-field-backpack-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-029', 3499.00, 3749.00, 6.67, 39, 'NEW', 0, 0, 4.76, 29
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Field Backpack Edition 2', 'crimson-red-field-backpack-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium backpack with durable construction and smart quick-access storage.', 'DO-BPK-030', 3499.00, 3749.00, 6.67, 46, '', 0, 1, 4.93, 42
FROM categories WHERE slug = 'backpacks'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Messenger / Laptop Bags (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Basalt', 'pivot-meridian-convertible-briefpack-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-001', 6999.00, 7999.00, 12.50, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Coral', 'pivot-meridian-convertible-briefpack-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-002', 6999.00, 7999.00, 12.50, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Sand', 'pivot-meridian-convertible-briefpack-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-003', 6999.00, 7999.00, 12.50, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Lagoon', 'pivot-meridian-convertible-briefpack-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-004', 6999.00, 7999.00, 12.50, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Seagrass', 'pivot-meridian-convertible-briefpack-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-005', 6999.00, 7999.00, 12.50, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Lagoon', 'pivot-ambit-messenger-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-006', 5499.00, 6874.00, 20.00, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Basalt', 'pivot-ambit-messenger-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-007', 5499.00, 6874.00, 20.00, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Sand', 'pivot-ambit-messenger-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-008', 5499.00, 6874.00, 20.00, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Seagrass', 'pivot-ambit-messenger-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-009', 5499.00, 6874.00, 20.00, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Coral', 'pivot-ambit-messenger-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-010', 5499.00, 6874.00, 20.00, 46, '', 0, 1, 4.83, 142
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Messenger Bag - Seagrass', 'pivot-messenger-bag-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-011', 3999.00, 4999.00, 20.00, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Messenger Bag - Sand', 'pivot-messenger-bag-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-012', 3999.00, 4999.00, 20.00, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Messenger Bag - Lagoon', 'pivot-messenger-bag-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-013', 3999.00, 4999.00, 20.00, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Messenger Bag - Basalt', 'pivot-messenger-bag-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-014', 3999.00, 4999.00, 20.00, 39, '', 0, 1, 4.41, 194
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Messenger Bag - Coral', 'pivot-messenger-bag-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-015', 3999.00, 4999.00, 20.00, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Commuter’s Everyday Pack', 'commuters-everyday-pack', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-016', 3699.00, 4687.00, 21.08, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Briefpack - Coral', 'pivot-briefpack-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-017', 5499.00, 5999.00, 8.33, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Briefpack - Seagrass', 'pivot-briefpack-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-018', 5499.00, 5999.00, 8.33, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Briefpack - Basalt', 'pivot-briefpack-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-019', 5499.00, 5999.00, 8.33, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Briefpack - Lagoon', 'pivot-briefpack-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-020', 5499.00, 5999.00, 8.33, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Basalt Edition 2', 'pivot-meridian-convertible-briefpack-basalt-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-021', 6999.00, 7999.00, 12.50, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Coral Edition 2', 'pivot-meridian-convertible-briefpack-coral-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-022', 6999.00, 7999.00, 12.50, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Sand Edition 2', 'pivot-meridian-convertible-briefpack-sand-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-023', 6999.00, 7999.00, 12.50, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Lagoon Edition 2', 'pivot-meridian-convertible-briefpack-lagoon-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-024', 6999.00, 7999.00, 12.50, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Meridian Convertible Briefpack - Seagrass Edition 2', 'pivot-meridian-convertible-briefpack-seagrass-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-025', 6999.00, 7999.00, 12.50, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Lagoon Edition 2', 'pivot-ambit-messenger-lagoon-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-026', 5499.00, 6874.00, 20.00, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Basalt Edition 2', 'pivot-ambit-messenger-basalt-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-027', 5499.00, 6874.00, 20.00, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Sand Edition 2', 'pivot-ambit-messenger-sand-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-028', 5499.00, 6874.00, 20.00, 32, '', 0, 0, 4.59, 196
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Seagrass Edition 2', 'pivot-ambit-messenger-seagrass-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-029', 5499.00, 6874.00, 20.00, 39, 'NEW', 0, 0, 4.76, 29
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Ambit Messenger - Coral Edition 2', 'pivot-ambit-messenger-coral-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium messenger / laptop bag with durable construction and smart quick-access storage.', 'DO-LAP-030', 5499.00, 6874.00, 20.00, 46, '', 0, 1, 4.93, 42
FROM categories WHERE slug = 'messenger-laptop-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Phone Bags (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Lagoon', 'pivot-crossbody-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-001', 2199.00, 2499.00, 12.00, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Seagrass', 'pivot-crossbody-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-002', 2199.00, 2499.00, 12.00, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Sand', 'pivot-crossbody-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-003', 2199.00, 2499.00, 12.00, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Coral', 'pivot-crossbody-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-004', 2199.00, 2499.00, 12.00, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Basalt', 'pivot-crossbody-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-005', 2199.00, 2499.00, 12.00, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Basalt', 'pivot-travel-sling-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-006', 1799.00, 2999.00, 40.01, 18, 'PRICE DROP', 0, 1, 4.70, 90
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Coral', 'pivot-travel-sling-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-007', 1999.00, 2999.00, 33.34, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Seagrass', 'pivot-travel-sling-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-008', 1799.00, 2999.00, 40.01, 32, 'PRICE DROP', 0, 0, 4.49, 116
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Lagoon', 'pivot-travel-sling-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-009', 1999.00, 2999.00, 33.34, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Sand', 'pivot-travel-sling-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-010', 1799.00, 2999.00, 40.01, 46, 'PRICE DROP', 0, 1, 4.83, 142
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Red Puft Bucket Sling Bag', 'red-puft-bucket-sling-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-011', 2299.00, 3599.00, 36.12, 18, 'PRICE DROP', 0, 0, 4.45, 155
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Colourblock Puft Bucket Sling Bag', 'colourblock-puft-bucket-sling-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-012', 2499.00, 3599.00, 30.56, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Blue Puft Bucket Sling Bag', 'blue-puft-bucket-sling-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-013', 2499.00, 3599.00, 30.56, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Puft Bucket Sling Bag', 'mint-puft-bucket-sling-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-014', 2299.00, 3599.00, 36.12, 39, 'PRICE DROP', 0, 1, 4.41, 194
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Sling Bag - Sand', 'pivot-sling-bag-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-015', 1999.00, 2999.00, 33.34, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Sling Bag - Basalt', 'pivot-sling-bag-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-016', 1999.00, 2999.00, 33.34, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Sling Bag - Seagrass', 'pivot-sling-bag-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-017', 1999.00, 2999.00, 33.34, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Sling Bag - Coral', 'pivot-sling-bag-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-018', 1999.00, 2999.00, 33.34, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Sling Bag - Lagoon', 'pivot-sling-bag-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-019', 1999.00, 2999.00, 33.34, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Monkey Shoulder x DO Utility Phone Sling', 'monkey-shoulder-x-do-utility-phone-sling', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-020', 1499.00, 2699.00, 44.46, 46, 'SOLD OUT', 0, 0, 4.88, 92
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Lagoon Edition 2', 'pivot-crossbody-lagoon-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-021', 2199.00, 2499.00, 12.00, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Seagrass Edition 2', 'pivot-crossbody-seagrass-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-022', 2199.00, 2499.00, 12.00, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Sand Edition 2', 'pivot-crossbody-sand-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-023', 2199.00, 2499.00, 12.00, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Coral Edition 2', 'pivot-crossbody-coral-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-024', 2199.00, 2499.00, 12.00, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Crossbody - Basalt Edition 2', 'pivot-crossbody-basalt-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-025', 2199.00, 2499.00, 12.00, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Basalt Edition 2', 'pivot-travel-sling-basalt-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-026', 1799.00, 2999.00, 40.01, 18, 'PRICE DROP', 0, 1, 4.80, 170
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Coral Edition 2', 'pivot-travel-sling-coral-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-027', 1999.00, 2999.00, 33.34, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Seagrass Edition 2', 'pivot-travel-sling-seagrass-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-028', 1799.00, 2999.00, 40.01, 32, 'PRICE DROP', 0, 0, 4.59, 196
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Lagoon Edition 2', 'pivot-travel-sling-lagoon-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-029', 1999.00, 2999.00, 33.34, 39, 'NEW', 0, 0, 4.76, 29
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Travel Sling - Sand Edition 2', 'pivot-travel-sling-sand-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium phone bag with durable construction and smart quick-access storage.', 'DO-PHN-030', 1799.00, 2999.00, 40.01, 46, 'PRICE DROP', 0, 1, 4.93, 42
FROM categories WHERE slug = 'phone-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Wallets (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Easy Square Pouch', 'carbon-black-easy-square-pouch', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-001', 599.00, 1499.00, 60.04, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Blue Tiny Taxi Organiser', 'navy-blue-tiny-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-002', 899.00, 1405.00, 36.01, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Tiny Taxi Organiser', 'crimson-red-tiny-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-003', 899.00, 1405.00, 36.01, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Tiny Taxi Organiser', 'khaki-beige-tiny-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-004', 899.00, 1405.00, 36.01, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Tiny Taxi Organiser', 'mustard-tiny-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-005', 799.00, 1405.00, 43.13, 46, 'PRICE DROP', 0, 0, 4.53, 77
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Tiny Taxi Organiser', 'olive-green-tiny-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-006', 899.00, 1405.00, 36.01, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Regular Taxi Organiser', 'crimson-red-regular-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-007', 1199.00, 1499.00, 20.01, 25, 'PRICE DROP', 1, 0, 4.87, 103
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green Regular Taxi Organiser', 'forest-green-regular-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-008', 1299.00, 1499.00, 13.34, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Regular Taxi Organiser', 'khaki-beige-regular-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-009', 1299.00, 1499.00, 13.34, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Regular Taxi Organiser', 'mustard-regular-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-010', 1299.00, 1499.00, 13.34, 46, '', 0, 1, 4.83, 142
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Regular Taxi Organiser', 'olive-green-regular-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-011', 1299.00, 1499.00, 13.34, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Jumbo Taxi Organiser', 'crimson-red-jumbo-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-012', 1399.00, 1874.00, 25.35, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Jumbo Taxi Organiser', 'khaki-beige-jumbo-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-013', 1399.00, 1874.00, 25.35, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Yellow Jumbo Taxi Organiser', 'mustard-yellow-jumbo-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-014', 1299.00, 1874.00, 30.68, 39, 'PRICE DROP', 0, 1, 4.41, 194
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Blue Jumbo Taxi Organiser', 'navy-blue-jumbo-taxi-organiser', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-015', 1399.00, 1874.00, 25.35, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Colourblock Puft Pouch', 'colourblock-puft-pouch', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-016', 1799.00, 2599.00, 30.78, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Puft Pouch', 'mint-puft-pouch', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-017', 1799.00, 2599.00, 30.78, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Yellow Puft Pouch', 'yellow-puft-pouch', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-018', 1799.00, 2599.00, 30.78, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Blue Puft Pouch', 'blue-puft-pouch', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-019', 1799.00, 2599.00, 30.78, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Coral Pivot Carry All Pouch - Large', 'coral-pivot-carry-all-pouch-large', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-020', 1499.00, 2499.00, 40.02, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Carbon Black Easy Square Pouch Edition 2', 'carbon-black-easy-square-pouch-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-021', 599.00, 1499.00, 60.04, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Blue Tiny Taxi Organiser Edition 2', 'navy-blue-tiny-taxi-organiser-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-022', 899.00, 1405.00, 36.01, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Tiny Taxi Organiser Edition 2', 'crimson-red-tiny-taxi-organiser-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-023', 899.00, 1405.00, 36.01, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Tiny Taxi Organiser Edition 2', 'khaki-beige-tiny-taxi-organiser-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-024', 899.00, 1405.00, 36.01, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Tiny Taxi Organiser Edition 2', 'mustard-tiny-taxi-organiser-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-025', 799.00, 1405.00, 43.13, 46, 'PRICE DROP', 1, 0, 4.63, 157
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Tiny Taxi Organiser Edition 2', 'olive-green-tiny-taxi-organiser-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-026', 899.00, 1405.00, 36.01, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Regular Taxi Organiser Edition 2', 'crimson-red-regular-taxi-organiser-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-027', 1199.00, 1499.00, 20.01, 25, 'PRICE DROP', 0, 0, 4.42, 183
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green Regular Taxi Organiser Edition 2', 'forest-green-regular-taxi-organiser-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-028', 1299.00, 1499.00, 13.34, 32, '', 0, 0, 4.59, 196
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Regular Taxi Organiser Edition 2', 'khaki-beige-regular-taxi-organiser-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-029', 1299.00, 1499.00, 13.34, 39, 'NEW', 0, 0, 4.76, 29
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Regular Taxi Organiser Edition 2', 'mustard-regular-taxi-organiser-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium wallet with durable construction and smart quick-access storage.', 'DO-WLT-030', 1299.00, 1499.00, 13.34, 46, '', 0, 1, 4.93, 42
FROM categories WHERE slug = 'wallets'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Duffle Bags (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Sand', 'pivot-duffle-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-001', 5999.00, 6999.00, 14.29, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Coral', 'pivot-duffle-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-002', 5999.00, 6999.00, 14.29, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Lagoon', 'pivot-duffle-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-003', 5999.00, 6999.00, 14.29, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Seagrass', 'pivot-duffle-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-004', 5999.00, 6999.00, 14.29, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Lagoon', 'pivot-weekender-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-005', 4999.00, 5999.00, 16.67, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Seagrass', 'pivot-weekender-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-006', 4999.00, 5999.00, 16.67, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Sand', 'pivot-weekender-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-007', 4999.00, 5999.00, 16.67, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Coral', 'pivot-weekender-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-008', 4999.00, 5999.00, 16.67, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Basalt', 'pivot-weekender-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-009', 4999.00, 5999.00, 16.67, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Field Duffle Bag', 'olive-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-010', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 1, 4.83, 142
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Duffle Bag', 'navy-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-011', 3099.00, 3562.00, 13.00, 18, 'SOLD OUT', 0, 0, 4.45, 155
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Field Duffle Bag', 'mustard-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-012', 3099.00, 3562.00, 13.00, 25, 'SOLD OUT', 0, 0, 4.62, 168
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Green Field Duffle Bag', 'mint-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-013', 3099.00, 3562.00, 13.00, 32, 'SOLD OUT', 1, 0, 4.79, 181
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Field Duffle Bag', 'khaki-beige-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-014', 3099.00, 3562.00, 13.00, 39, 'SOLD OUT', 0, 1, 4.41, 194
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green Field Duffle Bag', 'forest-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-015', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 0, 4.58, 27
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Field Duffle Bag', 'crimson-red-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-016', 3099.00, 3562.00, 13.00, 18, 'SOLD OUT', 0, 0, 4.75, 40
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Clove Field Duffle Bag', 'clove-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-017', 3099.00, 3562.00, 13.00, 25, 'SOLD OUT', 0, 0, 4.92, 53
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Basalt', 'pivot-duffle-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-018', 5999.00, 6999.00, 14.29, 32, 'SOLD OUT', 0, 1, 4.54, 66
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Sand Edition 2', 'pivot-duffle-sand-edition-2-19', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-019', 5999.00, 6999.00, 14.29, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Coral Edition 2', 'pivot-duffle-coral-edition-2-20', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-020', 5999.00, 6999.00, 14.29, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Lagoon Edition 2', 'pivot-duffle-lagoon-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-021', 5999.00, 6999.00, 14.29, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Seagrass Edition 2', 'pivot-duffle-seagrass-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-022', 5999.00, 6999.00, 14.29, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Lagoon Edition 2', 'pivot-weekender-lagoon-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-023', 4999.00, 5999.00, 16.67, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Seagrass Edition 2', 'pivot-weekender-seagrass-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-024', 4999.00, 5999.00, 16.67, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Sand Edition 2', 'pivot-weekender-sand-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-025', 4999.00, 5999.00, 16.67, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Coral Edition 2', 'pivot-weekender-coral-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-026', 4999.00, 5999.00, 16.67, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Basalt Edition 2', 'pivot-weekender-basalt-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-027', 4999.00, 5999.00, 16.67, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Field Duffle Bag Edition 2', 'olive-green-field-duffle-bag-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-028', 3099.00, 3562.00, 13.00, 32, 'SOLD OUT', 0, 0, 4.59, 196
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Duffle Bag Edition 2', 'navy-field-duffle-bag-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-029', 3099.00, 3562.00, 13.00, 39, 'SOLD OUT', 0, 0, 4.76, 29
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Field Duffle Bag Edition 2', 'mustard-field-duffle-bag-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium duffle bag with durable construction and smart quick-access storage.', 'DO-DUF-030', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 1, 4.93, 42
FROM categories WHERE slug = 'duffle-bags'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Pouches (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Sand', 'pivot-duffle-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-001', 5999.00, 6999.00, 14.29, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Coral', 'pivot-duffle-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-002', 5999.00, 6999.00, 14.29, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Lagoon', 'pivot-duffle-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-003', 5999.00, 6999.00, 14.29, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Seagrass', 'pivot-duffle-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-004', 5999.00, 6999.00, 14.29, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Lagoon', 'pivot-weekender-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-005', 4999.00, 5999.00, 16.67, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Seagrass', 'pivot-weekender-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-006', 4999.00, 5999.00, 16.67, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Sand', 'pivot-weekender-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-007', 4999.00, 5999.00, 16.67, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Coral', 'pivot-weekender-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-008', 4999.00, 5999.00, 16.67, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Basalt', 'pivot-weekender-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-009', 4999.00, 5999.00, 16.67, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Field Duffle Bag', 'olive-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-010', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 1, 4.83, 142
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Duffle Bag', 'navy-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-011', 3099.00, 3562.00, 13.00, 18, 'SOLD OUT', 0, 0, 4.45, 155
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Field Duffle Bag', 'mustard-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-012', 3099.00, 3562.00, 13.00, 25, 'SOLD OUT', 0, 0, 4.62, 168
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Green Field Duffle Bag', 'mint-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-013', 3099.00, 3562.00, 13.00, 32, 'SOLD OUT', 1, 0, 4.79, 181
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Khaki Beige Field Duffle Bag', 'khaki-beige-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-014', 3099.00, 3562.00, 13.00, 39, 'SOLD OUT', 0, 1, 4.41, 194
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Forest Green Field Duffle Bag', 'forest-green-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-015', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 0, 4.58, 27
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Crimson Red Field Duffle Bag', 'crimson-red-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-016', 3099.00, 3562.00, 13.00, 18, 'SOLD OUT', 0, 0, 4.75, 40
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Clove Field Duffle Bag', 'clove-field-duffle-bag', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-017', 3099.00, 3562.00, 13.00, 25, 'SOLD OUT', 0, 0, 4.92, 53
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Basalt', 'pivot-duffle-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-018', 5999.00, 6999.00, 14.29, 32, 'SOLD OUT', 0, 1, 4.54, 66
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Sand Edition 2', 'pivot-duffle-sand-edition-2-19', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-019', 5999.00, 6999.00, 14.29, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Coral Edition 2', 'pivot-duffle-coral-edition-2-20', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-020', 5999.00, 6999.00, 14.29, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Lagoon Edition 2', 'pivot-duffle-lagoon-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-021', 5999.00, 6999.00, 14.29, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Duffle - Seagrass Edition 2', 'pivot-duffle-seagrass-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-022', 5999.00, 6999.00, 14.29, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Lagoon Edition 2', 'pivot-weekender-lagoon-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-023', 4999.00, 5999.00, 16.67, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Seagrass Edition 2', 'pivot-weekender-seagrass-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-024', 4999.00, 5999.00, 16.67, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Sand Edition 2', 'pivot-weekender-sand-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-025', 4999.00, 5999.00, 16.67, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Coral Edition 2', 'pivot-weekender-coral-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-026', 4999.00, 5999.00, 16.67, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Weekender - Basalt Edition 2', 'pivot-weekender-basalt-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-027', 4999.00, 5999.00, 16.67, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Olive Green Field Duffle Bag Edition 2', 'olive-green-field-duffle-bag-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-028', 3099.00, 3562.00, 13.00, 32, 'SOLD OUT', 0, 0, 4.59, 196
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Navy Field Duffle Bag Edition 2', 'navy-field-duffle-bag-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-029', 3099.00, 3562.00, 13.00, 39, 'SOLD OUT', 0, 0, 4.76, 29
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mustard Field Duffle Bag Edition 2', 'mustard-field-duffle-bag-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium pouche with durable construction and smart quick-access storage.', 'DO-PCH-030', 3099.00, 3562.00, 13.00, 46, 'SOLD OUT', 0, 1, 4.93, 42
FROM categories WHERE slug = 'pouches'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- ---------------------------------------------------------
-- Category: Bag Accessories (30 Products)
-- ---------------------------------------------------------

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Coral', 'pivot-micro-bag-coral', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-001', 999.00, 1099.00, 9.10, 18, 'BESTSELLER', 1, 0, 4.40, 25
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Seagrass', 'pivot-micro-bag-seagrass', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-002', 999.00, 1099.00, 9.10, 25, '', 0, 1, 4.57, 38
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Lagoon', 'pivot-micro-bag-lagoon', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-003', 999.00, 1099.00, 9.10, 32, '', 0, 0, 4.74, 51
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Sand', 'pivot-micro-bag-sand', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-004', 999.00, 1099.00, 9.10, 39, '', 0, 0, 4.91, 64
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Basalt', 'pivot-micro-bag-basalt', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-005', 999.00, 1099.00, 9.10, 46, '', 0, 0, 4.53, 77
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Puft Bouquet Charm', 'puft-bouquet-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-006', 899.00, 1299.00, 30.79, 18, 'BESTSELLER', 0, 1, 4.70, 90
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Puft Heart-to-Heart Charm', 'puft-heart-to-heart-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-007', 899.00, 1299.00, 30.79, 25, '', 1, 0, 4.87, 103
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pixel Eyes Enamel Pin', 'pixel-eyes-enamel-pin', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-008', 599.00, 699.00, 14.31, 32, 'NEW', 0, 0, 4.49, 116
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Candy Cane Puft Wishing Star Charm', 'candy-cane-puft-wishing-star-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-009', 599.00, 699.00, 14.31, 39, '', 0, 0, 4.66, 129
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Yellow Puft Wishing Star Charm', 'yellow-puft-wishing-star-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-010', 599.00, 699.00, 14.31, 46, '', 0, 1, 4.83, 142
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Periwinkle Puft Wishing Star Charm', 'periwinkle-puft-wishing-star-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-011', 599.00, 699.00, 14.31, 18, 'BESTSELLER', 0, 0, 4.45, 155
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Periwinkle Puft Holly Heart Charm', 'periwinkle-puft-holly-heart-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-012', 599.00, 699.00, 14.31, 25, '', 0, 0, 4.62, 168
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Puft Wishing Star Charm', 'mint-puft-wishing-star-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-013', 599.00, 699.00, 14.31, 32, '', 1, 0, 4.79, 181
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Candy Cane Puft Holly Heart Charm', 'candy-cane-puft-holly-heart-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-014', 599.00, 699.00, 14.31, 39, '', 0, 1, 4.41, 194
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Candy Cane Puft Christmas Tree Charm', 'candy-cane-puft-christmas-tree-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-015', 599.00, 699.00, 14.31, 46, 'NEW', 0, 0, 4.58, 27
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Puft Holly Heart Charm', 'mint-puft-holly-heart-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-016', 599.00, 699.00, 14.31, 18, 'BESTSELLER', 0, 0, 4.75, 40
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Evergreen Puft Wishing Star Charm', 'evergreen-puft-wishing-star-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-017', 599.00, 699.00, 14.31, 25, '', 0, 0, 4.92, 53
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Evergreen Puft Holly Heart Charm', 'evergreen-puft-holly-heart-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-018', 599.00, 699.00, 14.31, 32, '', 0, 1, 4.54, 66
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Mint Puft Fortune Fish Charm', 'mint-puft-fortune-fish-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-019', 599.00, 699.00, 14.31, 39, '', 1, 0, 4.71, 79
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Periwinkle Puft Christmas Tree Charm', 'periwinkle-puft-christmas-tree-charm', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-020', 599.00, 699.00, 14.31, 46, '', 0, 0, 4.88, 92
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Coral Edition 2', 'pivot-micro-bag-coral-edition-2-21', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-021', 999.00, 1099.00, 9.10, 18, 'BESTSELLER', 0, 0, 4.50, 105
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Seagrass Edition 2', 'pivot-micro-bag-seagrass-edition-2-22', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-022', 999.00, 1099.00, 9.10, 25, 'NEW', 0, 1, 4.67, 118
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Lagoon Edition 2', 'pivot-micro-bag-lagoon-edition-2-23', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-023', 999.00, 1099.00, 9.10, 32, '', 0, 0, 4.84, 131
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Sand Edition 2', 'pivot-micro-bag-sand-edition-2-24', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-024', 999.00, 1099.00, 9.10, 39, '', 0, 0, 4.46, 144
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pivot Micro Bag - Basalt Edition 2', 'pivot-micro-bag-basalt-edition-2-25', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-025', 999.00, 1099.00, 9.10, 46, '', 1, 0, 4.63, 157
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Puft Bouquet Charm Edition 2', 'puft-bouquet-charm-edition-2-26', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-026', 899.00, 1299.00, 30.79, 18, 'BESTSELLER', 0, 1, 4.80, 170
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Puft Heart-to-Heart Charm Edition 2', 'puft-heart-to-heart-charm-edition-2-27', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-027', 899.00, 1299.00, 30.79, 25, '', 0, 0, 4.42, 183
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Pixel Eyes Enamel Pin Edition 2', 'pixel-eyes-enamel-pin-edition-2-28', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-028', 599.00, 699.00, 14.31, 32, '', 0, 0, 4.59, 196
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Candy Cane Puft Wishing Star Charm Edition 2', 'candy-cane-puft-wishing-star-charm-edition-2-29', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-029', 599.00, 699.00, 14.31, 39, 'NEW', 0, 0, 4.76, 29
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)
SELECT id, 'Yellow Puft Wishing Star Charm Edition 2', 'yellow-puft-wishing-star-charm-edition-2-30', 'Engineered for modern movement and urban utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.', 'Premium bag accessorie with durable construction and smart quick-access storage.', 'DO-ACC-030', 599.00, 699.00, 14.31, 46, '', 0, 1, 4.93, 42
FROM categories WHERE slug = 'bag-accessories'
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);

-- =========================================================
-- SEED EXACT DAILY OBJECTS CDN IMAGES FOR ALL 270 PRODUCTS
-- =========================================================

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/scarlet-wing-city-tote-images/Scarlet-Wing-City-Tote.png?tr=cm-pad_resize,v-3', 'scarlet-wing-city-tote', 1, 1
FROM products WHERE slug = 'scarlet-wing-city-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/scarlet-wing-city-tote-images/Scarlet-Wing-City-Tote-8.jpg?tr=cm-pad_crop,v-3', 'scarlet-wing-city-tote detail view', 2, 0
FROM products WHERE slug = 'scarlet-wing-city-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'lagoon-basalt-pivot-key-tote', 1, 1
FROM products WHERE slug = 'lagoon-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'lagoon-basalt-pivot-key-tote detail view', 2, 0
FROM products WHERE slug = 'lagoon-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'sand-basalt-pivot-key-tote', 1, 1
FROM products WHERE slug = 'sand-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'sand-basalt-pivot-key-tote detail view', 2, 0
FROM products WHERE slug = 'sand-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/coral-basalt-pivot-key-tote-images/Coral-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'coral-basalt-pivot-key-tote', 1, 1
FROM products WHERE slug = 'coral-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/coral-basalt-pivot-key-tote-images/Coral-Basalt-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'coral-basalt-pivot-key-tote detail view', 2, 0
FROM products WHERE slug = 'coral-basalt-pivot-key-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/black-wing-tote-images/Black-Wing-Tote-vw.png?tr=cm-pad_resize,v-3', 'black-wing-tote', 1, 1
FROM products WHERE slug = 'black-wing-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/black-wing-tote-images/Black-Wing-Tote-7.jpg?tr=cm-pad_crop,v-3', 'black-wing-tote detail view', 2, 0
FROM products WHERE slug = 'black-wing-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral.png?tr=cm-pad_resize,v-3', 'pivot-classic-tote-coral', 1, 1
FROM products WHERE slug = 'pivot-classic-tote-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-classic-tote-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-classic-tote-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-classic-tote-basalt', 1, 1
FROM products WHERE slug = 'pivot-classic-tote-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-classic-tote-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-classic-tote-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3', 'cardinal-love-idyll-tote-bag', 1, 1
FROM products WHERE slug = 'cardinal-love-idyll-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag-2.png?tr=cm-pad_resize,v-3', 'cardinal-love-idyll-tote-bag detail view', 2, 0
FROM products WHERE slug = 'cardinal-love-idyll-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'space-blue-idyll-tote', 1, 1
FROM products WHERE slug = 'space-blue-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote-2.png?tr=cm-pad_resize,v-3', 'space-blue-idyll-tote detail view', 2, 0
FROM products WHERE slug = 'space-blue-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'carbon-black-idyll-tote', 1, 1
FROM products WHERE slug = 'carbon-black-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote-9.jpg?tr=cm-pad_crop,v-3', 'carbon-black-idyll-tote detail view', 2, 0
FROM products WHERE slug = 'carbon-black-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/olive-green-clove-field-tote-bag-images/Olive-Green-Clove-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'olive-green-clove-field-tote-bag', 1, 1
FROM products WHERE slug = 'olive-green-clove-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/olive-green-clove-field-tote-bag-images/Olive-Green-Clove-Field-Tote-Bag-2nd.jpg?tr=cm-pad_crop,v-3', 'olive-green-clove-field-tote-bag detail view', 2, 0
FROM products WHERE slug = 'olive-green-clove-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'ivory-crimson-red-field-tote-bag', 1, 1
FROM products WHERE slug = 'ivory-crimson-red-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-2nd.jpg?tr=cm-pad_crop,v-3', 'ivory-crimson-red-field-tote-bag detail view', 2, 0
FROM products WHERE slug = 'ivory-crimson-red-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/forest-green-navy-field-tote-bag-images/Forest-Green-Navy-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'forest-green-navy-field-tote-bag', 1, 1
FROM products WHERE slug = 'forest-green-navy-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/forest-green-navy-field-tote-bag-images/Forest-Green-Navy-Field-Tote-Bag-2Nd.jpg?tr=cm-pad_crop,v-3', 'forest-green-navy-field-tote-bag detail view', 2, 0
FROM products WHERE slug = 'forest-green-navy-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/slate-gray-idyll-tote-images/Slate-Gray-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'slate-gray-idyll-tote', 1, 1
FROM products WHERE slug = 'slate-gray-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/slate-gray-idyll-tote-images/Slate-Gray-Idyll-Tote-2.png?tr=cm-pad_resize,v-3', 'slate-gray-idyll-tote detail view', 2, 0
FROM products WHERE slug = 'slate-gray-idyll-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/crimson-red-field-tote-bag-images/Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'crimson-red-field-tote-bag', 1, 1
FROM products WHERE slug = 'crimson-red-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/crimson-red-field-tote-bag-images/Crimson-Red-Field-Tote-Bag-2nd.jpg?tr=cm-pad_crop,v-3', 'crimson-red-field-tote-bag detail view', 2, 0
FROM products WHERE slug = 'crimson-red-field-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-green-vessel-leather-pocket-tote-images/Ivory-Green-Vessel-Leather-Pocket-Tote-vw.png?tr=cm-pad_resize,v-3', 'ivory-green-vessel-leather-pocket-tote', 1, 1
FROM products WHERE slug = 'ivory-green-vessel-leather-pocket-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-green-vessel-leather-pocket-tote-images/Ivory-Green-Vessel-Leather-Pocket-Tote-11t.jpg?tr=cm-pad_crop,v-3', 'ivory-green-vessel-leather-pocket-tote detail view', 2, 0
FROM products WHERE slug = 'ivory-green-vessel-leather-pocket-tote'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-midnight-blue-buoy-tote-bag-images/DailyObjects-Midnight-Blue-Buoyant-Tote-Bag.png?tr=cm-pad_resize,v-3', 'midnight-blue-buoy-tote-bag', 1, 1
FROM products WHERE slug = 'midnight-blue-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-midnight-blue-buoy-tote-bag-images/DailyObjects-Midnight-Blue-Buoyant-Tote-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'midnight-blue-buoy-tote-bag detail view', 2, 0
FROM products WHERE slug = 'midnight-blue-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-khaki-beige-buoy-tote-bag-images/DailyObjects-Khaki-Beige-Buoyant-Tote-Bag.png?tr=cm-pad_resize,v-3', 'khaki-beige-buoy-tote-bag', 1, 1
FROM products WHERE slug = 'khaki-beige-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-khaki-beige-buoy-tote-bag-images/DailyObjects-Khaki-Beige-Buoyant-Tote-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-buoy-tote-bag detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-mint-green-buoy-tote-bag-images/DailyObjects-Sage-Green-Buoy-Tote-Bag.png?tr=cm-pad_resize,v-3', 'mint-green-buoy-tote-bag', 1, 1
FROM products WHERE slug = 'mint-green-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-mint-green-buoy-tote-bag-images/DailyObjects-Sage-Green-Buoy-Tote-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mint-green-buoy-tote-bag detail view', 2, 0
FROM products WHERE slug = 'mint-green-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/dailyobjects-mustard-yellow-buoy-tote-bag-images/DailyObjects-Yellow-Buoyant-Tote-Bag.png?tr=cm-pad_resize,v-3', 'mustard-buoy-tote-bag', 1, 1
FROM products WHERE slug = 'mustard-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/dailyobjects-mustard-yellow-buoy-tote-bag-images/DailyObjects-Yellow-Buoyant-Tote-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mustard-buoy-tote-bag detail view', 2, 0
FROM products WHERE slug = 'mustard-buoy-tote-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/scarlet-wing-city-tote-images/Scarlet-Wing-City-Tote.png?tr=cm-pad_resize,v-3', 'scarlet-wing-city-tote-edition-2-21', 1, 1
FROM products WHERE slug = 'scarlet-wing-city-tote-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/scarlet-wing-city-tote-images/Scarlet-Wing-City-Tote-8.jpg?tr=cm-pad_crop,v-3', 'scarlet-wing-city-tote-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'scarlet-wing-city-tote-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'lagoon-basalt-pivot-key-tote-edition-2-22', 1, 1
FROM products WHERE slug = 'lagoon-basalt-pivot-key-tote-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/lagoon-basalt-clay-pivot-key-tote-images/Lagoon-Basalt-Clay-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'lagoon-basalt-pivot-key-tote-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'lagoon-basalt-pivot-key-tote-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'sand-basalt-pivot-key-tote-edition-2-23', 1, 1
FROM products WHERE slug = 'sand-basalt-pivot-key-tote-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'sand-basalt-pivot-key-tote-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'sand-basalt-pivot-key-tote-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/coral-basalt-pivot-key-tote-images/Coral-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'coral-basalt-pivot-key-tote-edition-2-24', 1, 1
FROM products WHERE slug = 'coral-basalt-pivot-key-tote-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/coral-basalt-pivot-key-tote-images/Coral-Basalt-Pivot-Key-Tote-2.png?tr=cm-pad_resize,v-3', 'coral-basalt-pivot-key-tote-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'coral-basalt-pivot-key-tote-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/black-wing-tote-images/Black-Wing-Tote-vw.png?tr=cm-pad_resize,v-3', 'black-wing-tote-edition-2-25', 1, 1
FROM products WHERE slug = 'black-wing-tote-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/black-wing-tote-images/Black-Wing-Tote-7.jpg?tr=cm-pad_crop,v-3', 'black-wing-tote-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'black-wing-tote-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral.png?tr=cm-pad_resize,v-3', 'pivot-classic-tote-coral-edition-2-26', 1, 1
FROM products WHERE slug = 'pivot-classic-tote-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-classic-tote-coral-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'pivot-classic-tote-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-classic-tote-basalt-edition-2-27', 1, 1
FROM products WHERE slug = 'pivot-classic-tote-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-classic-tote-basalt-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'pivot-classic-tote-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3', 'cardinal-love-idyll-tote-bag-edition-2-28', 1, 1
FROM products WHERE slug = 'cardinal-love-idyll-tote-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag-2.png?tr=cm-pad_resize,v-3', 'cardinal-love-idyll-tote-bag-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'cardinal-love-idyll-tote-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'space-blue-idyll-tote-edition-2-29', 1, 1
FROM products WHERE slug = 'space-blue-idyll-tote-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote-2.png?tr=cm-pad_resize,v-3', 'space-blue-idyll-tote-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'space-blue-idyll-tote-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'carbon-black-idyll-tote-edition-2-30', 1, 1
FROM products WHERE slug = 'carbon-black-idyll-tote-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote-9.jpg?tr=cm-pad_crop,v-3', 'carbon-black-idyll-tote-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'carbon-black-idyll-tote-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-sand', 1, 1
FROM products WHERE slug = 'pivot-crossbody-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-basalt', 1, 1
FROM products WHERE slug = 'pivot-crossbody-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-seagrass', 1, 1
FROM products WHERE slug = 'pivot-crossbody-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-coral', 1, 1
FROM products WHERE slug = 'pivot-crossbody-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-lagoon', 1, 1
FROM products WHERE slug = 'pivot-crossbody-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/scarlet-wing-crossbody-images/Scarlet-Wing-Crossbody.png?tr=cm-pad_resize,v-3', 'scarlet-wing-crossbody', 1, 1
FROM products WHERE slug = 'scarlet-wing-crossbody'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/scarlet-wing-crossbody-images/Scarlet-Wing-Crossbody-7.jpg?tr=cm-pad_crop,v-3', 'scarlet-wing-crossbody detail view', 2, 0
FROM products WHERE slug = 'scarlet-wing-crossbody'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/carbon-black-retreat-crossbody-bag-images/Carbon-Black-Retreat-Crossbody-Bag.png?tr=cm-pad_resize,v-3', 'carbon-black-retreat-crossbody-bag', 1, 1
FROM products WHERE slug = 'carbon-black-retreat-crossbody-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/carbon-black-retreat-crossbody-bag-images/Carbon-Black-Retreat-Crossbody-Bag-7t.jpg?tr=cm-pad_crop,v-3', 'carbon-black-retreat-crossbody-bag detail view', 2, 0
FROM products WHERE slug = 'carbon-black-retreat-crossbody-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/khaki-beige-march-crossbody-bag-large-images/Khaki-Beige-March-Crossbody-Bag-Larrge.png?tr=cm-pad_resize,v-3', 'khaki-beige-march-crossbody-bag-large', 1, 1
FROM products WHERE slug = 'khaki-beige-march-crossbody-bag-large'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/khaki-beige-march-crossbody-bag-large-images/Khaki-Beige-March-Crossbody-Bag-Larrge-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-march-crossbody-bag-large detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-march-crossbody-bag-large'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/black-wing-crossbody-images/Black-Wing-Crossbody-vw.png?tr=cm-pad_resize,v-3', 'black-wing-crossbody', 1, 1
FROM products WHERE slug = 'black-wing-crossbody'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/black-wing-crossbody-images/Black-Wing-Crossbody-7.jpg?tr=cm-pad_crop,v-3', 'black-wing-crossbody detail view', 2, 0
FROM products WHERE slug = 'black-wing-crossbody'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/basalt-pivot-orbit-fanny-images/Basalt-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'basalt-pivot-orbit-fanny', 1, 1
FROM products WHERE slug = 'basalt-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/basalt-pivot-orbit-fanny-images/Basalt-Pivot-Orbit-Fanny-2.png?tr=cm-pad_resize,v-3', 'basalt-pivot-orbit-fanny detail view', 2, 0
FROM products WHERE slug = 'basalt-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/coral-pivot-orbit-fanny-images/Coral-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'coral-pivot-orbit-fanny', 1, 1
FROM products WHERE slug = 'coral-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/coral-pivot-orbit-fanny-images/Coral-Pivot-Orbit-Fanny-2.png?tr=cm-pad_resize,v-3', 'coral-pivot-orbit-fanny detail view', 2, 0
FROM products WHERE slug = 'coral-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/seagrass-pivot-orbit-fanny-images/Seagrass-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'seagrass-pivot-orbit-fanny', 1, 1
FROM products WHERE slug = 'seagrass-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/seagrass-pivot-orbit-fanny-images/Seagrass-Pivot-Orbit-Fanny-2.png?tr=cm-pad_resize,v-3', 'seagrass-pivot-orbit-fanny detail view', 2, 0
FROM products WHERE slug = 'seagrass-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/sand-pivot-orbit-fanny-images/Sand-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'sand-pivot-orbit-fanny', 1, 1
FROM products WHERE slug = 'sand-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/sand-pivot-orbit-fanny-images/Sand-Pivot-Orbit-Fanny-2.png?tr=cm-pad_resize,v-3', 'sand-pivot-orbit-fanny detail view', 2, 0
FROM products WHERE slug = 'sand-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/lagoon-pivot-orbit-fanny-images/Lagoon-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'lagoon-pivot-orbit-fanny', 1, 1
FROM products WHERE slug = 'lagoon-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/lagoon-pivot-orbit-fanny-images/Lagoon-Pivot-Orbit-Fanny-2n.png?tr=cm-pad_resize,v-3', 'lagoon-pivot-orbit-fanny detail view', 2, 0
FROM products WHERE slug = 'lagoon-pivot-orbit-fanny'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-lagoon', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-coral', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-sand', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-seagrass', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-basalt', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/cardinal-love-march-crossbody-bag-regular-images/Cardinal-Love-March-Crossbody-Bag-Regular.png?tr=cm-pad_resize,v-3', 'cardinal-love-march-crossbody-bag-regular', 1, 1
FROM products WHERE slug = 'cardinal-love-march-crossbody-bag-regular'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/cardinal-love-march-crossbody-bag-regular-images/Cardinal-Love-March-Crossbody-Bag-Regular-2.png?tr=cm-pad_resize,v-3', 'cardinal-love-march-crossbody-bag-regular detail view', 2, 0
FROM products WHERE slug = 'cardinal-love-march-crossbody-bag-regular'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-sand-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-crossbody-sand-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-sand-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-sand-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-basalt-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-crossbody-basalt-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-basalt-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-basalt-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-seagrass-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-crossbody-seagrass-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-seagrass-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-seagrass-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-coral-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-crossbody-coral-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-coral-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-coral-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-lagoon-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-crossbody-lagoon-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-lagoon-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-lagoon-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/scarlet-wing-crossbody-images/Scarlet-Wing-Crossbody.png?tr=cm-pad_resize,v-3', 'scarlet-wing-crossbody-edition-2-26', 1, 1
FROM products WHERE slug = 'scarlet-wing-crossbody-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/scarlet-wing-crossbody-images/Scarlet-Wing-Crossbody-7.jpg?tr=cm-pad_crop,v-3', 'scarlet-wing-crossbody-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'scarlet-wing-crossbody-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/carbon-black-retreat-crossbody-bag-images/Carbon-Black-Retreat-Crossbody-Bag.png?tr=cm-pad_resize,v-3', 'carbon-black-retreat-crossbody-bag-edition-2-27', 1, 1
FROM products WHERE slug = 'carbon-black-retreat-crossbody-bag-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/carbon-black-retreat-crossbody-bag-images/Carbon-Black-Retreat-Crossbody-Bag-7t.jpg?tr=cm-pad_crop,v-3', 'carbon-black-retreat-crossbody-bag-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'carbon-black-retreat-crossbody-bag-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/khaki-beige-march-crossbody-bag-large-images/Khaki-Beige-March-Crossbody-Bag-Larrge.png?tr=cm-pad_resize,v-3', 'khaki-beige-march-crossbody-bag-large-edition-2-28', 1, 1
FROM products WHERE slug = 'khaki-beige-march-crossbody-bag-large-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/khaki-beige-march-crossbody-bag-large-images/Khaki-Beige-March-Crossbody-Bag-Larrge-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-march-crossbody-bag-large-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-march-crossbody-bag-large-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/black-wing-crossbody-images/Black-Wing-Crossbody-vw.png?tr=cm-pad_resize,v-3', 'black-wing-crossbody-edition-2-29', 1, 1
FROM products WHERE slug = 'black-wing-crossbody-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/black-wing-crossbody-images/Black-Wing-Crossbody-7.jpg?tr=cm-pad_crop,v-3', 'black-wing-crossbody-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'black-wing-crossbody-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/basalt-pivot-orbit-fanny-images/Basalt-Pivot-Orbit-Fanny.png?tr=cm-pad_resize,v-3', 'basalt-pivot-orbit-fanny-edition-2-30', 1, 1
FROM products WHERE slug = 'basalt-pivot-orbit-fanny-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1203/basalt-pivot-orbit-fanny-images/Basalt-Pivot-Orbit-Fanny-2.png?tr=cm-pad_resize,v-3', 'basalt-pivot-orbit-fanny-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'basalt-pivot-orbit-fanny-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-sand-images/Pivot-Taiga-Backpack-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-sand', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-sand-images/Pivot-Taiga-Backpack-Sand-10t.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-seagrass-images/Pivot-Taiga-Backpack-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-seagrass', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-seagrass-images/Pivot-Taiga-Backpack-Seagrass-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-coral-images/Pivot-Taiga-Backpack-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-coral', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-coral-images/Pivot-Taiga-Backpack-Coral-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-basalt-images/Pivot-Taiga-Backpack-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-basalt', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-basalt-images/Pivot-Taiga-Backpack-Basalt-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-lagoon-images/Pivot-Taiga-Backpack-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-lagoon', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-lagoon-images/Pivot-Taiga-Backpack-Lagoon-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-beige-pedal-daypack-images/All-Beige-Pedal-Daypack-vw.png?tr=cm-pad_resize,v-3', 'beige-pedal-daypack', 1, 1
FROM products WHERE slug = 'beige-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-beige-pedal-daypack-images/All-Beige-Pedal-Daypack-13th.jpg?tr=cm-pad_crop,v-3', 'beige-pedal-daypack detail view', 2, 0
FROM products WHERE slug = 'beige-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/navy-field-backpack-images/Navy-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'navy-field-backpack', 1, 1
FROM products WHERE slug = 'navy-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/navy-field-backpack-images/Navy-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-backpack detail view', 2, 0
FROM products WHERE slug = 'navy-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/clove-field-backpack-images/Clove-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'clove-field-backpack', 1, 1
FROM products WHERE slug = 'clove-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/clove-field-backpack-images/Clove-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'clove-field-backpack detail view', 2, 0
FROM products WHERE slug = 'clove-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/khaki-beige-field-backpack-images/Khaki-Beige-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'khaki-beige-field-backpack', 1, 1
FROM products WHERE slug = 'khaki-beige-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/khaki-beige-field-backpack-images/Khaki-Beige-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-field-backpack detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/crimson-red-field-backpack-images/Crimson-Red-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'crimson-red-field-backpack', 1, 1
FROM products WHERE slug = 'crimson-red-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/crimson-red-field-backpack-images/Crimson-Red-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'crimson-red-field-backpack detail view', 2, 0
FROM products WHERE slug = 'crimson-red-field-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/black-wing-backpack-images/Black-Wing-Backpack-Vw.png?tr=cm-pad_resize,v-3', 'black-wing-backpack', 1, 1
FROM products WHERE slug = 'black-wing-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/black-wing-backpack-images/Black-Wing-Backpack-7.jpg?tr=cm-pad_crop,v-3', 'black-wing-backpack detail view', 2, 0
FROM products WHERE slug = 'black-wing-backpack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-lunar-daypack-basalt-images/Pivot-Lunar-Daypack-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-lunar-daypack-basalt', 1, 1
FROM products WHERE slug = 'pivot-lunar-daypack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-lunar-daypack-basalt-images/Pivot-Lunar-Daypack-Basalt-2.png?tr=cm-pad_resize,v-3', 'pivot-lunar-daypack-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-lunar-daypack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-sand', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-basalt', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-coral', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-seagrass', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-lagoon', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/forest-green-pedal-daypack-images/Forest-Green-Pedal-Daypack-vw.png?tr=cm-pad_resize,v-3', 'forest-green-pedal-daypack', 1, 1
FROM products WHERE slug = 'forest-green-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/forest-green-pedal-daypack-images/Forest-Green-Pedal-Daypack-2nd.jpg?tr=cm-pad_crop,v-3', 'forest-green-pedal-daypack detail view', 2, 0
FROM products WHERE slug = 'forest-green-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-ivory-pedal-daypack-images/All-Ivory-Pedal-Daypack.png?tr=cm-pad_resize,v-3', 'ivory-pedal-daypack', 1, 1
FROM products WHERE slug = 'ivory-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-ivory-pedal-daypack-images/All-Ivory-Pedal-Daypack-14.jpg?tr=cm-pad_crop,v-3', 'ivory-pedal-daypack detail view', 2, 0
FROM products WHERE slug = 'ivory-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/dailyobjects-mint-green-pedal-daypack-images/Sage-Green-Pedal-Daypack.png?tr=cm-pad_resize,v-3', 'mint-green-pedal-daypack', 1, 1
FROM products WHERE slug = 'mint-green-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/dailyobjects-mint-green-pedal-daypack-images/Sage-Green-Pedal-Daypack-2n.jpg?tr=cm-pad_crop,v-3', 'mint-green-pedal-daypack detail view', 2, 0
FROM products WHERE slug = 'mint-green-pedal-daypack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-sand-images/Pivot-Taiga-Backpack-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-sand-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-sand-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-sand-images/Pivot-Taiga-Backpack-Sand-10t.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-sand-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-sand-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-seagrass-images/Pivot-Taiga-Backpack-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-seagrass-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-seagrass-images/Pivot-Taiga-Backpack-Seagrass-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-seagrass-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-coral-images/Pivot-Taiga-Backpack-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-coral-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-coral-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-coral-images/Pivot-Taiga-Backpack-Coral-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-coral-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-coral-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-basalt-images/Pivot-Taiga-Backpack-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-basalt-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-basalt-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-basalt-images/Pivot-Taiga-Backpack-Basalt-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-basalt-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-basalt-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-lagoon-images/Pivot-Taiga-Backpack-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-taiga-backpack-lagoon-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-taiga-backpack-lagoon-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/pivot-taiga-backpack-lagoon-images/Pivot-Taiga-Backpack-Lagoon-10.jpg?tr=cm-pad_crop,v-3', 'pivot-taiga-backpack-lagoon-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-taiga-backpack-lagoon-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-beige-pedal-daypack-images/All-Beige-Pedal-Daypack-vw.png?tr=cm-pad_resize,v-3', 'beige-pedal-daypack-edition-2-26', 1, 1
FROM products WHERE slug = 'beige-pedal-daypack-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/all-beige-pedal-daypack-images/All-Beige-Pedal-Daypack-13th.jpg?tr=cm-pad_crop,v-3', 'beige-pedal-daypack-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'beige-pedal-daypack-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/navy-field-backpack-images/Navy-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'navy-field-backpack-edition-2-27', 1, 1
FROM products WHERE slug = 'navy-field-backpack-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/navy-field-backpack-images/Navy-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-backpack-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'navy-field-backpack-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/clove-field-backpack-images/Clove-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'clove-field-backpack-edition-2-28', 1, 1
FROM products WHERE slug = 'clove-field-backpack-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/clove-field-backpack-images/Clove-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'clove-field-backpack-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'clove-field-backpack-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/khaki-beige-field-backpack-images/Khaki-Beige-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'khaki-beige-field-backpack-edition-2-29', 1, 1
FROM products WHERE slug = 'khaki-beige-field-backpack-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/khaki-beige-field-backpack-images/Khaki-Beige-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-field-backpack-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-field-backpack-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/crimson-red-field-backpack-images/Crimson-Red-Field-Backpack-vw.png?tr=cm-pad_resize,v-3', 'crimson-red-field-backpack-edition-2-30', 1, 1
FROM products WHERE slug = 'crimson-red-field-backpack-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1201/crimson-red-field-backpack-images/Crimson-Red-Field-Backpack-2n.jpg?tr=cm-pad_crop,v-3', 'crimson-red-field-backpack-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'crimson-red-field-backpack-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-basalt', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-coral', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-sand', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-lagoon', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-seagrass', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-lagoon-images/Pivot-Ambit-Messenger-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-lagoon', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-lagoon-images/Pivot-Ambit-Messenger-Lagoon-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-basalt-images/Pivot-Ambit-Messenger-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-basalt', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-basalt-images/Pivot-Ambit-Messenger-Basalt-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-sand-images/Pivot-Ambit-Messenger-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-sand', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-sand-images/Pivot-Ambit-Messenger-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-seagrass-images/Pivot-Ambit-Messenger-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-seagrass', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-seagrass-images/Pivot-Ambit-Messenger-Seagrass-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-coral-images/Pivot-Ambit-Messenger-Coral.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-coral', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-coral-images/Pivot-Ambit-Messenger-Coral-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-seagrass-images/do-Pivot-Messenger-Bag-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-messenger-bag-seagrass', 1, 1
FROM products WHERE slug = 'pivot-messenger-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-seagrass-images/do-Pivot-Messenger-Bag-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-messenger-bag-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-messenger-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-sand-images/do-Pivot-Messenger-Bag-Sand.png?tr=cm-pad_resize,v-3', 'pivot-messenger-bag-sand', 1, 1
FROM products WHERE slug = 'pivot-messenger-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-sand-images/do-Pivot-Messenger-Bag-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-messenger-bag-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-messenger-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-lagoon-images/do-Pivot-Messenger-Bag-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-messenger-bag-lagoon', 1, 1
FROM products WHERE slug = 'pivot-messenger-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-lagoon-images/do-Pivot-Messenger-Bag-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-messenger-bag-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-messenger-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-basalt-images/do-Pivot-Messenger-Bag-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-messenger-bag-basalt', 1, 1
FROM products WHERE slug = 'pivot-messenger-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-basalt-images/do-Pivot-Messenger-Bag-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-messenger-bag-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-messenger-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-coral-images/do-Pivot-Messenger-Bag-Coral.png?tr=cm-pad_resize,v-3', 'pivot-messenger-bag-coral', 1, 1
FROM products WHERE slug = 'pivot-messenger-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-messenger-bag-coral-images/do-Pivot-Messenger-Bag-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-messenger-bag-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-messenger-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/commuters-everyday-pack-images/Commuters-Everyday-Pack.png?tr=cm-pad_resize,v-3', 'commuters-everyday-pack', 1, 1
FROM products WHERE slug = 'commuters-everyday-pack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/commuters-everyday-pack-images/Commuters-Everyday-Pack-2.png?tr=cm-pad_resize,v-3', 'commuters-everyday-pack detail view', 2, 0
FROM products WHERE slug = 'commuters-everyday-pack'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-coral-images/Pivot-briefPack-coral.png?tr=cm-pad_resize,v-3', 'pivot-briefpack-coral', 1, 1
FROM products WHERE slug = 'pivot-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-coral-images/Pivot-briefPack-coral-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-briefpack-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-briefpack-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-seagrass-images/Pivot-briefPack-seagrass-wv.png?tr=cm-pad_resize,v-3', 'pivot-briefpack-seagrass', 1, 1
FROM products WHERE slug = 'pivot-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-seagrass-images/Pivot-briefPack-seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-briefpack-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-briefpack-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-basalt-images/Pivot-briefPack-basalt.png?tr=cm-pad_resize,v-3', 'pivot-briefpack-basalt', 1, 1
FROM products WHERE slug = 'pivot-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-basalt-images/Pivot-briefPack-basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-briefpack-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-briefpack-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-lagoon-images/Pivot-briefPack-lagoon.png?tr=cm-pad_resize,v-3', 'pivot-briefpack-lagoon', 1, 1
FROM products WHERE slug = 'pivot-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-briefpack-lagoon-images/Pivot-briefPack-lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-briefpack-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-briefpack-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-basalt-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-basalt-images/Pivot-Meridian-Convertible-Briefpack-Basalt-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-basalt-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-basalt-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-coral-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-coral-images/Pivot-Meridian-Convertible-Briefpack-Coral-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-coral-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-coral-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-sand-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-sand-images/Pivot-Meridian-Convertible-Briefpack-Sand-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-sand-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-sand-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-lagoon-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-lagoon-images/Pivot-Meridian-Convertible-Briefpack-Lagoon-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-lagoon-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-lagoon-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-meridian-convertible-briefpack-seagrass-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-meridian-convertible-briefpack-seagrass-images/Pivot-Meridian-Convertible-Briefpack-Seagrass-9.jpg?tr=cm-pad_crop,v-3', 'pivot-meridian-convertible-briefpack-seagrass-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-meridian-convertible-briefpack-seagrass-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-lagoon-images/Pivot-Ambit-Messenger-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-lagoon-edition-2-26', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-lagoon-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-lagoon-images/Pivot-Ambit-Messenger-Lagoon-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-lagoon-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-lagoon-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-basalt-images/Pivot-Ambit-Messenger-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-basalt-edition-2-27', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-basalt-images/Pivot-Ambit-Messenger-Basalt-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-basalt-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-sand-images/Pivot-Ambit-Messenger-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-sand-edition-2-28', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-sand-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-sand-images/Pivot-Ambit-Messenger-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-sand-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-sand-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-seagrass-images/Pivot-Ambit-Messenger-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-seagrass-edition-2-29', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-seagrass-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-seagrass-images/Pivot-Ambit-Messenger-Seagrass-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-seagrass-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-seagrass-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-coral-images/Pivot-Ambit-Messenger-Coral.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-coral-edition-2-30', 1, 1
FROM products WHERE slug = 'pivot-ambit-messenger-coral-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1202/pivot-ambit-messenger-coral-images/Pivot-Ambit-Messenger-Coral-2.png?tr=cm-pad_resize,v-3', 'pivot-ambit-messenger-coral-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'pivot-ambit-messenger-coral-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-lagoon', 1, 1
FROM products WHERE slug = 'pivot-crossbody-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-seagrass', 1, 1
FROM products WHERE slug = 'pivot-crossbody-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-sand', 1, 1
FROM products WHERE slug = 'pivot-crossbody-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-coral', 1, 1
FROM products WHERE slug = 'pivot-crossbody-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-basalt', 1, 1
FROM products WHERE slug = 'pivot-crossbody-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-basalt', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-coral', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-seagrass', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-lagoon', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-sand', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/red-puft-bucket-sling-bag-images/Red-Puft-Buckets-Slings-Bagss.png?tr=cm-pad_resize,v-3', 'red-puft-bucket-sling-bag', 1, 1
FROM products WHERE slug = 'red-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/red-puft-bucket-sling-bag-images/Red-Puft-Bucket-Sling-Bagss-2.jpg?tr=cm-pad_crop,v-3', 'red-puft-bucket-sling-bag detail view', 2, 0
FROM products WHERE slug = 'red-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/colourblock-puft-bucket-sling-bag-images/Colourblock-Puft-Buckets-Slings-Bagss.png?tr=cm-pad_resize,v-3', 'colourblock-puft-bucket-sling-bag', 1, 1
FROM products WHERE slug = 'colourblock-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/colourblock-puft-bucket-sling-bag-images/Colourblock-Puft-Bucket-Sling-Bagss-2.jpg?tr=cm-pad_crop,v-3', 'colourblock-puft-bucket-sling-bag detail view', 2, 0
FROM products WHERE slug = 'colourblock-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/blue-puft-bucket-sling-bag-images/Blue-Puft-Buckets-Slings-Bagss.png?tr=cm-pad_resize,v-3', 'blue-puft-bucket-sling-bag', 1, 1
FROM products WHERE slug = 'blue-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/blue-puft-bucket-sling-bag-images/Blue-Puft-Bucket-Sling-Bagss-2.jpg?tr=cm-pad_crop,v-3', 'blue-puft-bucket-sling-bag detail view', 2, 0
FROM products WHERE slug = 'blue-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/mint-puft-bucket-sling-bag-images/Mint-Puft-Buckets-Slings-Bagss.png?tr=cm-pad_resize,v-3', 'mint-puft-bucket-sling-bag', 1, 1
FROM products WHERE slug = 'mint-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/mint-puft-bucket-sling-bag-images/Mint-Puft-Bucket-Sling-Bagss-2.jpg?tr=cm-pad_crop,v-3', 'mint-puft-bucket-sling-bag detail view', 2, 0
FROM products WHERE slug = 'mint-puft-bucket-sling-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-sand-images/do-Pivot-Sling-Bag-Sand.png?tr=cm-pad_resize,v-3', 'pivot-sling-bag-sand', 1, 1
FROM products WHERE slug = 'pivot-sling-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-sand-images/do-Pivot-Sling-Bag-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-sling-bag-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-sling-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-basalt-images/do-Pivot-Sling-Bag-basalt.png?tr=cm-pad_resize,v-3', 'pivot-sling-bag-basalt', 1, 1
FROM products WHERE slug = 'pivot-sling-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-basalt-images/do-Pivot-Sling-Bag-basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-sling-bag-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-sling-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-seagrass-images/do-Pivot-Sling-Bag-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-sling-bag-seagrass', 1, 1
FROM products WHERE slug = 'pivot-sling-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-seagrass-images/do-Pivot-Sling-Bag-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-sling-bag-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-sling-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-coral-images/do-Pivot-Sling-Bag-Coral.png?tr=cm-pad_resize,v-3', 'pivot-sling-bag-coral', 1, 1
FROM products WHERE slug = 'pivot-sling-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-coral-images/do-Pivot-Sling-Bag-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-sling-bag-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-sling-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-lagoon-images/do-Pivot-Sling-Bag-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-sling-bag-lagoon', 1, 1
FROM products WHERE slug = 'pivot-sling-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-sling-bag-lagoon-images/do-Pivot-Sling-Bag-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-sling-bag-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-sling-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/monkey-shoulder-x-do-utility-phone-sling-images/Monkey-Shoulder-x-DO-Black-Utility-Phone-Sling.png?tr=cm-pad_resize,v-3', 'monkey-shoulder-x-do-utility-phone-sling', 1, 1
FROM products WHERE slug = 'monkey-shoulder-x-do-utility-phone-sling'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/monkey-shoulder-x-do-utility-phone-sling-images/Monkey-Shoulder-x-DO-Utility-Phone-Sling-9t.jpg?tr=cm-pad_crop,v-3', 'monkey-shoulder-x-do-utility-phone-sling detail view', 2, 0
FROM products WHERE slug = 'monkey-shoulder-x-do-utility-phone-sling'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-lagoon-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-crossbody-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-lagoon-images/Pivot-Crossbody-Lagoon-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-lagoon-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-seagrass-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-crossbody-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-seagrass-images/Pivot-Crossbody-Seagrass-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-seagrass-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-sand-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-crossbody-sand-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-sand-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-sand-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-coral-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-crossbody-coral-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-coral-images/Pivot-Crossbody-Coral-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-coral-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-coral-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-crossbody-basalt-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-crossbody-basalt-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-8.jpg?tr=cm-pad_crop,v-3', 'pivot-crossbody-basalt-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-crossbody-basalt-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-basalt-edition-2-26', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-basalt-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-basalt-images/Pivot-Travel-Sling-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-basalt-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-basalt-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-coral-edition-2-27', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-coral-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-coral-images/Pivot-Travel-Sling-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-coral-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-coral-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-seagrass-edition-2-28', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-seagrass-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-seagrass-images/Pivot-Travel-Sling-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-seagrass-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-seagrass-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-lagoon-edition-2-29', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-lagoon-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-lagoon-images/Pivot-Travel-Sling-Lagoon-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-lagoon-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-lagoon-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-travel-sling-sand-edition-2-30', 1, 1
FROM products WHERE slug = 'pivot-travel-sling-sand-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-travel-sling-sand-images/Pivot-Travel-Sling-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-travel-sling-sand-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'pivot-travel-sling-sand-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/carbon-black-easy-square-pouch-images/Carbon-Black-Easy-Square-Pouch.png?tr=cm-pad_resize,v-3', 'carbon-black-easy-square-pouch', 1, 1
FROM products WHERE slug = 'carbon-black-easy-square-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/carbon-black-easy-square-pouch-images/Carbon-Black-Easy-Square-Pouch-6t.jpg?tr=cm-pad_crop,v-3', 'carbon-black-easy-square-pouch detail view', 2, 0
FROM products WHERE slug = 'carbon-black-easy-square-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-navy-blue-tiny-taxi-organiser-images/DailyObjects-Navy-Blue-Tiny-Taxi-Organiser-Small-4.png?tr=cm-pad_resize,v-3', 'navy-blue-tiny-taxi-organiser', 1, 1
FROM products WHERE slug = 'navy-blue-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-navy-blue-tiny-taxi-organiser-images/DailyObjects-Navy-Blue-Tiny-Taxi-Organiser-Small-1.jpg?tr=cm-pad_crop,v-3', 'navy-blue-tiny-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'navy-blue-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-tiny-taxi-organiser-images/DailyObjects-Crimson-Red-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'crimson-red-tiny-taxi-organiser', 1, 1
FROM products WHERE slug = 'crimson-red-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-tiny-taxi-organiser-images/DailyObjects-Crimson-Red-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'crimson-red-tiny-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'crimson-red-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-tiny-taxi-organiser-images/DailyObjects-Earthy-Beige-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'khaki-beige-tiny-taxi-organiser', 1, 1
FROM products WHERE slug = 'khaki-beige-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-tiny-taxi-organiser-images/DailyObjects-Earthy-Beige-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-tiny-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-tiny-taxi-organiser-images/DailyObjects-Mustard-Yellow-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'mustard-tiny-taxi-organiser', 1, 1
FROM products WHERE slug = 'mustard-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-tiny-taxi-organiser-images/DailyObjects-Mustard-Yellow-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'mustard-tiny-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'mustard-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-tiny-taxi-organiser-images/DailyObjects-Olive-Green-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'olive-green-tiny-taxi-organiser', 1, 1
FROM products WHERE slug = 'olive-green-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-tiny-taxi-organiser-images/DailyObjects-Olive-Green-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'olive-green-tiny-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'olive-green-tiny-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-regular-taxi-organiser-images/DailyObjects-Crimson-Red-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'crimson-red-regular-taxi-organiser', 1, 1
FROM products WHERE slug = 'crimson-red-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-regular-taxi-organiser-images/DailyObjects-Crimson-Red-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'crimson-red-regular-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'crimson-red-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-forest-green-regular-taxi-organiser-images/DailyObjects-Forest-Green-Regular-Taxi-Organiser.png?tr=cm-pad_resize,v-3', 'forest-green-regular-taxi-organiser', 1, 1
FROM products WHERE slug = 'forest-green-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-forest-green-regular-taxi-organiser-images/DailyObjects-Forest-Green-Regular-Taxi-Organiser-2.jpg?tr=cm-pad_crop,v-3', 'forest-green-regular-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'forest-green-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-regular-taxi-organiser-images/DailyObjects-Earthy-Beige-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'khaki-beige-regular-taxi-organiser', 1, 1
FROM products WHERE slug = 'khaki-beige-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-regular-taxi-organiser-images/DailyObjects-Earthy-Beige-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-regular-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-regular-taxi-organiser-images/DailyObjects-Mustard-Yellow-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'mustard-regular-taxi-organiser', 1, 1
FROM products WHERE slug = 'mustard-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-regular-taxi-organiser-images/DailyObjects-Mustard-Yellow-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'mustard-regular-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'mustard-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-regular-taxi-organiser-images/DailyObjects-Olive-Green-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'olive-green-regular-taxi-organiser', 1, 1
FROM products WHERE slug = 'olive-green-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-regular-taxi-organiser-images/DailyObjects-Olive-Green-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'olive-green-regular-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'olive-green-regular-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-jumbo-taxi-organiser-images/DailyObjects-Crimson-Red-Jumbo-Taxi-Organiser-Large.png?tr=cm-pad_resize,v-3', 'crimson-red-jumbo-taxi-organiser', 1, 1
FROM products WHERE slug = 'crimson-red-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-jumbo-taxi-organiser-images/DailyObjects-Crimson-Red-Jumbo-Taxi-Organiser-Large-2.jpg?tr=cm-pad_crop,v-3', 'crimson-red-jumbo-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'crimson-red-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-jumbo-taxi-organiser-images/DailyObjects-Earthy-Beige-Jumbo-Taxi-Organiser-Large.png?tr=cm-pad_resize,v-3', 'khaki-beige-jumbo-taxi-organiser', 1, 1
FROM products WHERE slug = 'khaki-beige-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-jumbo-taxi-organiser-images/DailyObjects-Earthy-Beige-Jumbo-Taxi-Organiser-Large-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-jumbo-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-jumbo-taxi-organiser-images/DailyObjects-Mustard-Yellow-Jumbo-Taxi-Organiser-Large.png?tr=cm-pad_resize,v-3', 'mustard-yellow-jumbo-taxi-organiser', 1, 1
FROM products WHERE slug = 'mustard-yellow-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-jumbo-taxi-organiser-images/DailyObjects-Mustard-Yellow-Jumbo-Taxi-Organiser-Large-2.jpg?tr=cm-pad_crop,v-3', 'mustard-yellow-jumbo-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'mustard-yellow-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/9503/dailyobjects-navy-blue-jumbo-taxi-organiser-images/DailyObjects-Navy-Blue-Jumbo-Taxi-Organiser-Large-3.png?tr=cm-pad_resize,v-3', 'navy-blue-jumbo-taxi-organiser', 1, 1
FROM products WHERE slug = 'navy-blue-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/9503/dailyobjects-navy-blue-jumbo-taxi-organiser-images/DailyObjects-Navy-Blue-Jumbo-Taxi-Organiser-Large-2.jpg?tr=cm-pad_crop,v-3', 'navy-blue-jumbo-taxi-organiser detail view', 2, 0
FROM products WHERE slug = 'navy-blue-jumbo-taxi-organiser'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/colourblock-puft-pouch-images/Colourblock-Pufts-Pouchs.png?tr=cm-pad_resize,v-3', 'colourblock-puft-pouch', 1, 1
FROM products WHERE slug = 'colourblock-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/colourblock-puft-pouch-images/Colourblock-Puft-Pouchss-2.jpg?tr=cm-pad_crop,v-3', 'colourblock-puft-pouch detail view', 2, 0
FROM products WHERE slug = 'colourblock-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/mint-puft-pouch-images/Mint-Pufts-Pouchs.png?tr=cm-pad_resize,v-3', 'mint-puft-pouch', 1, 1
FROM products WHERE slug = 'mint-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/mint-puft-pouch-images/Mint-Puft-Pouchss-2.jpg?tr=cm-pad_crop,v-3', 'mint-puft-pouch detail view', 2, 0
FROM products WHERE slug = 'mint-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/yellow-puft-pouch-images/Yellow-Pufts-Pouchs.png?tr=cm-pad_resize,v-3', 'yellow-puft-pouch', 1, 1
FROM products WHERE slug = 'yellow-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/yellow-puft-pouch-images/Yellow-Puft-Pouchss-2.jpg?tr=cm-pad_crop,v-3', 'yellow-puft-pouch detail view', 2, 0
FROM products WHERE slug = 'yellow-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/blue-puft-pouch-images/Blue-Pufts-Pouchs.png?tr=cm-pad_resize,v-3', 'blue-puft-pouch', 1, 1
FROM products WHERE slug = 'blue-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/blue-puft-pouch-images/Blue-Puft-Pouchss-2.jpg?tr=cm-pad_crop,v-3', 'blue-puft-pouch detail view', 2, 0
FROM products WHERE slug = 'blue-puft-pouch'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/coral-pivot-carry-all-pouch-large-images/do-Coral-Pivot-carry-All-Pouch-Large.png?tr=cm-pad_resize,v-3', 'coral-pivot-carry-all-pouch-large', 1, 1
FROM products WHERE slug = 'coral-pivot-carry-all-pouch-large'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/coral-pivot-carry-all-pouch-large-images/do-Coral-Pivot-carry-All-Pouch-Large-2.jpg?tr=cm-pad_crop,v-3', 'coral-pivot-carry-all-pouch-large detail view', 2, 0
FROM products WHERE slug = 'coral-pivot-carry-all-pouch-large'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/carbon-black-easy-square-pouch-images/Carbon-Black-Easy-Square-Pouch.png?tr=cm-pad_resize,v-3', 'carbon-black-easy-square-pouch-edition-2-21', 1, 1
FROM products WHERE slug = 'carbon-black-easy-square-pouch-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/carbon-black-easy-square-pouch-images/Carbon-Black-Easy-Square-Pouch-6t.jpg?tr=cm-pad_crop,v-3', 'carbon-black-easy-square-pouch-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'carbon-black-easy-square-pouch-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-navy-blue-tiny-taxi-organiser-images/DailyObjects-Navy-Blue-Tiny-Taxi-Organiser-Small-4.png?tr=cm-pad_resize,v-3', 'navy-blue-tiny-taxi-organiser-edition-2-22', 1, 1
FROM products WHERE slug = 'navy-blue-tiny-taxi-organiser-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-navy-blue-tiny-taxi-organiser-images/DailyObjects-Navy-Blue-Tiny-Taxi-Organiser-Small-1.jpg?tr=cm-pad_crop,v-3', 'navy-blue-tiny-taxi-organiser-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'navy-blue-tiny-taxi-organiser-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-tiny-taxi-organiser-images/DailyObjects-Crimson-Red-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'crimson-red-tiny-taxi-organiser-edition-2-23', 1, 1
FROM products WHERE slug = 'crimson-red-tiny-taxi-organiser-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-tiny-taxi-organiser-images/DailyObjects-Crimson-Red-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'crimson-red-tiny-taxi-organiser-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'crimson-red-tiny-taxi-organiser-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-tiny-taxi-organiser-images/DailyObjects-Earthy-Beige-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'khaki-beige-tiny-taxi-organiser-edition-2-24', 1, 1
FROM products WHERE slug = 'khaki-beige-tiny-taxi-organiser-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-tiny-taxi-organiser-images/DailyObjects-Earthy-Beige-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-tiny-taxi-organiser-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-tiny-taxi-organiser-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-tiny-taxi-organiser-images/DailyObjects-Mustard-Yellow-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'mustard-tiny-taxi-organiser-edition-2-25', 1, 1
FROM products WHERE slug = 'mustard-tiny-taxi-organiser-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-tiny-taxi-organiser-images/DailyObjects-Mustard-Yellow-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'mustard-tiny-taxi-organiser-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'mustard-tiny-taxi-organiser-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-tiny-taxi-organiser-images/DailyObjects-Olive-Green-Tiny-Taxi-Organiser-Small.png?tr=cm-pad_resize,v-3', 'olive-green-tiny-taxi-organiser-edition-2-26', 1, 1
FROM products WHERE slug = 'olive-green-tiny-taxi-organiser-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-olive-green-tiny-taxi-organiser-images/DailyObjects-Olive-Green-Tiny-Taxi-Organiser-Small-2.jpg?tr=cm-pad_crop,v-3', 'olive-green-tiny-taxi-organiser-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'olive-green-tiny-taxi-organiser-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-regular-taxi-organiser-images/DailyObjects-Crimson-Red-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'crimson-red-regular-taxi-organiser-edition-2-27', 1, 1
FROM products WHERE slug = 'crimson-red-regular-taxi-organiser-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-crimson-red-regular-taxi-organiser-images/DailyObjects-Crimson-Red-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'crimson-red-regular-taxi-organiser-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'crimson-red-regular-taxi-organiser-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-forest-green-regular-taxi-organiser-images/DailyObjects-Forest-Green-Regular-Taxi-Organiser.png?tr=cm-pad_resize,v-3', 'forest-green-regular-taxi-organiser-edition-2-28', 1, 1
FROM products WHERE slug = 'forest-green-regular-taxi-organiser-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1703/dailyobjects-forest-green-regular-taxi-organiser-images/DailyObjects-Forest-Green-Regular-Taxi-Organiser-2.jpg?tr=cm-pad_crop,v-3', 'forest-green-regular-taxi-organiser-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'forest-green-regular-taxi-organiser-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-regular-taxi-organiser-images/DailyObjects-Earthy-Beige-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'khaki-beige-regular-taxi-organiser-edition-2-29', 1, 1
FROM products WHERE slug = 'khaki-beige-regular-taxi-organiser-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-khaki-beige-regular-taxi-organiser-images/DailyObjects-Earthy-Beige-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-regular-taxi-organiser-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-regular-taxi-organiser-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-regular-taxi-organiser-images/DailyObjects-Mustard-Yellow-Regular-Taxi-Organiser-Medium.png?tr=cm-pad_resize,v-3', 'mustard-regular-taxi-organiser-edition-2-30', 1, 1
FROM products WHERE slug = 'mustard-regular-taxi-organiser-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1301/dailyobjects-mustard-yellow-regular-taxi-organiser-images/DailyObjects-Mustard-Yellow-Regular-Taxi-Organiser-Medium-2.jpg?tr=cm-pad_crop,v-3', 'mustard-regular-taxi-organiser-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'mustard-regular-taxi-organiser-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand', 1, 1
FROM products WHERE slug = 'pivot-duffle-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral', 1, 1
FROM products WHERE slug = 'pivot-duffle-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon', 1, 1
FROM products WHERE slug = 'pivot-duffle-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass', 1, 1
FROM products WHERE slug = 'pivot-duffle-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-weekender-lagoon', 1, 1
FROM products WHERE slug = 'pivot-weekender-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-weekender-seagrass', 1, 1
FROM products WHERE slug = 'pivot-weekender-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand.png?tr=cm-pad_resize,v-3', 'pivot-weekender-sand', 1, 1
FROM products WHERE slug = 'pivot-weekender-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral.png?tr=cm-pad_resize,v-3', 'pivot-weekender-coral', 1, 1
FROM products WHERE slug = 'pivot-weekender-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-weekender-basalt', 1, 1
FROM products WHERE slug = 'pivot-weekender-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'olive-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'olive-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'olive-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'olive-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'navy-field-duffle-bag', 1, 1
FROM products WHERE slug = 'navy-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'navy-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mustard-field-duffle-bag', 1, 1
FROM products WHERE slug = 'mustard-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mustard-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'mustard-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mint-green-field-duffle-bag-images/Mint-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mint-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'mint-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mint-green-field-duffle-bag-images/Mint-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mint-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'mint-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/khaki-beige-field-duffle-bag-images/Khaki-Beige-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'khaki-beige-field-duffle-bag', 1, 1
FROM products WHERE slug = 'khaki-beige-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/khaki-beige-field-duffle-bag-images/Khaki-Beige-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/forest-green-field-duffle-bag-images/Forest-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'forest-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'forest-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/forest-green-field-duffle-bag-images/Forest-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'forest-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'forest-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/crimson-red-field-duffle-bag-images/Crimson-Red-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'crimson-red-field-duffle-bag', 1, 1
FROM products WHERE slug = 'crimson-red-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/crimson-red-field-duffle-bag-images/Crimson-Red-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'crimson-red-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'crimson-red-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/clove-field-duffle-bag-images/Clove-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'clove-field-duffle-bag', 1, 1
FROM products WHERE slug = 'clove-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/clove-field-duffle-bag-images/Clove-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'clove-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'clove-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-basalt-images/Pivot-Duffle-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-basalt', 1, 1
FROM products WHERE slug = 'pivot-duffle-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-basalt-images/Pivot-Duffle-Basalt-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand-edition-2-19', 1, 1
FROM products WHERE slug = 'pivot-duffle-sand-edition-2-19'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand-edition-2-19 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-sand-edition-2-19'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral-edition-2-20', 1, 1
FROM products WHERE slug = 'pivot-duffle-coral-edition-2-20'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral-edition-2-20 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-coral-edition-2-20'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-duffle-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-duffle-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-weekender-lagoon-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-weekender-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-lagoon-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-weekender-seagrass-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-weekender-seagrass-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-seagrass-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-seagrass-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand.png?tr=cm-pad_resize,v-3', 'pivot-weekender-sand-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-weekender-sand-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-sand-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-sand-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral.png?tr=cm-pad_resize,v-3', 'pivot-weekender-coral-edition-2-26', 1, 1
FROM products WHERE slug = 'pivot-weekender-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-coral-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-weekender-basalt-edition-2-27', 1, 1
FROM products WHERE slug = 'pivot-weekender-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-basalt-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'olive-green-field-duffle-bag-edition-2-28', 1, 1
FROM products WHERE slug = 'olive-green-field-duffle-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'olive-green-field-duffle-bag-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'olive-green-field-duffle-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'navy-field-duffle-bag-edition-2-29', 1, 1
FROM products WHERE slug = 'navy-field-duffle-bag-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-duffle-bag-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'navy-field-duffle-bag-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mustard-field-duffle-bag-edition-2-30', 1, 1
FROM products WHERE slug = 'mustard-field-duffle-bag-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mustard-field-duffle-bag-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'mustard-field-duffle-bag-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand', 1, 1
FROM products WHERE slug = 'pivot-duffle-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral', 1, 1
FROM products WHERE slug = 'pivot-duffle-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon', 1, 1
FROM products WHERE slug = 'pivot-duffle-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass', 1, 1
FROM products WHERE slug = 'pivot-duffle-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-weekender-lagoon', 1, 1
FROM products WHERE slug = 'pivot-weekender-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-weekender-seagrass', 1, 1
FROM products WHERE slug = 'pivot-weekender-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand.png?tr=cm-pad_resize,v-3', 'pivot-weekender-sand', 1, 1
FROM products WHERE slug = 'pivot-weekender-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral.png?tr=cm-pad_resize,v-3', 'pivot-weekender-coral', 1, 1
FROM products WHERE slug = 'pivot-weekender-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-weekender-basalt', 1, 1
FROM products WHERE slug = 'pivot-weekender-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'olive-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'olive-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'olive-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'olive-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'navy-field-duffle-bag', 1, 1
FROM products WHERE slug = 'navy-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'navy-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mustard-field-duffle-bag', 1, 1
FROM products WHERE slug = 'mustard-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mustard-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'mustard-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mint-green-field-duffle-bag-images/Mint-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mint-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'mint-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mint-green-field-duffle-bag-images/Mint-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mint-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'mint-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/khaki-beige-field-duffle-bag-images/Khaki-Beige-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'khaki-beige-field-duffle-bag', 1, 1
FROM products WHERE slug = 'khaki-beige-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/khaki-beige-field-duffle-bag-images/Khaki-Beige-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'khaki-beige-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'khaki-beige-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/forest-green-field-duffle-bag-images/Forest-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'forest-green-field-duffle-bag', 1, 1
FROM products WHERE slug = 'forest-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/forest-green-field-duffle-bag-images/Forest-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'forest-green-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'forest-green-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/crimson-red-field-duffle-bag-images/Crimson-Red-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'crimson-red-field-duffle-bag', 1, 1
FROM products WHERE slug = 'crimson-red-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/crimson-red-field-duffle-bag-images/Crimson-Red-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'crimson-red-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'crimson-red-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/clove-field-duffle-bag-images/Clove-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'clove-field-duffle-bag', 1, 1
FROM products WHERE slug = 'clove-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/clove-field-duffle-bag-images/Clove-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'clove-field-duffle-bag detail view', 2, 0
FROM products WHERE slug = 'clove-field-duffle-bag'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-basalt-images/Pivot-Duffle-Basalt-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-basalt', 1, 1
FROM products WHERE slug = 'pivot-duffle-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-basalt-images/Pivot-Duffle-Basalt-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand-edition-2-19', 1, 1
FROM products WHERE slug = 'pivot-duffle-sand-edition-2-19'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-sand-images/Pivot-Duffle-Sand-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-sand-edition-2-19 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-sand-edition-2-19'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral-edition-2-20', 1, 1
FROM products WHERE slug = 'pivot-duffle-coral-edition-2-20'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-coral-images/Pivot-Duffle-Coral-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-coral-edition-2-20 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-coral-edition-2-20'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-duffle-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-lagoon-images/Pivot-Duffle-Lagoon-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-lagoon-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-lagoon-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-vw.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-duffle-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-duffle-seagrass-images/Pivot-Duffle-Seagrass-2n.png?tr=cm-pad_resize,v-3', 'pivot-duffle-seagrass-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-duffle-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-weekender-lagoon-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-weekender-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-lagoon-images/do-Pivot-Weekender-Lagoon-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-lagoon-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-weekender-seagrass-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-weekender-seagrass-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-seagrass-images/do-Pivot-Weekender-Seagrass-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-seagrass-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-seagrass-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand.png?tr=cm-pad_resize,v-3', 'pivot-weekender-sand-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-weekender-sand-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-sand-images/do-Pivot-Weekender-Sand-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-sand-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-sand-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral.png?tr=cm-pad_resize,v-3', 'pivot-weekender-coral-edition-2-26', 1, 1
FROM products WHERE slug = 'pivot-weekender-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-coral-images/do-Pivot-Weekender-Coral-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-coral-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-coral-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-weekender-basalt-edition-2-27', 1, 1
FROM products WHERE slug = 'pivot-weekender-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/pivot-weekender-basalt-images/do-Pivot-Weekender-Basalt-2.jpg?tr=cm-pad_crop,v-3', 'pivot-weekender-basalt-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'pivot-weekender-basalt-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'olive-green-field-duffle-bag-edition-2-28', 1, 1
FROM products WHERE slug = 'olive-green-field-duffle-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/olive-green-field-duffle-bag-images/Olive-Green-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'olive-green-field-duffle-bag-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'olive-green-field-duffle-bag-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'navy-field-duffle-bag-edition-2-29', 1, 1
FROM products WHERE slug = 'navy-field-duffle-bag-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/navy-field-duffle-bag-images/Navy-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'navy-field-duffle-bag-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'navy-field-duffle-bag-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-vw.png?tr=cm-pad_resize,v-3', 'mustard-field-duffle-bag-edition-2-30', 1, 1
FROM products WHERE slug = 'mustard-field-duffle-bag-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1205/mustard-field-duffle-bag-images/Mustard-Field-Duffle-Bag-2n.jpg?tr=cm-pad_crop,v-3', 'mustard-field-duffle-bag-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'mustard-field-duffle-bag-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-coral-images/Pivot-Micro-Bag-Coral.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-coral', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-coral-images/Pivot-Micro-Bag-Coral-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-coral detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-coral'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-seagrass-images/Pivot-Micro-Bag-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-seagrass', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-seagrass-images/Pivot-Micro-Bag-Seagrass-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-seagrass detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-seagrass'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-lagoon-images/Pivot-Micro-Bag-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-lagoon', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-lagoon-images/Pivot-Micro-Bag-Lagoon-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-lagoon detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-lagoon'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-sand-images/Pivot-Micro-Bag-Sand.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-sand', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-sand-images/Pivot-Micro-Bag-Sand-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-sand detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-sand'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-basalt-images/Pivot-Micro-Bag-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-basalt', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-basalt-images/Pivot-Micro-Bag-Basalt-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-basalt detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-basalt'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-bouquet-charm-images/Puft-Bouquet-Charm.png?tr=cm-pad_resize,v-3', 'puft-bouquet-charm', 1, 1
FROM products WHERE slug = 'puft-bouquet-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-bouquet-charm-images/Puft-Bouquet-Charm-3.jpg?tr=cm-pad_crop,v-3', 'puft-bouquet-charm detail view', 2, 0
FROM products WHERE slug = 'puft-bouquet-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-heart-to-heart-charm-images/Puft-Heart-to-Heart-Charm.png?tr=cm-pad_resize,v-3', 'puft-heart-to-heart-charm', 1, 1
FROM products WHERE slug = 'puft-heart-to-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-heart-to-heart-charm-images/Puft-Heart-to-Heart-Charm-3.jpg?tr=cm-pad_crop,v-3', 'puft-heart-to-heart-charm detail view', 2, 0
FROM products WHERE slug = 'puft-heart-to-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pixel-eyes-enamel-pin-images/Pixel-Eyes-enamel-Pin-1.png?tr=cm-pad_resize,v-3', 'pixel-eyes-enamel-pin', 1, 1
FROM products WHERE slug = 'pixel-eyes-enamel-pin'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pixel-eyes-enamel-pin-images/Pixel-Eyes-enamel-Pin-2.jpg?tr=cm-pad_crop,v-3', 'pixel-eyes-enamel-pin detail view', 2, 0
FROM products WHERE slug = 'pixel-eyes-enamel-pin'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-wishing-star-charm-images/Candy-Cane-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-wishing-star-charm', 1, 1
FROM products WHERE slug = 'candy-cane-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-wishing-star-charm-images/Candy-Cane-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-wishing-star-charm detail view', 2, 0
FROM products WHERE slug = 'candy-cane-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/yellow-puft-wishing-star-charm-images/Yellow-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'yellow-puft-wishing-star-charm', 1, 1
FROM products WHERE slug = 'yellow-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/yellow-puft-wishing-star-charm-images/Yellow-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'yellow-puft-wishing-star-charm detail view', 2, 0
FROM products WHERE slug = 'yellow-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-wishing-star-charm-images/Periwinkle-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-wishing-star-charm', 1, 1
FROM products WHERE slug = 'periwinkle-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-wishing-star-charm-images/Periwinkle-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-wishing-star-charm detail view', 2, 0
FROM products WHERE slug = 'periwinkle-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-holly-heart-charm-images/Periwinkle-Puft-Holly-Heart-Charm.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-holly-heart-charm', 1, 1
FROM products WHERE slug = 'periwinkle-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-holly-heart-charm-images/Periwinkle-Puft-Holly-Heart-Charm-2.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-holly-heart-charm detail view', 2, 0
FROM products WHERE slug = 'periwinkle-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-wishing-star-charm-images/Mint-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'mint-puft-wishing-star-charm', 1, 1
FROM products WHERE slug = 'mint-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-wishing-star-charm-images/Mint-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'mint-puft-wishing-star-charm detail view', 2, 0
FROM products WHERE slug = 'mint-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-holly-heart-charm-images/Candy-Cane-Puft-Holly-Heart-Charm.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-holly-heart-charm', 1, 1
FROM products WHERE slug = 'candy-cane-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-holly-heart-charm-images/Candy-Cane-Puft-Holly-Heart-Charm-2.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-holly-heart-charm detail view', 2, 0
FROM products WHERE slug = 'candy-cane-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-christmas-tree-charm-images/Candy-Cane-Puft-Christmas-Tree-Charm.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-christmas-tree-charm', 1, 1
FROM products WHERE slug = 'candy-cane-puft-christmas-tree-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-christmas-tree-charm-images/Candy-Cane-Puft-Christmas-Tree-Charm-2.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-christmas-tree-charm detail view', 2, 0
FROM products WHERE slug = 'candy-cane-puft-christmas-tree-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-holly-heart-charm-images/Mint-Puft-Holly-Heart-Charm.png?tr=cm-pad_resize,v-3', 'mint-puft-holly-heart-charm', 1, 1
FROM products WHERE slug = 'mint-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-holly-heart-charm-images/Mint-Puft-Holly-Heart-Charm-2.png?tr=cm-pad_resize,v-3', 'mint-puft-holly-heart-charm detail view', 2, 0
FROM products WHERE slug = 'mint-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/evergreen-puft-wishing-star-charm-images/Evergreen-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'evergreen-puft-wishing-star-charm', 1, 1
FROM products WHERE slug = 'evergreen-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/evergreen-puft-wishing-star-charm-images/Evergreen-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'evergreen-puft-wishing-star-charm detail view', 2, 0
FROM products WHERE slug = 'evergreen-puft-wishing-star-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/evergreen-puft-holly-heart-charm-images/Evergreen-Puft-Holly-Heart-Charm.png?tr=cm-pad_resize,v-3', 'evergreen-puft-holly-heart-charm', 1, 1
FROM products WHERE slug = 'evergreen-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/evergreen-puft-holly-heart-charm-images/Evergreen-Puft-Holly-Heart-Charm-2.png?tr=cm-pad_resize,v-3', 'evergreen-puft-holly-heart-charm detail view', 2, 0
FROM products WHERE slug = 'evergreen-puft-holly-heart-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-fortune-fish-charm-images/Mint-Puft-Fortune-Fish-Charm.png?tr=cm-pad_resize,v-3', 'mint-puft-fortune-fish-charm', 1, 1
FROM products WHERE slug = 'mint-puft-fortune-fish-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/mint-puft-fortune-fish-charm-images/Mint-Puft-Fortune-Fish-Charm-2.png?tr=cm-pad_resize,v-3', 'mint-puft-fortune-fish-charm detail view', 2, 0
FROM products WHERE slug = 'mint-puft-fortune-fish-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-christmas-tree-charm-images/Periwinkle-Puft-Christmas-Tree-Charm.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-christmas-tree-charm', 1, 1
FROM products WHERE slug = 'periwinkle-puft-christmas-tree-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/periwinkle-puft-christmas-tree-charm-images/Periwinkle-Puft-Christmas-Tree-Charm-2.png?tr=cm-pad_resize,v-3', 'periwinkle-puft-christmas-tree-charm detail view', 2, 0
FROM products WHERE slug = 'periwinkle-puft-christmas-tree-charm'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-coral-images/Pivot-Micro-Bag-Coral.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-coral-edition-2-21', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-coral-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-coral-images/Pivot-Micro-Bag-Coral-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-coral-edition-2-21 detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-coral-edition-2-21'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-seagrass-images/Pivot-Micro-Bag-Seagrass.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-seagrass-edition-2-22', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-seagrass-images/Pivot-Micro-Bag-Seagrass-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-seagrass-edition-2-22 detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-seagrass-edition-2-22'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-lagoon-images/Pivot-Micro-Bag-Lagoon.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-lagoon-edition-2-23', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-lagoon-images/Pivot-Micro-Bag-Lagoon-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-lagoon-edition-2-23 detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-lagoon-edition-2-23'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-sand-images/Pivot-Micro-Bag-Sand.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-sand-edition-2-24', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-sand-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-sand-images/Pivot-Micro-Bag-Sand-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-sand-edition-2-24 detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-sand-edition-2-24'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-basalt-images/Pivot-Micro-Bag-Basalt.png?tr=cm-pad_resize,v-3', 'pivot-micro-bag-basalt-edition-2-25', 1, 1
FROM products WHERE slug = 'pivot-micro-bag-basalt-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pivot-micro-bag-basalt-images/Pivot-Micro-Bag-Basalt-2n.jpg?tr=cm-pad_crop,v-3', 'pivot-micro-bag-basalt-edition-2-25 detail view', 2, 0
FROM products WHERE slug = 'pivot-micro-bag-basalt-edition-2-25'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-bouquet-charm-images/Puft-Bouquet-Charm.png?tr=cm-pad_resize,v-3', 'puft-bouquet-charm-edition-2-26', 1, 1
FROM products WHERE slug = 'puft-bouquet-charm-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-bouquet-charm-images/Puft-Bouquet-Charm-3.jpg?tr=cm-pad_crop,v-3', 'puft-bouquet-charm-edition-2-26 detail view', 2, 0
FROM products WHERE slug = 'puft-bouquet-charm-edition-2-26'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-heart-to-heart-charm-images/Puft-Heart-to-Heart-Charm.png?tr=cm-pad_resize,v-3', 'puft-heart-to-heart-charm-edition-2-27', 1, 1
FROM products WHERE slug = 'puft-heart-to-heart-charm-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/puft-heart-to-heart-charm-images/Puft-Heart-to-Heart-Charm-3.jpg?tr=cm-pad_crop,v-3', 'puft-heart-to-heart-charm-edition-2-27 detail view', 2, 0
FROM products WHERE slug = 'puft-heart-to-heart-charm-edition-2-27'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pixel-eyes-enamel-pin-images/Pixel-Eyes-enamel-Pin-1.png?tr=cm-pad_resize,v-3', 'pixel-eyes-enamel-pin-edition-2-28', 1, 1
FROM products WHERE slug = 'pixel-eyes-enamel-pin-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/pixel-eyes-enamel-pin-images/Pixel-Eyes-enamel-Pin-2.jpg?tr=cm-pad_crop,v-3', 'pixel-eyes-enamel-pin-edition-2-28 detail view', 2, 0
FROM products WHERE slug = 'pixel-eyes-enamel-pin-edition-2-28'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-wishing-star-charm-images/Candy-Cane-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-wishing-star-charm-edition-2-29', 1, 1
FROM products WHERE slug = 'candy-cane-puft-wishing-star-charm-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/candy-cane-puft-wishing-star-charm-images/Candy-Cane-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'candy-cane-puft-wishing-star-charm-edition-2-29 detail view', 2, 0
FROM products WHERE slug = 'candy-cane-puft-wishing-star-charm-edition-2-29'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/yellow-puft-wishing-star-charm-images/Yellow-Puft-wishing-Star-Charm.png?tr=cm-pad_resize,v-3', 'yellow-puft-wishing-star-charm-edition-2-30', 1, 1
FROM products WHERE slug = 'yellow-puft-wishing-star-charm-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), is_primary = 1;

INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1207/yellow-puft-wishing-star-charm-images/Yellow-Puft-wishing-Star-Charm-2.png?tr=cm-pad_resize,v-3', 'yellow-puft-wishing-star-charm-edition-2-30 detail view', 2, 0
FROM products WHERE slug = 'yellow-puft-wishing-star-charm-edition-2-30'
ON DUPLICATE KEY UPDATE image_url = VALUES(image_url);

-- =========================================================
-- SEED PRODUCT VARIANTS (3 Color Variants per Product)
-- =========================================================

INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)
SELECT p.id, 'Basalt Gray', 'Basalt Gray', '#45474a', 'Standard', CONCAT(p.sku, '-BST'), p.price, 15, (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)
FROM products p
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)
SELECT p.id, 'Seagrass Green', 'Seagrass Green', '#6b7d6a', 'Standard', CONCAT(p.sku, '-SGR'), p.price, 12, (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)
FROM products p
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);

INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)
SELECT p.id, 'Sand Beige', 'Sand Beige', '#c2b39b', 'Standard', CONCAT(p.sku, '-SND'), p.price, 18, (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)
FROM products p
ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);


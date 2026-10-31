import pool from '../config/db.js';
import fs from 'fs';
import path from 'path';

export const BETHANY_SEED_SQL = `
-- 1. Deactivate old non-Bethany products and categories
UPDATE products SET is_active = 0 WHERE sku NOT LIKE 'BL-%';
UPDATE categories SET is_active = 0;

-- 2. Restore and Activate Official Bethany Categories with clean Slugs & IDs
UPDATE categories SET name = 'Tote Bags', slug = 'tote-bags', description = 'Handwoven shoulder bags, totes, and everyday market carry.', sort_order = 1, is_active = 1 WHERE id = 1;
UPDATE categories SET name = 'Crossbody Bags', slug = 'crossbody-bags', description = 'Hands-free sling bags and crossbody carry for outings and travel.', sort_order = 2, is_active = 1 WHERE id = 2;
UPDATE categories SET name = 'Messenger / Laptop Bags', slug = 'messenger-laptop-bags', description = 'Padded protective laptop sleeves and work organizers.', sort_order = 3, is_active = 1 WHERE id = 4;
UPDATE categories SET name = 'Phone Bags', slug = 'phone-bags', description = 'Compact mobile pouches for phone, keys, and earphones on the go.', sort_order = 4, is_active = 1 WHERE id = 5;
UPDATE categories SET name = 'Wallets', slug = 'wallets', description = 'Coin purses, card wallets, and travel passport organizers.', sort_order = 5, is_active = 1 WHERE id = 6;
UPDATE categories SET name = 'Pouches', slug = 'pouches', description = 'Utility pouches, cosmetic vanity organizers, and wedding potlis.', sort_order = 6, is_active = 1 WHERE id = 8;
UPDATE categories SET name = 'Gifting', slug = 'gifting', description = 'Artisan gift sets and celebration bundles with meaningful social impact.', sort_order = 7, is_active = 1 WHERE id = 22;

-- Deactivate unused legacy categories like backpacks, duffle bags, tech, etc.
UPDATE categories SET is_active = 0 WHERE id IN (3, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21);
UPDATE categories SET name = 'Backpacks', slug = 'backpacks' WHERE id = 3;
UPDATE categories SET name = 'Duffle Bags', slug = 'duffle-bags' WHERE id = 7;

-- 3. Insert / Update the 12 Official Bethany Looms Products
INSERT INTO products (
    category_id, name, slug, description, short_description, sku, 
    price, mrp, discount_percentage, stock_quantity, badge, 
    is_featured, is_new_arrival, rating, review_count, is_active
)
VALUES
    -- 1. Classic Jhola Shoulder Bag
    (
        1,
        'Classic Jhola Shoulder Bag',
        'classic-jhola-shoulder-bag',
        'Handcrafted on traditional pit looms by Bethany artisans in Bapatla. Crafted from 100% pure yarn-dyed handloom cotton, this Classic Jhola features an ergonomic wide shoulder strap for effortless carry, a deep central chamber, reinforced stress points, and a natural breathable weave. Every purchase directly sustains dignified livelihoods and medical care.',
        'Perfect for Daily Errands, college, and Office.',
        'BL-JHL-001',
        999.00, 1499.00, 33.36, 45, 'BESTSELLER', 1, 1, 4.90, 68, 1
    ),

    -- 2. Cross-Body Sling Bag
    (
        2,
        'Cross-Body Sling Bag',
        'cross-body-sling-bag',
        'Compact, versatile crossbody bag tailored with durable handwoven cotton twill. Features an adjustable shoulder strap, antique brass hardware, easy-glide dual zip compartments, and an internal secure slip for keys and currency.',
        'Perfect for Travel, outings, and hands-free ease.',
        'BL-SLG-002',
        1299.00, 1899.00, 31.60, 40, 'HANDWOVEN', 1, 1, 4.85, 52, 1
    ),

    -- 3. Everyday Tote Bag
    (
        1,
        'Everyday Tote Bag',
        'everyday-tote-bag',
        'Our signature everyday carry tote handwoven with heavyweight cotton canvas. Engineered with reinforced dual handles, a dedicated padded sleeve that fits laptops up to 14 inches, and interior slip pockets for books, tumblers, and shopping finds.',
        'Perfect for Work, shopping, beach, and books.',
        'BL-TOT-003',
        1499.00, 2199.00, 31.83, 55, 'ESSENTIAL', 1, 1, 4.95, 84, 1
    ),

    -- 4. Market/Shopping Bag
    (
        1,
        'Market/Shopping Bag',
        'market-shopping-bag',
        'Eco-friendly, reusable shopping bag handwoven from unbleached natural cotton and blended golden jute fibers. Built with an expanded box gusset base that holds up to 15 kg of groceries without stretching.',
        'Perfect for Replacing Plastic carry bags.',
        'BL-MKT-004',
        699.00, 999.00, 30.03, 60, 'ECO CARRY', 1, 0, 4.80, 41, 1
    ),

    -- 5. Potli Bag
    (
        8,
        'Potli Bag',
        'potli-bag',
        'Artisanal festive potli bag adorned with hand-twisted drawstring cords and decorative brass bells. Woven with heritage motifs by elderly artisans, perfect for festive celebrations, wedding returns, and celebratory gifting.',
        'Perfect for Weddings, Festivals, and Gifting.',
        'BL-POT-005',
        899.00, 1299.00, 30.79, 50, 'FESTIVE EDIT', 1, 1, 4.92, 39, 1
    ),

    -- 6. Laptop Sleeve
    (
        4,
        'Laptop Sleeve',
        'laptop-sleeve',
        'Precision-crafted protective laptop sleeve with 8mm shock-absorbing recycled foam padding and an ultra-soft scratch-free inner lining. Finished with a heavy-duty brass zipper and water-resistant woven exterior.',
        'Padded Protection for 13-15'''' laptops.',
        'BL-SLV-006',
        1299.00, 1899.00, 31.60, 42, 'TECH SHIELD', 1, 1, 4.88, 47, 1
    ),

    -- 7. Zip Pouch / Utility Pouch
    (
        8,
        'Zip Pouch / Utility Pouch',
        'zip-pouch-utility-pouch',
        'Compact multipurpose zip organizer pouch tailored for charging cables, power banks, stationery, and daily pocket items. Sized to fit comfortably inside any backpack or tote.',
        'Perfect for Cables, stationery, and essentials.',
        'BL-PCH-007',
        599.00, 899.00, 33.37, 50, 'POPULAR', 1, 0, 4.75, 33, 1
    ),

    -- 8. Cosmetic / Makeup Pouch
    (
        8,
        'Cosmetic / Makeup Pouch',
        'cosmetic-makeup-pouch',
        'Structured vanity cosmetic pouch with a wipe-clean spill-resistant inner lining. Features a wide zip opening that stays open on bathroom counters for effortless morning routines and travel toiletry organizing.',
        'Perfect for Travel and vanity organizing.',
        'BL-COS-008',
        799.00, 1199.00, 33.36, 45, 'ORGANIZER', 1, 1, 4.83, 29, 1
    ),

    -- 9. Coin Purse & Wallet Pouch
    (
        6,
        'Coin Purse & Wallet Pouch',
        'coin-purse-wallet-pouch',
        'Palm-sized handcrafted wallet pouch with a secure brass zip closure. Designed to carry debit cards, folded cash, transit cards, coins, and loose keys comfortably without pocket bulk.',
        'Perfect for Small change, cards, and keys.',
        'BL-WL-009',
        499.00, 749.00, 33.38, 55, 'DAILY ACCESSORY', 1, 0, 4.70, 26, 1
    ),

    -- 10. Tiffin / Lunch Bag
    (
        1,
        'Tiffin / Lunch Bag',
        'tiffin-lunch-bag',
        'Box-bottom thermal-insulated lunch bag engineered to carry steel tiffin boxes, water bottles, and fruit containers upright without tipping. Water-resistant wipeable inner lining prevents leak stains.',
        'Insulated-style carry for lunch boxes.',
        'BL-LNC-010',
        899.00, 1299.00, 30.79, 48, 'OFFICE CARRY', 1, 1, 4.90, 37, 1
    ),

    -- 11. Passport & Travel Pouch
    (
        6,
        'Passport & Travel Pouch',
        'passport-travel-pouch',
        'Slim, secure travel organizer tailored with dual passport sleeves, international boarding pass compartment, pen holder, and a zipped pocket for currency notes and forex cards.',
        'Perfect for Documents, tickets, and forex.',
        'BL-PSP-011',
        999.00, 1499.00, 33.36, 40, 'TRAVEL SPECIAL', 1, 1, 4.85, 31, 1
    ),

    -- 12. Mobile Pouch
    (
        5,
        'Mobile Pouch',
        'mobile-pouch',
        'Minimalist crossbody phone pouch with a gentle magnetic snap enclosure and an easy-access card slot on the back. Sized to fit all modern smartphones with protective cases.',
        'Perfect for Phone and earphones on the go.',
        'BL-MOB-012',
        699.00, 999.00, 30.03, 50, 'QUICK ACCESS', 1, 1, 4.80, 45, 1
    )
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    short_description = VALUES(short_description),
    price = VALUES(price),
    mrp = VALUES(mrp),
    discount_percentage = VALUES(discount_percentage),
    stock_quantity = VALUES(stock_quantity),
    badge = VALUES(badge),
    is_featured = VALUES(is_featured),
    is_new_arrival = VALUES(is_new_arrival),
    is_active = 1;

-- Also explicitly sync category_ids for all 12 products
UPDATE products SET category_id = 1 WHERE sku IN ('BL-JHL-001', 'BL-TOT-003', 'BL-MKT-004', 'BL-LNC-010');
UPDATE products SET category_id = 2 WHERE sku IN ('BL-SLG-002');
UPDATE products SET category_id = 4 WHERE sku IN ('BL-SLV-006');
UPDATE products SET category_id = 5 WHERE sku IN ('BL-MOB-012');
UPDATE products SET category_id = 6 WHERE sku IN ('BL-WL-009', 'BL-PSP-011');
UPDATE products SET category_id = 8 WHERE sku IN ('BL-POT-005', 'BL-PCH-007', 'BL-COS-008');

-- 4. Clean previous images and variants for these 12 products
DELETE FROM product_images WHERE product_id IN (SELECT id FROM products WHERE sku LIKE 'BL-%');
DELETE FROM product_variants WHERE product_id IN (SELECT id FROM products WHERE sku LIKE 'BL-%');

-- 5. Insert Primary and Angle Images
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'Classic Jhola Shoulder Bag Indigo', 1, 1 FROM products WHERE sku = 'BL-JHL-001'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote-2.png?tr=cm-pad_resize,v-3', 'Classic Jhola Detail View', 2, 0 FROM products WHERE sku = 'BL-JHL-001'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 'Cross-Body Sling Bag Sand', 1, 1 FROM products WHERE sku = 'BL-SLG-002'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'Cross-Body Sling Bag Basalt', 2, 0 FROM products WHERE sku = 'BL-SLG-002'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3', 'Everyday Tote Bag Charcoal', 1, 1 FROM products WHERE sku = 'BL-TOT-003'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral.png?tr=cm-pad_resize,v-3', 'Everyday Tote Bag Coral', 2, 0 FROM products WHERE sku = 'BL-TOT-003'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'Market/Shopping Bag Natural', 1, 1 FROM products WHERE sku = 'BL-MKT-004'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/olive-green-clove-field-tote-bag-images/Olive-Green-Clove-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'Market Bag Olive View', 2, 0 FROM products WHERE sku = 'BL-MKT-004'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3', 'Potli Bag Festive Crimson', 1, 1 FROM products WHERE sku = 'BL-POT-005'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 'Potli Detail View', 2, 0 FROM products WHERE sku = 'BL-POT-005'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3', 'Laptop Sleeve Midnight', 1, 1 FROM products WHERE sku = 'BL-SLV-006'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3', 'Laptop Sleeve Detail', 2, 0 FROM products WHERE sku = 'BL-SLV-006'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3', 'Zip Pouch Utility', 1, 1 FROM products WHERE sku = 'BL-PCH-007'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 'Zip Pouch Detail', 2, 0 FROM products WHERE sku = 'BL-PCH-007'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 'Cosmetic Makeup Pouch', 1, 1 FROM products WHERE sku = 'BL-COS-008'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 'Cosmetic Pouch Detail', 2, 0 FROM products WHERE sku = 'BL-COS-008'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 'Coin Purse & Wallet Pouch', 1, 1 FROM products WHERE sku = 'BL-WL-009'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3', 'Coin Purse Detail', 2, 0 FROM products WHERE sku = 'BL-WL-009'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3', 'Tiffin Lunch Bag Slate', 1, 1 FROM products WHERE sku = 'BL-LNC-010'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1204/olive-green-clove-field-tote-bag-images/Olive-Green-Clove-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 'Tiffin Bag Detail', 2, 0 FROM products WHERE sku = 'BL-LNC-010'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 'Passport & Travel Pouch', 1, 1 FROM products WHERE sku = 'BL-PSP-011'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 'Passport Pouch Detail', 2, 0 FROM products WHERE sku = 'BL-PSP-011'

UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 'Mobile Pouch Camel', 1, 1 FROM products WHERE sku = 'BL-MOB-012'
UNION ALL
SELECT id, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 'Mobile Pouch Detail', 2, 0 FROM products WHERE sku = 'BL-MOB-012';

-- 6. Insert Multiple Color Variants with Dedicated Variant Images
INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url, is_active)
-- 1. Classic Jhola Shoulder Bag Variants
SELECT id, 'Indigo Navy Standard', 'Indigo Navy', '#1e2d4a', 'Standard', 'BL-JHL-01-IND', 999.00, 15, 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-JHL-001'
UNION ALL
SELECT id, 'Mustard Ochre Standard', 'Mustard Ochre', '#d99b26', 'Standard', 'BL-JHL-01-OCH', 999.00, 15, 'https://images.dailyobjects.com/marche/product-images/1204/yellow-puft-wishing-star-charm-images/Yellow-Puft-Wishing-Star-Charm-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-JHL-001'
UNION ALL
SELECT id, 'Raw Linen Standard', 'Raw Linen', '#ebe5d8', 'Standard', 'BL-JHL-01-LIN', 999.00, 15, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-JHL-001'

-- 2. Cross-Body Sling Bag Variants
UNION ALL
SELECT id, 'Tan Sand Sling', 'Tan Sand', '#c29b68', 'One Size', 'BL-SLG-02-SND', 1299.00, 15, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-SLG-002'
UNION ALL
SELECT id, 'Basalt Charcoal Sling', 'Basalt Charcoal', '#2b2b2b', 'One Size', 'BL-SLG-02-BST', 1299.00, 15, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-SLG-002'
UNION ALL
SELECT id, 'Terracotta Coral Sling', 'Terracotta Coral', '#c86143', 'One Size', 'BL-SLG-02-CRL', 1299.00, 10, 'https://images.dailyobjects.com/marche/product-images/1204/coral-basalt-pivot-key-tote-images/Coral-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-SLG-002'

-- 3. Everyday Tote Bag Variants
UNION ALL
SELECT id, 'Basalt Charcoal Carry', 'Basalt Charcoal', '#1f1f1f', '14-inch', 'BL-TOT-03-BST', 1499.00, 20, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-TOT-003'
UNION ALL
SELECT id, 'Coral Clay Carry', 'Coral Clay', '#d9755b', '14-inch', 'BL-TOT-03-CRL', 1499.00, 20, 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-coral-images/do-Pivot-Classic-Tote-Coral.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-TOT-003'
UNION ALL
SELECT id, 'Forest Green Carry', 'Forest Green', '#2f483c', '14-inch', 'BL-TOT-03-GRN', 1499.00, 15, 'https://images.dailyobjects.com/marche/product-images/1204/forest-green-navy-field-tote-bag-images/Forest-Green-Navy-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-TOT-003'

-- 4. Market/Shopping Bag Variants
UNION ALL
SELECT id, 'Natural Ecru Jute', 'Natural Ecru', '#f1ede2', 'Standard', 'BL-MKT-04-ECR', 699.00, 25, 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-MKT-004'
UNION ALL
SELECT id, 'Olive Earth Jute', 'Olive Earth', '#4a5c43', 'Standard', 'BL-MKT-04-OLV', 699.00, 20, 'https://images.dailyobjects.com/marche/product-images/1204/olive-green-clove-field-tote-bag-images/Olive-Green-Clove-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-MKT-004'
UNION ALL
SELECT id, 'Navy Clove Jute', 'Navy Clove', '#1e2d4a', 'Standard', 'BL-MKT-04-NVY', 699.00, 15, 'https://images.dailyobjects.com/marche/product-images/1204/slate-gray-idyll-tote-images/Slate-Gray-Idyll-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-MKT-004'

-- 5. Potli Bag Variants
UNION ALL
SELECT id, 'Crimson Red Festive', 'Crimson Red', '#991b1b', 'Standard', 'BL-POT-05-RED', 899.00, 25, 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-POT-005'
UNION ALL
SELECT id, 'Golden Ochre Festive', 'Golden Ochre', '#d99b26', 'Standard', 'BL-POT-05-GLD', 899.00, 25, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-POT-005'

-- 6. Laptop Sleeve Variants
UNION ALL
SELECT id, 'Midnight Navy 14-inch', 'Midnight Navy', '#152238', '14-inch', 'BL-SLV-06-NVY', 1299.00, 20, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-SLV-006'
UNION ALL
SELECT id, 'Slate Basalt 14-inch', 'Slate Basalt', '#2d3748', '14-inch', 'BL-SLV-06-SLT', 1299.00, 22, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-backpacks.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-SLV-006'

-- 7. Zip Pouch / Utility Pouch Variants
UNION ALL
SELECT id, 'Carbon Black Utility', 'Carbon Black', '#1a1a1a', 'Standard', 'BL-PCH-07-BLK', 599.00, 30, 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-PCH-007'
UNION ALL
SELECT id, 'Mint Green Utility', 'Mint Green', '#86efac', 'Standard', 'BL-PCH-07-MNT', 599.00, 20, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-PCH-007'

-- 8. Cosmetic / Makeup Pouch Variants
UNION ALL
SELECT id, 'Natural Linen Vanity', 'Natural Linen', '#faf5ea', 'Standard', 'BL-COS-08-LIN', 799.00, 25, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-COS-008'
UNION ALL
SELECT id, 'Coral Vanity', 'Coral', '#fb7185', 'Standard', 'BL-COS-08-CRL', 799.00, 20, 'https://images.dailyobjects.com/marche/assets/images/other/new-pouches.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-COS-008'

-- 9. Coin Purse & Wallet Pouch Variants
UNION ALL
SELECT id, 'Mustard Ochre Coin Purse', 'Mustard Ochre', '#e5ad42', 'Compact', 'BL-WL-09-OCH', 499.00, 30, 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-WL-009'
UNION ALL
SELECT id, 'Basalt Black Coin Purse', 'Basalt Black', '#171717', 'Compact', 'BL-WL-09-BLK', 499.00, 25, 'https://images.dailyobjects.com/marche/assets/images/caterogies/Charm-mini-bag-desktop-01.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-WL-009'

-- 10. Tiffin / Lunch Bag Variants
UNION ALL
SELECT id, 'Slate Navy Lunch Box', 'Slate Navy', '#1e2d4a', 'Standard', 'BL-LNC-10-NVY', 899.00, 24, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-LNC-10-NVY'
UNION ALL
SELECT id, 'Warm Sand Lunch Box', 'Warm Sand', '#c9af88', 'Standard', 'BL-LNC-10-SND', 899.00, 24, 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-LNC-010'

-- 11. Passport & Travel Pouch Variants
UNION ALL
SELECT id, 'Saddle Tan Travel', 'Saddle Tan', '#9a6237', 'Passport', 'BL-PSP-11-TAN', 999.00, 20, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-PSP-011'
UNION ALL
SELECT id, 'Deep Basalt Travel', 'Deep Basalt', '#1e1e1e', 'Passport', 'BL-PSP-11-BST', 999.00, 20, 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-PSP-011'

-- 12. Mobile Pouch Variants
UNION ALL
SELECT id, 'Tan Camel Phone Carry', 'Tan Camel', '#b8824f', 'Universal Phone', 'BL-MOB-12-CML', 699.00, 25, 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 1 FROM products WHERE sku = 'BL-MOB-012'
UNION ALL
SELECT id, 'Charcoal Basalt Phone Carry', 'Charcoal Basalt', '#222222', 'Universal Phone', 'BL-MOB-12-BST', 699.00, 25, 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-basalt-images/Pivot-Crossbody-Basalt-vw.png?tr=cm-pad_resize,v-3', 1 FROM products WHERE sku = 'BL-MOB-012';
`;

export async function runCatalogMigration() {
  console.log('🔄 Executing Bethany Looms catalog migration against connected database...');
  const statements = BETHANY_SEED_SQL
    .replace(/--.*$/gm, '')
    .split(/;\s*[\r\n]+/)
    .map((s) => s.trim())
    .filter((s) => s.length > 0);

  let executed = 0;
  for (const stmt of statements) {
    try {
      await pool.query(stmt);
      executed++;
    } catch (err) {
      console.warn('[Migration Statement Warning]:', err.message);
    }
  }

  const [[products]] = await pool.query("SELECT COUNT(*) as count FROM products WHERE sku LIKE 'BL-%' AND is_active = 1");
  const [[variants]] = await pool.query("SELECT COUNT(*) as count FROM product_variants WHERE sku LIKE 'BL-%' AND is_active = 1");
  const [[categories]] = await pool.query("SELECT COUNT(*) as count FROM categories WHERE is_active = 1");

  console.log(`✓ Migration Complete: ${executed} statements ran. Active Bethany Products: ${products.count}, Variants: ${variants.count}, Active Categories: ${categories.count}`);
  return {
    success: true,
    statementsExecuted: executed,
    activeBethanyProducts: products.count,
    activeVariants: variants.count,
    activeCategories: categories.count
  };
}

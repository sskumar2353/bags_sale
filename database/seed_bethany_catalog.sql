-- =========================================================
-- BETHANY LOOMS OFFICIAL 12-CATEGORY PRODUCT CATALOG SEED
-- =========================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Remove all old categories so "select NAME from categories;" returns strictly the 12 categories
DELETE FROM categories WHERE id NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);

-- 2. Insert or Update the 12 Official Bethany Categories with exact names, slugs, and images
INSERT INTO categories (id, parent_id, name, slug, description, image_url, sort_order, is_active)
VALUES
    (1, NULL, 'Classic Jhola Shoulder Bag', 'classic-jhola-shoulder-bag', 'Handcrafted on traditional pit looms. Perfect for Daily Errands, college, and Office.', 'https://images.dailyobjects.com/marche/product-images/1204/space-blue-idyll-tote-images/Space-Blue-Idyll-Tote.png?tr=cm-pad_resize,v-3', 1, 1),
    (2, NULL, 'Cross-Body Sling Bag', 'cross-body-sling-bag', 'Hands-free sling bags and crossbody carry for outings and travel.', 'https://images.dailyobjects.com/marche/product-images/1811/pivot-crossbody-sand-images/Pivot-Crossbody-Sand.png?tr=cm-pad_resize,v-3', 2, 1),
    (3, NULL, 'Everyday Tote Bag', 'everyday-tote-bag', 'Signature heavyweight cotton canvas tote. Perfect for Work, shopping, beach, and books.', 'https://images.dailyobjects.com/marche/product-images/1204/pivot-classic-tote-basalt-images/do-Pivot-Classic-Tote-Basalt.png?tr=cm-pad_resize,v-3', 3, 1),
    (4, NULL, 'Market/Shopping Bag', 'market-shopping-bag', 'Eco-friendly, reusable shopping bag. Perfect for Replacing Plastic carry bags.', 'https://images.dailyobjects.com/marche/product-images/1204/ivory-crimson-red-field-tote-bag-images/Ivory-Crimson-Red-Field-Tote-Bag-vw.png?tr=cm-pad_resize,v-3', 4, 1),
    (5, NULL, 'Potli Bag', 'potli-bag', 'Artisanal festive potli bag with heritage motifs. Perfect for Weddings, Festivals, and Gifting.', 'https://images.dailyobjects.com/marche/product-images/1204/cardinal-love-idyll-tote-bag-images/Cardinal-Love-Idyll-Tote-Bag.png?tr=cm-pad_resize,v-3', 5, 1),
    (6, NULL, 'Laptop Sleeve', 'laptop-sleeve', 'Padded protective sleeve. Padded Protection for 13-15'''' laptops.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-messenger-bags.jpg?tr=cm-pad_crop,v-3', 6, 1),
    (7, NULL, 'Zip Pouch / Utility Pouch', 'zip-pouch-utility-pouch', 'Compact multipurpose zip organizer. Perfect for Cables, stationery, and essentials.', 'https://images.dailyobjects.com/marche/product-images/1204/carbon-black-idyll-tote-images/Carbon-Black-Idyll-Tote.png?tr=cm-pad_resize,v-3', 7, 1),
    (8, NULL, 'Cosmetic / Makeup Pouch', 'cosmetic-makeup-pouch', 'Structured vanity cosmetic pouch. Perfect for Travel and vanity organizing.', 'https://images.dailyobjects.com/marche/product-images/1204/sand-basalt-pivot-key-tote-images/Sand-Basalt-Pivot-Key-Tote.png?tr=cm-pad_resize,v-3', 8, 1),
    (9, NULL, 'Coin Purse & Wallet Pouch', 'coin-purse-wallet-pouch', 'Palm-sized handcrafted wallet pouch. Perfect for Small change, cards, and keys.', 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 9, 1),
    (10, NULL, 'Tiffin / Lunch Bag', 'tiffin-lunch-bag', 'Box-bottom thermal-insulated lunch bag. Insulated-style carry for lunch boxes.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-duffle-bags.jpg?tr=cm-pad_crop,v-3', 10, 1),
    (11, NULL, 'Passport & Travel Pouch', 'passport-travel-pouch', 'Slim, secure travel organizer. Perfect for Documents, tickets, and forex.', 'https://images.dailyobjects.com/marche/assets/images/other/new-wallets.jpg?tr=cm-pad_crop,v-3', 11, 1),
    (12, NULL, 'Mobile Pouch', 'mobile-pouch', 'Minimalist crossbody phone pouch. Perfect for Phone and earphones on the go.', 'https://images.dailyobjects.com/marche/assets/images/other-2/Category-page-bags-and-wallets-phone-bag.jpg?tr=cm-pad_crop,v-3', 12, 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    slug = VALUES(slug),
    description = VALUES(description),
    image_url = VALUES(image_url),
    sort_order = VALUES(sort_order),
    is_active = 1;

-- 3. Deactivate previous non-Bethany products
UPDATE products SET is_active = 0 WHERE sku NOT LIKE 'BL-%';

-- 4. Upsert the 12 Products
INSERT INTO products (
    id, category_id, name, slug, description, short_description, sku, 
    price, mrp, discount_percentage, stock_quantity, badge, 
    is_featured, is_new_arrival, rating, review_count, is_active
)
VALUES
    (
        1, 1, 'Classic Jhola Shoulder Bag', 'classic-jhola-shoulder-bag',
        'Handcrafted on traditional pit looms by Bethany artisans in Bapatla. Crafted from 100% pure yarn-dyed handloom cotton, this Classic Jhola features an ergonomic wide shoulder strap for effortless carry, a deep central chamber, reinforced stress points, and a natural breathable weave. Every purchase directly sustains dignified livelihoods and medical care.',
        'Perfect for Daily Errands, college, and Office.',
        'BL-JHL-001', 999.00, 1499.00, 33.36, 45, 'BESTSELLER', 1, 1, 4.90, 68, 1
    ),
    (
        2, 2, 'Cross-Body Sling Bag', 'cross-body-sling-bag',
        'Compact, versatile crossbody bag tailored with durable handwoven cotton twill. Features an adjustable shoulder strap, antique brass hardware, easy-glide dual zip compartments, and an internal secure slip for keys and currency.',
        'Perfect for Travel, outings, and hands-free ease.',
        'BL-SLG-002', 1299.00, 1899.00, 31.60, 40, 'HANDWOVEN', 1, 1, 4.85, 52, 1
    ),
    (
        3, 3, 'Everyday Tote Bag', 'everyday-tote-bag',
        'Our signature everyday carry tote handwoven with heavyweight cotton canvas. Engineered with reinforced dual handles, a dedicated padded sleeve that fits laptops up to 14 inches, and interior slip pockets for books, tumblers, and shopping finds.',
        'Perfect for Work, shopping, beach, and books.',
        'BL-TOT-003', 1499.00, 2199.00, 31.83, 55, 'ESSENTIAL', 1, 1, 4.95, 84, 1
    ),
    (
        4, 4, 'Market/Shopping Bag', 'market-shopping-bag',
        'Eco-friendly, reusable shopping bag handwoven from unbleached natural cotton and blended golden jute fibers. Built with an expanded box gusset base that holds up to 15 kg of groceries without stretching.',
        'Perfect for Replacing Plastic carry bags.',
        'BL-MKT-004', 699.00, 999.00, 30.03, 60, 'ECO CARRY', 1, 0, 4.80, 41, 1
    ),
    (
        5, 5, 'Potli Bag', 'potli-bag',
        'Artisanal festive potli bag adorned with hand-twisted drawstring cords and decorative brass bells. Woven with heritage motifs by elderly artisans, perfect for festive celebrations, wedding returns, and celebratory gifting.',
        'Perfect for Weddings, Festivals, and Gifting.',
        'BL-POT-005', 899.00, 1299.00, 30.79, 50, 'FESTIVE EDIT', 1, 1, 4.92, 39, 1
    ),
    (
        6, 6, 'Laptop Sleeve', 'laptop-sleeve',
        'Precision-crafted protective laptop sleeve with 8mm shock-absorbing recycled foam padding and an ultra-soft scratch-free inner lining. Finished with a heavy-duty brass zipper and water-resistant woven exterior.',
        'Padded Protection for 13-15'''' laptops.',
        'BL-SLV-006', 1299.00, 1899.00, 31.60, 42, 'TECH SHIELD', 1, 1, 4.88, 47, 1
    ),
    (
        7, 7, 'Zip Pouch / Utility Pouch', 'zip-pouch-utility-pouch',
        'Compact multipurpose zip organizer pouch tailored for charging cables, power banks, stationery, and daily pocket items. Sized to fit comfortably inside any backpack or tote.',
        'Perfect for Cables, stationery, and essentials.',
        'BL-PCH-007', 599.00, 899.00, 33.37, 50, 'POPULAR', 1, 0, 4.75, 33, 1
    ),
    (
        8, 8, 'Cosmetic / Makeup Pouch', 'cosmetic-makeup-pouch',
        'Structured vanity cosmetic pouch with a wipe-clean spill-resistant inner lining. Features a wide zip opening that stays open on bathroom counters for effortless morning routines and travel toiletry organizing.',
        'Perfect for Travel and vanity organizing.',
        'BL-COS-008', 799.00, 1199.00, 33.36, 45, 'ORGANIZER', 1, 1, 4.83, 29, 1
    ),
    (
        9, 9, 'Coin Purse & Wallet Pouch', 'coin-purse-wallet-pouch',
        'Palm-sized handcrafted wallet pouch with a secure brass zip closure. Designed to carry debit cards, folded cash, transit cards, coins, and loose keys comfortably without pocket bulk.',
        'Perfect for Small change, cards, and keys.',
        'BL-WL-009', 499.00, 749.00, 33.38, 55, 'DAILY ACCESSORY', 1, 0, 4.70, 26, 1
    ),
    (
        10, 10, 'Tiffin / Lunch Bag', 'tiffin-lunch-bag',
        'Box-bottom thermal-insulated lunch bag engineered to carry steel tiffin boxes, water bottles, and fruit containers upright without tipping. Water-resistant wipeable inner lining prevents leak stains.',
        'Insulated-style carry for lunch boxes.',
        'BL-LNC-010', 899.00, 1299.00, 30.79, 48, 'OFFICE CARRY', 1, 1, 4.90, 37, 1
    ),
    (
        11, 11, 'Passport & Travel Pouch', 'passport-travel-pouch',
        'Slim, secure travel organizer tailored with dual passport sleeves, international boarding pass compartment, pen holder, and a zipped pocket for currency notes and forex cards.',
        'Perfect for Documents, tickets, and forex.',
        'BL-PSP-011', 999.00, 1499.00, 33.36, 40, 'TRAVEL SPECIAL', 1, 1, 4.85, 31, 1
    ),
    (
        12, 12, 'Mobile Pouch', 'mobile-pouch',
        'Minimalist crossbody phone pouch with a gentle magnetic snap enclosure and an easy-access card slot on the back. Sized to fit all modern smartphones with protective cases.',
        'Perfect for Phone and earphones on the go.',
        'BL-MOB-012', 699.00, 999.00, 30.03, 50, 'QUICK ACCESS', 1, 1, 4.80, 45, 1
    )
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    slug = VALUES(slug),
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

-- Explicitly sync category_id
UPDATE products SET category_id = 1 WHERE sku = 'BL-JHL-001';
UPDATE products SET category_id = 2 WHERE sku = 'BL-SLG-002';
UPDATE products SET category_id = 3 WHERE sku = 'BL-TOT-003';
UPDATE products SET category_id = 4 WHERE sku = 'BL-MKT-004';
UPDATE products SET category_id = 5 WHERE sku = 'BL-POT-005';
UPDATE products SET category_id = 6 WHERE sku = 'BL-SLV-006';
UPDATE products SET category_id = 7 WHERE sku = 'BL-PCH-007';
UPDATE products SET category_id = 8 WHERE sku = 'BL-COS-008';
UPDATE products SET category_id = 9 WHERE sku = 'BL-WL-009';
UPDATE products SET category_id = 10 WHERE sku = 'BL-LNC-010';
UPDATE products SET category_id = 11 WHERE sku = 'BL-PSP-011';
UPDATE products SET category_id = 12 WHERE sku = 'BL-MOB-012';

SET FOREIGN_KEY_CHECKS = 1;

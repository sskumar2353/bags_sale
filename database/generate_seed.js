import fs from 'fs';
import path from 'path';

const categoriesData = [
  { slug: 'tote-bags', name: 'Tote Bags', prefix: 'TOT', startPrice: 1999, endPrice: 4499 },
  { slug: 'crossbody-bags', name: 'Crossbody Bags', prefix: 'CRS', startPrice: 1499, endPrice: 3299 },
  { slug: 'backpacks', name: 'Backpacks', prefix: 'BPK', startPrice: 2499, endPrice: 5999 },
  { slug: 'messenger-laptop-bags', name: 'Messenger / Laptop Bags', prefix: 'LAP', startPrice: 2999, endPrice: 6499 },
  { slug: 'phone-bags', name: 'Phone Bags', prefix: 'PHN', startPrice: 1199, endPrice: 2499 },
  { slug: 'wallets', name: 'Wallets', prefix: 'WLT', startPrice: 899, endPrice: 2499 },
  { slug: 'duffle-bags', name: 'Duffle Bags', prefix: 'DUF', startPrice: 2999, endPrice: 6999 },
  { slug: 'pouches', name: 'Pouches', prefix: 'PCH', startPrice: 699, endPrice: 1999 },
  { slug: 'bag-accessories', name: 'Bag Accessories', prefix: 'ACC', startPrice: 499, endPrice: 1699 }
];

const categoryProducts = {
  'tote-bags': [
    { name: 'Forma Everyday Canvas Tote', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 142 },
    { name: 'Canvas Market Tote', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 38 },
    { name: 'Sculpture Leather Tote', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 89 },
    { name: 'Studio Canvas Carryall', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 54 },
    { name: 'Arc Shopper Tote', badge: 'TRENDING', is_featured: 1, is_new: 0, rating: 4.7, reviews: 76 },
    { name: 'Urban Commuter Waxed Tote', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 43 },
    { name: 'Haven Structured Shoulder Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 29 },
    { name: 'Duo-Tone Utility Tote', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.7, reviews: 62 },
    { name: 'Minimalist Work Tote 15"', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 110 },
    { name: 'Metropolitan Zip-Top Tote', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 125 },
    { name: 'Sierra Heavyweight Organic Tote', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 31 },
    { name: 'Atlas Pocketed Field Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 48 },
    { name: 'Vista Oversized Travel Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 57 },
    { name: 'Coastline Water-Resistant Beach Tote', badge: 'SUMMER', is_featured: 0, is_new: 1, rating: 4.3, reviews: 24 },
    { name: 'Origami Foldable Canvas Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 36 },
    { name: 'Horizon Vegan Suede Tote', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.8, reviews: 71 },
    { name: 'Element Cordura Day Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 40 },
    { name: 'Prism Colorblock Canvas Tote', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.4, reviews: 19 },
    { name: 'Nomad Dual-Handle Shopper', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 52 },
    { name: 'Forma Mini Canvas Tote', badge: 'TRENDING', is_featured: 1, is_new: 0, rating: 4.7, reviews: 88 },
    { name: 'Terra Compact Shopping Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.3, reviews: 26 },
    { name: 'Latitude Zipped Commute Tote', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 65 },
    { name: 'Kanto Japanese Denim Tote', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 94 },
    { name: 'Strata Quilted Puffer Tote', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 103 },
    { name: 'Artisan Handcrafted Raw Canvas Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 34 },
    { name: 'Axis Multi-Pocket Daily Tote', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 49 },
    { name: 'Solstice Linen Blend Carryall', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 22 },
    { name: 'Echo Recycled PET Minimalist Tote', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.7, reviews: 58 },
    { name: 'Aero Ultralight Packable Tote', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 27 },
    { name: 'Signature Monogram Canvas Tote', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 160 }
  ],
  'crossbody-bags': [
    { name: 'Arc Minimalist Crossbody', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 178 },
    { name: 'Compact Saddle Sling', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 45 },
    { name: 'Sidekick Everyday Crossbody', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.7, reviews: 92 },
    { name: 'Motion Street Crossbody', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.8, reviews: 53 },
    { name: 'Orbit Half-Moon Sling', badge: 'TRENDING', is_featured: 1, is_new: 0, rating: 4.9, reviews: 134 },
    { name: 'Scout Tactical Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 61 },
    { name: 'Aero Ripstop Belt Bag', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 32 },
    { name: 'Metro Structured Box Crossbody', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.8, reviews: 84 },
    { name: 'Glide Flap Messenger Sling', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 39 },
    { name: 'Nova Quilted Phone & Card Crossbody', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.7, reviews: 77 },
    { name: 'Summit Weatherproof Chest Pack', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 48 },
    { name: 'Drift Lightweight Sling 4L', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 28 },
    { name: 'Axis Waterproof Utility Sling', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 66 },
    { name: 'Solis Leather Camera Crossbody', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 105 },
    { name: 'Pulse Active Waist & Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 35 },
    { name: 'Pivot Convertible Hip Pack', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 41 },
    { name: 'Horizon Curved Saddle Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 50 },
    { name: 'Trace Compact Travel Crossbody', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 119 },
    { name: 'Dune Micro Canvas Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.3, reviews: 21 },
    { name: 'Beacon Reflective Commute Sling', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 37 },
    { name: 'Venture Outdoor Trail Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 43 },
    { name: 'Form Factor Compact Shoulder Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 59 },
    { name: 'Kanto Modular Strap Crossbody', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 88 },
    { name: 'Haven Soft Pleated Crossbody', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.6, reviews: 33 },
    { name: 'Strata Puffer Sling Bag', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 96 },
    { name: 'Echo Eco-Nylon City Crossbody', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.5, reviews: 46 },
    { name: 'Apex Magnetic Buckle Sling', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 72 },
    { name: 'Nomad Passport Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 55 },
    { name: 'Kinetic Hands-Free Crossbody', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 29 },
    { name: 'Urban Flap Crossbody Bag', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 140 }
  ],
  'backpacks': [
    { name: 'Transit Workpack 20L', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 210 },
    { name: 'Field Notes Commuter Backpack', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 62 },
    { name: 'Metro Laptop Pack 18L', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 115 },
    { name: 'Arc Mini Daypack 12L', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.5, reviews: 39 },
    { name: 'Apex Clamshell Travel Pack 28L', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 165 },
    { name: 'Horizon Roll-Top Waterproof Pack 24L', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 83 },
    { name: 'Solis Everyday Slim Backpack 15L', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 71 },
    { name: 'Scout Heritage Canvas Rucksack 22L', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 90 },
    { name: 'Aero Ultralight Packable Backpack', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 33 },
    { name: 'Vector Tech Professional Backpack 25L', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 180 },
    { name: 'Nomad Weekender Modular Backpack 32L', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 124 },
    { name: 'Shift Dual-Compartment Backpack', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 45 },
    { name: 'Terra Heavyweight Canvas Daypack', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 52 },
    { name: 'Element Cordura Weatherproof Pack', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 68 },
    { name: 'Orbit Compact Studio Backpack', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 47 },
    { name: 'Ridge Trail Daypack 20L', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 38 },
    { name: 'Haven Leather Structured Backpack', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 98 },
    { name: 'Strata Quilted Laptop Daypack', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 112 },
    { name: 'Axis Multi-Pocket Commuter Pack', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 59 },
    { name: 'Sierra Flap Rucksack 18L', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 44 },
    { name: 'Coastline Waterproof Roll Backpack', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 53 },
    { name: 'Duo-Tone Canvas & Leather Backpack', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 67 },
    { name: 'Minimalist Flap Backpack 14"', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 41 },
    { name: 'Urban Stealth Blackout Pack 22L', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 147 },
    { name: 'Kinetic Active Fitness Backpack 20L', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 30 },
    { name: 'Artisan Waxed Canvas Rucksack', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 75 },
    { name: 'Form Factor Suspended Laptop Pack', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 86 },
    { name: 'Echo Recycled Fabric Daypack 16L', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.5, reviews: 50 },
    { name: 'Voyager Expandable Flight Backpack 35L', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 135 },
    { name: 'Signature Work Essential Backpack', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 128 }
  ],
  'messenger-laptop-bags': [
    { name: 'Dayform Laptop Satchel 15"', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 155 },
    { name: 'Nomad Tech Briefcase', badge: 'PREMIUM', is_featured: 1, is_new: 1, rating: 4.8, reviews: 82 },
    { name: 'Motion Expandable Messenger', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 49 },
    { name: 'Commuter Leather Folio 14"', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 70 },
    { name: 'Axis Professional Laptop Brief 16"', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.9, reviews: 114 },
    { name: 'Transit Cycling Messenger 18L', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 36 },
    { name: 'Haven Structured Leather Attache', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 92 },
    { name: 'Studio Padded Laptop Messenger 13"', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 58 },
    { name: 'Horizon Water-Resistant Tech Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 63 },
    { name: 'Scout Classic Canvas Messenger', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 45 },
    { name: 'Aero Ultralight Laptop Sleeve Bag', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 29 },
    { name: 'Vector Dual-Gusset Briefcase', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 130 },
    { name: 'Metro Slimline Executive Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 75 },
    { name: 'Shift Convertible Backpack-Messenger', badge: 'INNOVATION', is_featured: 1, is_new: 1, rating: 4.8, reviews: 88 },
    { name: 'Element Heavy-Duty Tech Messenger', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 52 },
    { name: 'Sierra Vintage Leather Briefcase', badge: 'HERITAGE', is_featured: 0, is_new: 0, rating: 4.8, reviews: 67 },
    { name: 'Form Factor Accordion Document Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 40 },
    { name: 'Strata Quilted Laptop Messenger 14"', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.7, reviews: 84 },
    { name: 'Solis Compact Hardware Bag 13"', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 47 },
    { name: 'Ridge Weather-Sealed Field Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 38 },
    { name: 'Atlas Double-Pocket Laptop Brief', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 59 },
    { name: 'Urban Minimalist Commute Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 61 },
    { name: 'Kanto Denim & Leather Messenger', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 78 },
    { name: 'Haven Executive Slim Briefcase', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 90 },
    { name: 'Drift Hands-Free Bike Messenger', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 31 },
    { name: 'Echo Eco-Tech Laptop Bag 15.6"', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.6, reviews: 49 },
    { name: 'Orbit Contemporary Shoulder Satchel', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 43 },
    { name: 'Artisan Hand-Stitched Leather Attache', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 104 },
    { name: 'Kinetic Transit Tech Messenger', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 55 },
    { name: 'Signature Executive Laptop Case', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 160 }
  ],
  'phone-bags': [
    { name: 'Pocket Phone Sling', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.8, reviews: 185 },
    { name: 'Luna Crossbody Phone Bag', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.6, reviews: 56 },
    { name: 'Arc Minimalist Phone Pouch', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.7, reviews: 94 },
    { name: 'Haven Magnetic Phone Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 42 },
    { name: 'Orbit Tubular Cord Phone Pouch', badge: 'TRENDING', is_featured: 1, is_new: 0, rating: 4.8, reviews: 110 },
    { name: 'Scout Rugged Utility Phone Holster', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 48 },
    { name: 'Aero Weatherproof Phone Sling', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 31 },
    { name: 'Metro Zip-Around Phone Wallet Bag', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 140 },
    { name: 'Solis Croc-Embossed Phone Pouch', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.8, reviews: 76 },
    { name: 'Horizon Cordura Mini Phone Carrier', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 37 },
    { name: 'Duo-Tone Vegan Leather Phone Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 45 },
    { name: 'Strata Puffer Quilted Phone Sling', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.9, reviews: 122 },
    { name: 'Axis Detachable Strap Phone Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 53 },
    { name: 'Sierra Handcrafted Leather Phone Case', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 64 },
    { name: 'Drift Carabiner Phone Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.3, reviews: 26 },
    { name: 'Kanto Micro Denim Phone Sling', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.8, reviews: 69 },
    { name: 'Beacon High-Vis Trail Phone Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 30 },
    { name: 'Shift Convertible Card & Phone Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 41 },
    { name: 'Haven Soft Nappa Phone Pocket', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 58 },
    { name: 'Element Armor Phone Carrying Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 39 },
    { name: 'Form Factor Double-Zip Phone Sling', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 47 },
    { name: 'Terra Canvas & Leather Phone Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 33 },
    { name: 'Pulse Sport Arm & Neck Phone Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.3, reviews: 24 },
    { name: 'Solstice Linen Mobile Crossbody', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 36 },
    { name: 'Artisan Braided Strap Phone Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 51 },
    { name: 'Echo Sustainable Fabric Phone Sling', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.6, reviews: 44 },
    { name: 'Ridge Water-Resistant Phone Carrier', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 38 },
    { name: 'Kinetic Quick-Release Mobile Sling', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 49 },
    { name: 'Urban Sleek Micro Phone Satchel', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 95 },
    { name: 'Signature Cardholder Phone Sling', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 152 }
  ],
  'wallets': [
    { name: 'City Slim Bi-Fold Wallet', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 240 },
    { name: 'Ridge Aluminum RFID Cardholder', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 165 },
    { name: 'Horizon Zip-Around Long Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 88 },
    { name: 'Orbit Minimalist Front Pocket Wallet', badge: 'NEW', is_featured: 0, is_new: 1, rating: 4.6, reviews: 42 },
    { name: 'Haven Full-Grain Leather Bi-Fold', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 130 },
    { name: 'Metro Accordion Card Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 59 },
    { name: 'Scout Rugged Tri-Fold Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 37 },
    { name: 'Aero Ultralight Dyneema Wallet', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 29 },
    { name: 'Solis Magnetic Money Clip Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 74 },
    { name: 'Transit Passport & Travel Document Wallet', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 180 },
    { name: 'Axis Dual-Currency Travel Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 53 },
    { name: 'Strata Quilted Compact Coin Wallet', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 92 },
    { name: 'Sierra Classic Vegetable Tanned Wallet', badge: 'HERITAGE', is_featured: 0, is_new: 0, rating: 4.8, reviews: 81 },
    { name: 'Duo-Tone Slim Card Sleeve', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 46 },
    { name: 'Shift Quick-Eject Card Case', badge: 'INNOVATION', is_featured: 1, is_new: 1, rating: 4.8, reviews: 110 },
    { name: 'Drift Weather-Sealed Coin & Card Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 34 },
    { name: 'Haven Gusseted Multi-Card Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 62 },
    { name: 'Form Factor Executive Bi-Fold with Coin Pocket', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 78 },
    { name: 'Element Cordura Tactical Wallet', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 39 },
    { name: 'Kanto Raw Indigo Card Case', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 71 },
    { name: 'Beacon Compact Key & Card Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.3, reviews: 28 },
    { name: 'Terra Waxed Canvas Minimalist Bi-Fold', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 50 },
    { name: 'Pulse Elastic Band Card Sleeve', badge: '', is_featured: 0, is_new: 1, rating: 4.2, reviews: 23 },
    { name: 'Artisan Stitch Grain Leather Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 65 },
    { name: 'Echo Recycled Ocean Plastic Wallet', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.5, reviews: 48 },
    { name: 'Kinetic Modular Mag-Safe Card Wallet', badge: 'TECH', is_featured: 1, is_new: 1, rating: 4.8, reviews: 105 },
    { name: 'Solstice Soft Touch Flap Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 32 },
    { name: 'Urban Ultra-Thin Carbon Fiber Wallet', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 87 },
    { name: 'Signature Monogram Zip-Around Wallet', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 145 },
    { name: 'Executive Compact Flap Cardholder', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 99 }
  ],
  'duffle-bags': [
    { name: 'Nomad Waxed Canvas Duffle 45L', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 170 },
    { name: 'Transit Gym & Travel Duffle 35L', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 135 },
    { name: 'Weekender Leather Barrel Duffle', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 110 },
    { name: 'Aero Lightweight Packable Duffle 40L', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 35 },
    { name: 'Apex Waterproof Roll-End Duffle 50L', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 78 },
    { name: 'Haven Structured Weekend Holdall', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 88 },
    { name: 'Scout Military Grade Canvas Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 54 },
    { name: 'Metro Tech Duffle with Garment Pocket', badge: 'INNOVATION', is_featured: 1, is_new: 1, rating: 4.8, reviews: 96 },
    { name: 'Horizon Heavy-Duty Tarpaulin Duffle 60L', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 62 },
    { name: 'Orbit Compact Overnight Bag 28L', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 49 },
    { name: 'Strata Quilted Puffer Travel Duffle', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 104 },
    { name: 'Element Cordura All-Weather Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 43 },
    { name: 'Solis Vegan Leather Luxury Holdall', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 76 },
    { name: 'Axis Shoe-Compartment Gym Duffle', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 148 },
    { name: 'Shift Convertible Duffle-Backpack 42L', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 68 },
    { name: 'Sierra Heritage Handcrafted Duffle', badge: 'HERITAGE', is_featured: 0, is_new: 0, rating: 4.8, reviews: 59 },
    { name: 'Drift Water-Repellent Adventure Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 37 },
    { name: 'Form Factor Structured Travel Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 65 },
    { name: 'Terra Rugged Expedition Holdall 55L', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 51 },
    { name: 'Coastline Marine Grade Waterproof Duffle', badge: '', is_featured: 0, is_new: 1, rating: 4.7, reviews: 44 },
    { name: 'Kanto Denim Weekend Travel Duffle', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 83 },
    { name: 'Beacon Reflective Overnight Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 31 },
    { name: 'Artisan Full-Grain Carry-On Duffle', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.9, reviews: 92 },
    { name: 'Pulse Active Workout Duffle 30L', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 40 },
    { name: 'Echo Sustainable Fabric Weekender 38L', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.6, reviews: 47 },
    { name: 'Urban Clean-Line Minimalist Duffle', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 55 },
    { name: 'Solstice Canvas & Suede Weekend Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 60 },
    { name: 'Ridge Double-Zip Expandable Duffle', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 36 },
    { name: 'Kinetic Multi-Pocket Sports Holdall', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 48 },
    { name: 'Signature Travel Carry-On Duffle 40L', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 162 }
  ],
  'pouches': [
    { name: 'Taxi Cable & Tech Organizer Pouch', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 220 },
    { name: 'Easy Everyday Utility Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 64 },
    { name: 'Eyewear Hard Shell Protective Case', badge: 'ESSENTIAL', is_featured: 0, is_new: 0, rating: 4.7, reviews: 95 },
    { name: 'Mod Padded Charger Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 58 },
    { name: 'Orbit Dual-Zip Cable Management Pouch', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 130 },
    { name: 'Haven Vegan Leather Cosmetic Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 72 },
    { name: 'Scout MOLLE Modular Tool Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 41 },
    { name: 'Aero Ultralight Dyneema Stash Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 30 },
    { name: 'Metro Clamshell Tech Dopp Kit', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 175 },
    { name: 'Horizon Water-Sealed Electronics Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 83 },
    { name: 'Strata Quilted Puffer Catchall Pouch', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 114 },
    { name: 'Element Ballistic Nylon Gear Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 50 },
    { name: 'Solis Structured Travel Toiletry Kit', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.8, reviews: 90 },
    { name: 'Axis Stand-Up Desk Organizer Pouch', badge: 'INNOVATION', is_featured: 1, is_new: 1, rating: 4.9, reviews: 142 },
    { name: 'Shift Accordion Electronic Accessory Case', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 76 },
    { name: 'Sierra Vintage Waxed Pencil & Pen Case', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 45 },
    { name: 'Drift Compact First-Aid & EDC Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 33 },
    { name: 'Form Factor Double-Sided Tech Organizer', badge: '', is_featured: 0, is_new: 0, rating: 4.8, reviews: 87 },
    { name: 'Terra Heavyweight Canvas Tool Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 40 },
    { name: 'Kanto Japanese Denim Pouch with Brass Zip', badge: 'LIMITED', is_featured: 1, is_new: 0, rating: 4.9, reviews: 81 },
    { name: 'Beacon High-Vis Stash Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.3, reviews: 25 },
    { name: 'Duo-Tone Flat Zipper Document Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 49 },
    { name: 'Pulse Neoprene Powerbank Pouch', badge: '', is_featured: 0, is_new: 1, rating: 4.4, reviews: 29 },
    { name: 'Artisan Stitch Leather Shaving Bag', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 66 },
    { name: 'Echo Recycled Ripstop Travel Pouch', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.6, reviews: 52 },
    { name: 'Urban Minimalist Small Catchall', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 37 },
    { name: 'Solstice Linen Blend Travel Organizer', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 34 },
    { name: 'Ridge Hard-EVA Shockproof Gadget Pouch', badge: 'TECH', is_featured: 1, is_new: 0, rating: 4.8, reviews: 108 },
    { name: 'Kinetic Quick-Reach Carabiner Pouch', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 43 },
    { name: 'Signature Monogram Canvas Zip Pouch', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 158 }
  ],
  'bag-accessories': [
    { name: 'Mini Bag Charm & Keyring', badge: 'POPULAR', is_featured: 1, is_new: 0, rating: 4.8, reviews: 140 },
    { name: 'Bloom Leather Flower Bag Charm', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.9, reviews: 180 },
    { name: 'Bow Ribbon Decorative Bag Charm', badge: 'NEW', is_featured: 1, is_new: 1, rating: 4.8, reviews: 115 },
    { name: 'Adjustable Webbing Shoulder Strap 38mm', badge: 'ESSENTIAL', is_featured: 0, is_new: 0, rating: 4.7, reviews: 98 },
    { name: 'Ergonomic Padded Shoulder Pad', badge: '', is_featured: 0, is_new: 0, rating: 4.6, reviews: 75 },
    { name: 'Brass Hardware Keychain Lanyard', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 62 },
    { name: 'Braided Leather Bag Strap Replacement', badge: 'PREMIUM', is_featured: 1, is_new: 0, rating: 4.8, reviews: 89 },
    { name: 'Modular Carabiner Clip Set (3-Pack)', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 54 },
    { name: 'Haven Leather Monogram Luggage Tag', badge: 'GIFTING', is_featured: 1, is_new: 0, rating: 4.9, reviews: 125 },
    { name: 'Orbit Quick-Release Key Tether', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 43 },
    { name: 'Scout Tactical Webbing Loop Extension', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 31 },
    { name: 'Aero Reflective Zipper Pull Set (5-Pack)', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 38 },
    { name: 'Metro Detachable Crossbody Strap with Buckle', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 67 },
    { name: 'Strata Quilted Coin Purse Bag Charm', badge: 'TRENDING', is_featured: 1, is_new: 1, rating: 4.8, reviews: 104 },
    { name: 'Solis Gold Hardware Charm Clasp', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 52 },
    { name: 'Horizon Waterproof Backpack Rain Cover 25-35L', badge: 'UTILITY', is_featured: 0, is_new: 0, rating: 4.6, reviews: 80 },
    { name: 'Axis Elastic Luggage Strap & Pass-Through', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 46 },
    { name: 'Sierra Hand-Stamped Leather Tag', badge: 'HERITAGE', is_featured: 0, is_new: 0, rating: 4.8, reviews: 63 },
    { name: 'Shift Swivel Hook Leather Strap', badge: '', is_featured: 0, is_new: 1, rating: 4.6, reviews: 41 },
    { name: 'Drift Paracord Keychain with Bottle Opener', badge: '', is_featured: 0, is_new: 0, rating: 4.4, reviews: 35 },
    { name: 'Form Factor Internal Bag Organizer Insert', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 155 },
    { name: 'Terra Waxed Canvas Strap Extension', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 29 },
    { name: 'Kanto Denim Keychain Fob', badge: 'LIMITED', is_featured: 0, is_new: 0, rating: 4.7, reviews: 48 },
    { name: 'Beacon LED Safety Clip for Bags', badge: '', is_featured: 0, is_new: 1, rating: 4.3, reviews: 26 },
    { name: 'Pulse Stretch Bottle Holder Bag Attachment', badge: '', is_featured: 0, is_new: 0, rating: 4.5, reviews: 37 },
    { name: 'Artisan Brass Monogram Keychain', badge: 'GIFTING', is_featured: 1, is_new: 0, rating: 4.9, reviews: 98 },
    { name: 'Echo Recycled Webbing Utility Strap', badge: 'ECO', is_featured: 0, is_new: 0, rating: 4.6, reviews: 45 },
    { name: 'Urban Matte Black Carabiner D-Ring Set', badge: '', is_featured: 0, is_new: 0, rating: 4.7, reviews: 59 },
    { name: 'Solstice Tassel Leather Charm', badge: '', is_featured: 0, is_new: 1, rating: 4.5, reviews: 33 },
    { name: 'Signature Lock & Key Decorative Charm', badge: 'BESTSELLER', is_featured: 1, is_new: 0, rating: 4.9, reviews: 132 }
  ]
};

function slugify(text) {
  return text
    .toString()
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-');
}

let sql = `USE daily_objects_db;\n\n`;

sql += `-- =========================================================\n`;
sql += `-- SEED CATEGORIES (Idempotent Top-Level & Subcategories)\n`;
sql += `-- =========================================================\n\n`;

sql += `INSERT INTO categories (parent_id, name, slug, description, sort_order)\nVALUES\n`;
sql += `    (NULL, 'Tote Bags', 'tote-bags', 'Everyday and work-ready tote bags.', 1),\n`;
sql += `    (NULL, 'Crossbody Bags', 'crossbody-bags', 'Compact crossbody bags for everyday carry.', 2),\n`;
sql += `    (NULL, 'Backpacks', 'backpacks', 'Backpacks for work, travel and everyday use.', 3),\n`;
sql += `    (NULL, 'Messenger / Laptop Bags', 'messenger-laptop-bags', 'Messenger and laptop bags for work and travel.', 4),\n`;
sql += `    (NULL, 'Phone Bags', 'phone-bags', 'Compact bags designed for carrying phones and essentials.', 5),\n`;
sql += `    (NULL, 'Wallets', 'wallets', 'Wallets and compact everyday organizers.', 6),\n`;
sql += `    (NULL, 'Duffle Bags', 'duffle-bags', 'Duffle bags for travel, gym and weekends.', 7),\n`;
sql += `    (NULL, 'Pouches', 'pouches', 'Compact pouches and cases for organizing essentials.', 8),\n`;
sql += `    (NULL, 'Bag Accessories', 'bag-accessories', 'Accessories and charms for bags.', 9),\n`;
sql += `    (NULL, 'Tech', 'tech', 'Tech accessories, organizers, and sleeves.', 10),\n`;
sql += `    (NULL, 'Work Essentials', 'work-essentials', 'Curated bags, folios and organizers for work.', 11),\n`;
sql += `    (NULL, 'Gifting', 'gifting', 'Curated gifts and luxury accessories.', 12)\n`;
sql += `ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), sort_order = VALUES(sort_order);\n\n`;

sql += `-- =========================================================\n`;
sql += `-- SEED USERS (Admin & Demo Customer)\n`;
sql += `-- Admin Password: Admin@123456\n`;
sql += `-- Customer Password: Customer@123456\n`;
sql += `-- =========================================================\n\n`;

sql += `INSERT INTO users (first_name, last_name, email, phone, password_hash, role, is_active)\n`;
sql += `VALUES\n`;
sql += `    ('Store', 'Administrator', 'admin@dailyobjects.example', '9876543210', '$2b$12$U6EMCBc3ZAlV45/ipRViM.Priwd89.xvz0RW8IGolZ2RD3SUoMzsi', 'admin', 1),\n`;
sql += `    ('Priya', 'Sharma', 'customer@dailyobjects.example', '9876543211', '$2b$12$TgejtsxNhg813.UbWywYNON9IogvDtdX3ct.Ee8JuBZi9p3w8qod.', 'customer', 1)\n`;
sql += `ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;\n\n`;

sql += `-- Demo Customer Address\n`;
sql += `INSERT INTO addresses (user_id, full_name, phone, address_line1, address_line2, city, state, postal_code, country, address_type, is_default)\n`;
sql += `SELECT id, 'Priya Sharma', '9876543211', 'Flat 402, Green Glen Heights', 'Outer Ring Road, Bellandur', 'Bengaluru', 'Karnataka', '560103', 'India', 'home', 1\n`;
sql += `FROM users\n`;
sql += `WHERE email = 'customer@dailyobjects.example'\n`;
sql += `ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;\n\n`;

sql += `-- =========================================================\n`;
sql += `-- SEED PRODUCTS (30 Products for Each of the 9 Categories = 270 Products Total)\n`;
sql += `-- =========================================================\n\n`;

let totalProductCount = 0;

for (const cat of categoriesData) {
  const items = categoryProducts[cat.slug] || [];
  sql += `-- ---------------------------------------------------------\n`;
  sql += `-- Category: ${cat.name} (${items.length} Products)\n`;
  sql += `-- ---------------------------------------------------------\n\n`;

  items.forEach((item, idx) => {
    totalProductCount++;
    const num = String(idx + 1).padStart(3, '0');
    const sku = `DO-${cat.prefix}-${num}`;
    const slug = slugify(item.name);
    
    // Spread prices realistically
    const step = (cat.endPrice - cat.startPrice) / 30;
    const price = Math.round((cat.startPrice + step * idx) / 50) * 50 - 1; // e.g., 1999, 2449, etc.
    const mrp = Math.round((price * 1.25) / 50) * 50 - 1; // approx 20-25% discount
    const discount = Number((((mrp - price) / mrp) * 100).toFixed(2));
    const stock = 20 + ((idx * 7) % 35); // 20 to 54 units
    
    const desc = `Engineered for modern movement and daily utility. Crafted with high-grade durable materials, reinforced stress points, water-repellent exterior coating, and thoughtful internal organization compartments tailored for your daily carry.`;
    const shortDesc = `Premium ${cat.name.toLowerCase().replace(/s$/, '')} with durable construction and smart quick-access storage.`;

    sql += `INSERT INTO products (category_id, name, slug, description, short_description, sku, price, mrp, discount_percentage, stock_quantity, badge, is_featured, is_new_arrival, rating, review_count)\n`;
    sql += `SELECT id, '${item.name.replace(/'/g, "''")}', '${slug}', '${desc.replace(/'/g, "''")}', '${shortDesc.replace(/'/g, "''")}', '${sku}', ${price.toFixed(2)}, ${mrp.toFixed(2)}, ${discount.toFixed(2)}, ${stock}, '${item.badge}', ${item.is_featured}, ${item.is_new}, ${item.rating.toFixed(2)}, ${item.reviews}\n`;
    sql += `FROM categories WHERE slug = '${cat.slug}'\n`;
    sql += `ON DUPLICATE KEY UPDATE price = VALUES(price), mrp = VALUES(mrp), stock_quantity = VALUES(stock_quantity), badge = VALUES(badge), is_featured = VALUES(is_featured), is_new_arrival = VALUES(is_new_arrival);\n\n`;
  });
}

sql += `-- =========================================================\n`;
sql += `-- SEED PRODUCT IMAGES (Primary & Secondary for All 270 Products)\n`;
sql += `-- Placeholder curated image URLs that can be updated with custom image assets\n`;
sql += `-- =========================================================\n\n`;

sql += `INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)\n`;
sql += `SELECT p.id,\n`;
sql += `  CASE (p.id % 6)\n`;
sql += `    WHEN 0 THEN 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=900&q=85'\n`;
sql += `    WHEN 1 THEN 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=900&q=85'\n`;
sql += `    WHEN 2 THEN 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'\n`;
sql += `    WHEN 3 THEN 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=900&q=85'\n`;
sql += `    WHEN 4 THEN 'https://images.unsplash.com/photo-1622560480654-d96214fdc887?auto=format&fit=crop&w=900&q=85'\n`;
sql += `    ELSE 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'\n`;
sql += `  END,\n`;
sql += `  p.name, 1, 1\n`;
sql += `FROM products p\n`;
sql += `ON DUPLICATE KEY UPDATE is_primary = VALUES(is_primary);\n\n`;

sql += `-- Secondary Detail Images\n`;
sql += `INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)\n`;
sql += `SELECT p.id,\n`;
sql += `  'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=900&q=80',\n`;
sql += `  CONCAT(p.name, ' detail view'), 2, 0\n`;
sql += `FROM products p\n`;
sql += `ON DUPLICATE KEY UPDATE is_primary = VALUES(is_primary);\n\n`;

sql += `-- =========================================================\n`;
sql += `-- SEED PRODUCT VARIANTS (3 Color Variants for Each Product)\n`;
sql += `-- =========================================================\n\n`;

sql += `-- Variant 1: Stone Beige\n`;
sql += `INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)\n`;
sql += `SELECT \n`;
sql += `  p.id, 'Stone Beige', 'Stone Beige', '#d8c7ae', 'Standard', \n`;
sql += `  CONCAT(p.sku, '-STN'), p.price, 15, \n`;
sql += `  (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)\n`;
sql += `FROM products p\n`;
sql += `ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);\n\n`;

sql += `-- Variant 2: Olive Green\n`;
sql += `INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)\n`;
sql += `SELECT \n`;
sql += `  p.id, 'Olive Green', 'Olive Green', '#778071', 'Standard', \n`;
sql += `  CONCAT(p.sku, '-OLV'), p.price, 12, \n`;
sql += `  (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)\n`;
sql += `FROM products p\n`;
sql += `ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);\n\n`;

sql += `-- Variant 3: Charcoal Black\n`;
sql += `INSERT INTO product_variants (product_id, variant_name, color_name, color_code, size, sku, price, stock_quantity, image_url)\n`;
sql += `SELECT \n`;
sql += `  p.id, 'Charcoal Black', 'Charcoal Black', '#242a31', 'Standard', \n`;
sql += `  CONCAT(p.sku, '-BLK'), p.price, 18, \n`;
sql += `  (SELECT image_url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1)\n`;
sql += `FROM products p\n`;
sql += `ON DUPLICATE KEY UPDATE stock_quantity = VALUES(stock_quantity);\n\n`;

sql += `-- =========================================================\n`;
sql += `-- VERIFICATION QUERIES (Optional Check)\n`;
sql += `-- =========================================================\n`;
sql += `-- SELECT c.name, COUNT(p.id) AS product_count FROM categories c LEFT JOIN products p ON p.category_id = c.id GROUP BY c.id;\n`;

fs.writeFileSync(path.resolve('database/seed.sql'), sql, 'utf8');
console.log(`Successfully generated seed.sql with ${totalProductCount} products across 9 categories!`);

import { Router } from 'express';
import { getProducts, getProductBySlug, getProductById } from '../controllers/productController.js';

const router = Router();

router.get('/', getProducts);
router.get('/:slug', getProductBySlug);
router.get('/id/:id', getProductById);

export default router;

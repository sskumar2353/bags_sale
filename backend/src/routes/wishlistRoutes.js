import { Router } from 'express';
import { getWishlist, addItem, removeItem } from '../controllers/wishlistController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

router.use(authMiddleware);

router.get('/', getWishlist);
router.post('/', addItem);
router.delete('/:productId', removeItem);

export default router;

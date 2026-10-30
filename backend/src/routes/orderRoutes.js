import { Router } from 'express';
import { getOrders, getOrderById } from '../controllers/orderController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

router.use(authMiddleware);

router.get('/', getOrders);
router.get('/:id', getOrderById);

export default router;

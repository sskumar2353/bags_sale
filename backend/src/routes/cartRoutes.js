import { Router } from 'express';
import {
  getCart,
  addItem,
  updateQuantity,
  removeItem,
  clearCart
} from '../controllers/cartController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

router.use(authMiddleware);

router.get('/', getCart);
router.post('/items', addItem);
router.put('/items/:id', updateQuantity);
router.delete('/items/:id', removeItem);
router.delete('/', clearCart);

export default router;

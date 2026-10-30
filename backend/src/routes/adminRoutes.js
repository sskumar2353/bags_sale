import { Router } from 'express';
import {
  getDashboardStats,
  getProducts,
  createProduct,
  updateProduct,
  deleteProduct,
  createCategory,
  updateCategory,
  getOrders,
  updateOrderStatus,
  getUsers
} from '../controllers/adminController.js';
import authMiddleware from '../middleware/authMiddleware.js';
import adminMiddleware from '../middleware/adminMiddleware.js';

const router = Router();

router.use(authMiddleware, adminMiddleware);

router.get('/dashboard', getDashboardStats);

router.get('/products', getProducts);
router.post('/products', createProduct);
router.put('/products/:id', updateProduct);
router.delete('/products/:id', deleteProduct);

router.post('/categories', createCategory);
router.put('/categories/:id', updateCategory);

router.get('/orders', getOrders);
router.put('/orders/:id/status', updateOrderStatus);

router.get('/users', getUsers);

export default router;

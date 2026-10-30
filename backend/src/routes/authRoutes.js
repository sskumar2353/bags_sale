import { Router } from 'express';
import {
  register,
  login,
  logout,
  getMe,
  forgotPassword,
  resetPassword,
  getAddresses,
  addAddress,
  deleteAddress
} from '../controllers/authController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

router.post('/register', register);
router.post('/login', login);
router.post('/logout', logout);
router.post('/forgot-password', forgotPassword);
router.post('/reset-password', resetPassword);
router.get('/me', authMiddleware, getMe);

// Address subroutes
router.get('/addresses', authMiddleware, getAddresses);
router.post('/addresses', authMiddleware, addAddress);
router.delete('/addresses/:id', authMiddleware, deleteAddress);

export default router;

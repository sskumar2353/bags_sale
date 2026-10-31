import { Router } from 'express';
import { createOrder, verifyPayment, createDonationOrder } from '../controllers/paymentController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

// Public donation order route (no auth required so any supporter can donate)
router.post('/donate', createDonationOrder);

router.use(authMiddleware);

router.post('/create-order', createOrder);
router.post('/verify', verifyPayment);

export default router;

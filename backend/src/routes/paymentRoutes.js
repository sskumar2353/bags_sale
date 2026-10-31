import { Router } from 'express';
import { createOrder, verifyPayment, createDonationOrder, validateCoupon } from '../controllers/paymentController.js';
import authMiddleware from '../middleware/authMiddleware.js';

const router = Router();

// Public routes (no auth required)
router.post('/donate', createDonationOrder);
router.post('/validate-coupon', validateCoupon);

router.use(authMiddleware);

router.post('/create-order', createOrder);
router.post('/verify', verifyPayment);

export default router;

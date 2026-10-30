import jwt from 'jsonwebtoken';

export const authMiddleware = (req, res, next) => {
  let token = null;

  // 1. Check Bearer Authorization header
  const authHeader = req.headers.authorization;
  if (authHeader && authHeader.startsWith('Bearer ')) {
    token = authHeader.substring(7).trim();
  } else if (req.cookies && (req.cookies.do_token || req.cookies.token)) {
    // 2. Check HttpOnly cookie
    token = req.cookies.do_token || req.cookies.token;
  }

  if (!token) {
    return res.status(401).json({ message: 'Authentication required. Please sign in.' });
  }

  try {
    const secret = process.env.JWT_SECRET || 'dev-secret-daily-objects-change-in-production';
    const decoded = jwt.verify(token, secret);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Invalid or expired session. Please sign in again.' });
  }
};

export default authMiddleware;

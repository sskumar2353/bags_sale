import jwt from 'jsonwebtoken';

export const generateToken = (user) => {
  const secret = process.env.JWT_SECRET;
  if (!secret) {
    if (process.env.NODE_ENV === 'production') {
      throw new Error('JWT_SECRET must be defined in production environment');
    }
  }

  const jwtSecret = secret || 'dev-secret-daily-objects-change-in-production';
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
      role: user.role
    },
    jwtSecret,
    { expiresIn: '7d' }
  );
};

export default generateToken;

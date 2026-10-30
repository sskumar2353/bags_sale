export const errorMiddleware = (err, req, res, next) => {
  console.error(`[Error] ${req.method} ${req.url}:`, err.message);

  const statusCode = res.statusCode !== 200 ? res.statusCode : 500;
  const isProduction = process.env.NODE_ENV === 'production';

  // Specific database error formatting
  if (err.code === 'ER_DUP_ENTRY') {
    return res.status(409).json({ message: 'A record with that information already exists.' });
  }

  res.status(statusCode).json({
    message: err.message || 'Internal server error occurred.',
    ...(isProduction ? {} : { stack: err.stack })
  });
};

export default errorMiddleware;

import crypto from 'node:crypto';
import bcrypt from 'bcryptjs';
import User from '../models/User.js';
import Address from '../models/Address.js';
import generateToken from '../utils/generateToken.js';

const setTokenCookie = (res, token) => {
  res.cookie('do_token', token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
    maxAge: 7 * 24 * 60 * 60 * 1000 // 7 days
  });
};

export const register = async (req, res, next) => {
  try {
    const { firstName, lastName, email, phone, password } = req.body;

    if (!firstName || !email || !password) {
      return res.status(400).json({ message: 'First name, email, and password are required.' });
    }

    if (password.length < 8) {
      return res.status(400).json({ message: 'Password must be at least 8 characters in length.' });
    }

    const normalizedEmail = email.toLowerCase().trim();
    const existing = await User.findByEmail(normalizedEmail);
    if (existing) {
      return res.status(409).json({ message: 'An account with that email already exists.' });
    }

    // Hash password with bcrypt
    const passwordHash = await bcrypt.hash(password, 12);
    const normalizedPhone = phone && phone.trim() ? phone.trim() : null;

    const userId = await User.create({
      firstName: firstName.trim(),
      lastName: lastName?.trim() || null,
      email: normalizedEmail,
      phone: normalizedPhone,
      passwordHash,
      role: 'customer'
    });

    const user = {
      id: userId,
      first_name: firstName.trim(),
      last_name: lastName?.trim() || null,
      email: normalizedEmail,
      phone: normalizedPhone,
      role: 'customer'
    };

    const token = generateToken(user);
    setTokenCookie(res, token);

    res.status(201).json({ user, token });
  } catch (err) {
    next(err);
  }
};

export const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'Please provide both email and password.' });
    }

    const user = await User.findByEmail(email);
    if (!user || !user.is_active) {
      return res.status(401).json({ message: 'Invalid email or password.' });
    }

    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid email or password.' });
    }

    const safeUser = {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      role: user.role
    };

    const token = generateToken(safeUser);
    setTokenCookie(res, token);

    res.json({ user: safeUser, token });
  } catch (err) {
    next(err);
  }
};

export const logout = async (req, res) => {
  res.clearCookie('do_token', {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax'
  });
  res.json({ message: 'Signed out successfully.' });
};

export const getMe = async (req, res, next) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user || !user.is_active) {
      return res.status(404).json({ message: 'Account not found or inactive.' });
    }
    res.json(user);
  } catch (err) {
    next(err);
  }
};

// Password Reset Flow
export const forgotPassword = async (req, res, next) => {
  try {
    const { email } = req.body;
    if (!email) {
      return res.status(400).json({ message: 'Please enter your registered email address.' });
    }

    const normalizedEmail = email.toLowerCase().trim();
    const user = await User.findByEmail(normalizedEmail);

    if (!user) {
      // Don't leak account existence, return clean success message
      return res.json({
        message: 'If an account exists with that email address, a password reset link has been generated.'
      });
    }

    // Generate secure random token
    const resetToken = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hour from now

    await User.setResetPasswordToken(normalizedEmail, resetToken, expiresAt);

    res.json({
      message: 'If an account exists with that email address, a password reset link has been generated.',
      resetToken // Returned for local testing and direct link transition
    });
  } catch (err) {
    next(err);
  }
};

export const resetPassword = async (req, res, next) => {
  try {
    const { token, newPassword } = req.body;

    if (!token || !newPassword) {
      return res.status(400).json({ message: 'Reset token and new password are required.' });
    }

    if (newPassword.length < 8) {
      return res.status(400).json({ message: 'Password must be at least 8 characters in length.' });
    }

    const user = await User.findByResetToken(token);
    if (!user) {
      return res.status(400).json({ message: 'Invalid or expired password reset link. Please request a new one.' });
    }

    const passwordHash = await bcrypt.hash(newPassword, 12);
    await User.resetPassword(user.id, passwordHash);

    res.json({ message: 'Your password has been successfully reset. You can now sign in with your new password.' });
  } catch (err) {
    next(err);
  }
};

// Address Management
export const getAddresses = async (req, res, next) => {
  try {
    const addresses = await Address.findByUserId(req.user.id);
    res.json(addresses);
  } catch (err) {
    next(err);
  }
};

export const addAddress = async (req, res, next) => {
  try {
    const {
      full_name,
      phone,
      address_line1,
      address_line2,
      city,
      state,
      postal_code,
      country,
      address_type,
      is_default
    } = req.body;

    if (!full_name || !phone || !address_line1 || !city || !state || !postal_code) {
      return res.status(400).json({ message: 'All required address fields must be provided.' });
    }

    const id = await Address.create({
      userId: req.user.id,
      fullName: full_name,
      phone,
      addressLine1: address_line1,
      addressLine2: address_line2,
      city,
      state,
      postalCode: postal_code,
      country,
      addressType: address_type,
      isDefault: is_default
    });

    const address = await Address.findById(id, req.user.id);
    res.status(201).json(address);
  } catch (err) {
    next(err);
  }
};

export const deleteAddress = async (req, res, next) => {
  try {
    await Address.delete(req.params.id, req.user.id);
    res.json({ message: 'Address removed.' });
  } catch (err) {
    next(err);
  }
};

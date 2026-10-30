import { createContext, useState, useEffect, useCallback } from 'react';
import authService from '../services/authService';

export const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    try {
      const stored = localStorage.getItem('do-user');
      return stored ? JSON.parse(stored) : null;
    } catch {
      return null;
    }
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchCurrentUser = useCallback(async () => {
    const token = localStorage.getItem('do-token');
    if (!token) {
      setUser(null);
      setLoading(false);
      return;
    }
    try {
      setLoading(true);
      const currentUser = await authService.getCurrentUser();
      setUser(currentUser);
      localStorage.setItem('do-user', JSON.stringify(currentUser));
    } catch (err) {
      console.warn('Session expired or invalid:', err.message);
      localStorage.removeItem('do-token');
      localStorage.removeItem('do-user');
      setUser(null);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCurrentUser();
  }, [fetchCurrentUser]);

  const login = async (credentials) => {
    setError(null);
    const data = await authService.login(credentials);
    if (data.token) {
      localStorage.setItem('do-token', data.token);
    }
    if (data.user) {
      localStorage.setItem('do-user', JSON.stringify(data.user));
      setUser(data.user);
    }
    return data.user;
  };

  const register = async (userData) => {
    setError(null);
    const data = await authService.register(userData);
    if (data.token) {
      localStorage.setItem('do-token', data.token);
    }
    if (data.user) {
      localStorage.setItem('do-user', JSON.stringify(data.user));
      setUser(data.user);
    }
    return data.user;
  };

  const logout = async () => {
    try {
      await authService.logout();
    } catch {
      // Ignore network errors during logout
    } finally {
      localStorage.removeItem('do-token');
      localStorage.removeItem('do-user');
      setUser(null);
    }
  };

  const value = {
    user,
    loading,
    error,
    isAuthenticated: Boolean(user),
    isAdmin: user?.role === 'admin',
    login,
    register,
    logout,
    refreshUser: fetchCurrentUser
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

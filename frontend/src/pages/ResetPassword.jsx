import { useState } from 'react';
import { useSearchParams, Link, useNavigate } from 'react-router-dom';
import authService from '../services/authService';

export default function ResetPassword() {
  const [params] = useSearchParams();
  const token = params.get('token') || '';
  const navigate = useNavigate();

  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [busy, setBusy] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!token) {
      setError('Missing or invalid reset token. Please request a new link.');
      return;
    }

    if (password.length < 8) {
      setError('Password must be at least 8 characters in length.');
      return;
    }

    if (password !== confirmPassword) {
      setError('Passwords do not match.');
      return;
    }

    setBusy(true);
    setError(null);

    try {
      await authService.resetPassword({ token, newPassword: password });
      setSuccess(true);
      setTimeout(() => {
        navigate('/login');
      }, 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <main className="page auth-page" style={{ paddingTop: '24px' }}>
      <span className="eyebrow">SECURITY</span>
      <h1>Set new password</h1>
      <p>Choose a secure password of at least 8 characters.</p>

      {success ? (
        <div style={{ background: 'var(--soft)', border: '1px solid var(--line)', borderRadius: '6px', padding: '24px', margin: '24px 0' }}>
          <h3 style={{ color: '#2e7d32', marginBottom: '8px' }}>Password Reset Complete</h3>
          <p style={{ fontSize: '14px', color: '#55574e', marginBottom: '20px' }}>
            Your password has been securely updated. Redirecting you to sign in…
          </p>
          <Link to="/login" className="button button-dark">
            Sign In Now →
          </Link>
        </div>
      ) : !token ? (
        <div className="empty">
          <h3>Invalid Password Reset Request</h3>
          <p>No valid reset token was provided in the link. Please request a new link from the forgot password page.</p>
          <Link to="/forgot-password" className="button button-dark" style={{ marginTop: '16px' }}>
            Request Reset Link
          </Link>
        </div>
      ) : (
        <form className="auth-form" onSubmit={handleSubmit}>
          <label>
            New Password (minimum 8 characters) *
            <input
              type="password"
              required
              minLength="8"
              autoComplete="new-password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter new password"
            />
          </label>

          <label>
            Confirm New Password *
            <input
              type="password"
              required
              minLength="8"
              autoComplete="new-password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder="Confirm new password"
            />
          </label>

          {error && <p className="form-error">{error}</p>}

          <button className="button button-dark full" disabled={busy}>
            {busy ? 'Updating Password…' : 'Update Password'}
          </button>
        </form>
      )}
    </main>
  );
}

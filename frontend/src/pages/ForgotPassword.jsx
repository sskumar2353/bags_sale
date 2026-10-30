import { useState } from 'react';
import { Link } from 'react-router-dom';
import authService from '../services/authService';

export default function ForgotPassword() {
  const [email, setEmail] = useState('');
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState(null);
  const [devToken, setDevToken] = useState(null);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    setMessage(null);

    try {
      const data = await authService.forgotPassword(email.trim());
      setMessage(data.message);
      if (data.resetToken) {
        setDevToken(data.resetToken);
      }
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <main className="page auth-page" style={{ paddingTop: '24px' }}>
      <span className="eyebrow">PASSWORD RECOVERY</span>
      <h1>Reset your password</h1>
      <p>Enter the email address associated with your account and we'll generate a secure reset link.</p>

      {message ? (
        <div style={{ background: 'var(--soft)', border: '1px solid var(--line)', borderRadius: '6px', padding: '24px', margin: '24px 0' }}>
          <p style={{ color: '#2e7d32', fontWeight: '500', fontSize: '15px', margin: '0 0 14px' }}>
            {message}
          </p>
          {devToken && (
            <div style={{ marginTop: '16px', padding: '12px', background: '#fff', border: '1px solid var(--line)', borderRadius: '4px' }}>
              <span style={{ fontSize: '12px', color: 'var(--muted)', display: 'block', marginBottom: '6px' }}>
                Quick Test Action (Direct Link):
              </span>
              <Link
                to={`/reset-password?token=${devToken}`}
                className="button button-dark"
                style={{ minHeight: '40px', fontSize: '13px' }}
              >
                Proceed to Reset Password Page →
              </Link>
            </div>
          )}
          <div style={{ marginTop: '20px' }}>
            <Link to="/login" className="text-link">
              ← Return to Sign In
            </Link>
          </div>
        </div>
      ) : (
        <form className="auth-form" onSubmit={handleSubmit}>
          <label>
            Registered Email Address *
            <input
              type="email"
              required
              autoComplete="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
            />
          </label>

          {error && <p className="form-error">{error}</p>}

          <button className="button button-dark full" disabled={busy}>
            {busy ? 'Verifying…' : 'Send Reset Link'}
          </button>

          <div style={{ textAlign: 'center', marginTop: '14px' }}>
            <Link to="/login" className="text-link" style={{ fontSize: '13.5px' }}>
              Remember your password? Sign in
            </Link>
          </div>
        </form>
      )}
    </main>
  );
}

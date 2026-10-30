import { useState, useEffect } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import useAuth from '../hooks/useAuth';

export default function Login() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  const from = location.state?.from?.pathname || '/profile';

  // If already logged in as admin, redirect directly to admin console
  useEffect(() => {
    const user = JSON.parse(localStorage.getItem('do-user') || 'null');
    if (user && user.role === 'admin') {
      navigate('/admin/dashboard', { replace: true });
    }
  }, [navigate]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setBusy(true);
    setError(null);

    try {
      const loggedUser = await login({ email, password });
      if (loggedUser && loggedUser.role === 'admin') {
        navigate('/admin/dashboard', { replace: true });
      } else {
        navigate(from, { replace: true });
      }
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <main className="page auth-page" style={{ paddingTop: '24px' }}>
      <span className="eyebrow">DAILY OBJECTS ACCOUNT</span>
      <h1>Welcome back.</h1>
      <p>Sign in to see your saved pieces, addresses, and orders.</p>

      <form className="auth-form" onSubmit={handleSubmit}>
        <label>
          Email address
          <input
            name="email"
            type="email"
            required
            autoComplete="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="you@example.com"
          />
        </label>

        <div>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
            <span style={{ fontSize: '13.5px', fontWeight: '500', color: '#444' }}>Password</span>
            <Link to="/forgot-password" className="text-link" style={{ fontSize: '12.5px', padding: 0, border: 'none' }}>
              Forgot password?
            </Link>
          </div>
          <input
            name="password"
            type="password"
            required
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            style={{
              width: '100%',
              height: '48px',
              border: '1px solid var(--line)',
              borderRadius: '4px',
              padding: '0 14px',
              fontSize: '14.5px'
            }}
          />
        </div>

        {error && <p className="form-error">{error}</p>}

        <button className="button button-dark full" disabled={busy}>
          {busy ? 'Signing in…' : 'Sign in'}
        </button>
      </form>

      <p style={{ marginTop: '20px', fontSize: '14px' }}>
        New here? <Link to="/register" style={{ fontWeight: '600', textDecoration: 'underline' }}>Create an account</Link>
      </p>
    </main>
  );
}

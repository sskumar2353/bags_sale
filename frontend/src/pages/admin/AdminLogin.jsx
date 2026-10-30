import { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import useAuth from '../../hooks/useAuth';
import { Shield } from 'lucide-react';

export default function AdminLogin() {
  const { login } = useAuth();
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setBusy(true);
    setError(null);

    try {
      const user = await login({ email, password });
      if (user.role !== 'admin') {
        throw new Error('Access denied. Administrator privileges required.');
      }
      navigate('/admin/dashboard', { replace: true });
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <main className="page auth-page" style={{ maxWidth: '420px', margin: '40px auto' }}>
      <div style={{ textAlign: 'center', marginBottom: '24px' }}>
        <Shield size={38} color="#a98761" style={{ margin: '0 auto 12px' }} />
        <span className="eyebrow">RESTRICTED PORTAL</span>
        <h1 style={{ fontSize: '26px' }}>Staff & Admin Login</h1>
      </div>

      <form className="auth-form" onSubmit={handleSubmit}>
        <label>
          Admin Email
          <input
            type="email"
            required
            autoComplete="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="admin@dailyobjects.example"
          />
        </label>

        <label>
          Password
          <input
            type="password"
            required
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </label>

        {error && <p className="form-error">{error}</p>}

        <button className="button button-dark full" disabled={busy}>
          {busy ? 'Authenticating…' : 'Enter Admin Console'}
        </button>
      </form>

      <div style={{ textAlign: 'center', marginTop: '20px' }}>
        <Link to="/" className="text-link">
          ← Return to Storefront
        </Link>
      </div>
    </main>
  );
}

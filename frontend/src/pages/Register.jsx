import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import useAuth from '../hooks/useAuth';

export default function Register() {
  const { register } = useAuth();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: ''
  });
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(null);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setBusy(true);
    setError(null);

    try {
      await register({
        firstName: formData.firstName.trim(),
        lastName: formData.lastName.trim() || undefined,
        email: formData.email.trim().toLowerCase(),
        phone: formData.phone.trim() || undefined,
        password: formData.password
      });
      navigate('/profile', { replace: true });
    } catch (err) {
      setError(err.message);
    } finally {
      setBusy(false);
    }
  };

  return (
    <main className="page auth-page" style={{ paddingTop: '24px' }}>
      <span className="eyebrow">DAILY OBJECTS ACCOUNT</span>
      <h1>A little more personal.</h1>
      <p>Create an account to keep track of the good things.</p>

      <form className="auth-form" onSubmit={handleSubmit}>
        <label>
          First name *
          <input
            name="firstName"
            required
            autoComplete="given-name"
            value={formData.firstName}
            onChange={handleChange}
            placeholder="First name"
          />
        </label>

        <label>
          Last name
          <input
            name="lastName"
            autoComplete="family-name"
            value={formData.lastName}
            onChange={handleChange}
            placeholder="Last name"
          />
        </label>

        <label>
          Phone number (optional)
          <input
            name="phone"
            type="tel"
            autoComplete="tel"
            value={formData.phone}
            onChange={handleChange}
            placeholder="10-digit mobile number"
          />
        </label>

        <label>
          Email address *
          <input
            name="email"
            type="email"
            required
            autoComplete="email"
            value={formData.email}
            onChange={handleChange}
            placeholder="you@example.com"
          />
        </label>

        <label>
          Password (min 8 characters) *
          <input
            name="password"
            type="password"
            minLength="8"
            required
            autoComplete="new-password"
            value={formData.password}
            onChange={handleChange}
          />
        </label>

        {error && <p className="form-error">{error}</p>}

        <button className="button button-dark full" disabled={busy}>
          {busy ? 'Creating account…' : 'Create account'}
        </button>
      </form>

      <p style={{ marginTop: '20px', fontSize: '13px' }}>
        Already have an account? <Link to="/login">Sign in</Link>
      </p>
    </main>
  );
}

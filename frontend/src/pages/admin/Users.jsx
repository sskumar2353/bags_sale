import { useState, useEffect } from 'react';
import productService from '../../services/productService';
import Loading from '../../components/common/Loading';
import { Users as UsersIcon, Mail, Phone, Calendar } from 'lucide-react';

export default function AdminUsers() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadUsers() {
      try {
        setLoading(true);
        setError(null);
        const data = await productService.adminGetUsers();
        setUsers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    loadUsers();
  }, []);

  if (loading) return <Loading message="Loading registered accounts…" />;

  return (
    <div>
      <div style={{ marginBottom: '24px' }}>
        <span className="eyebrow">USER DIRECTORY</span>
        <h1 style={{ fontSize: '26px', margin: '4px 0' }}>Customer Accounts ({users.length})</h1>
      </div>

      {error && <p className="form-error">{error}</p>}

      <div style={{ background: '#ffffff', borderRadius: '6px', border: '1px solid var(--line)', overflowX: 'auto' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '13.5px' }}>
          <thead>
            <tr style={{ background: '#f5f5f5', borderBottom: '1px solid var(--line)' }}>
              <th style={{ padding: '12px 16px' }}>User ID</th>
              <th style={{ padding: '12px 16px' }}>Name</th>
              <th style={{ padding: '12px 16px' }}>Email</th>
              <th style={{ padding: '12px 16px' }}>Phone</th>
              <th style={{ padding: '12px 16px' }}>Role</th>
              <th style={{ padding: '12px 16px' }}>Joined Date</th>
            </tr>
          </thead>
          <tbody>
            {users.map((u) => (
              <tr key={u.id} style={{ borderBottom: '1px solid #f0f0f0' }}>
                <td style={{ padding: '12px 16px', color: 'var(--muted)' }}>#{u.id}</td>
                <td style={{ padding: '12px 16px', fontWeight: '600' }}>
                  {u.first_name} {u.last_name || ''}
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <a href={`mailto:${u.email}`} style={{ color: 'var(--ink)', textDecoration: 'none' }}>
                    <Mail size={13} style={{ display: 'inline', marginRight: '5px' }} />
                    {u.email}
                  </a>
                </td>
                <td style={{ padding: '12px 16px' }}>
                  {u.phone ? (
                    <span>
                      <Phone size={13} style={{ display: 'inline', marginRight: '5px' }} />
                      {u.phone}
                    </span>
                  ) : (
                    <span style={{ color: 'var(--muted)' }}>—</span>
                  )}
                </td>
                <td style={{ padding: '12px 16px' }}>
                  <span
                    style={{
                      padding: '3px 8px',
                      borderRadius: '12px',
                      fontSize: '11px',
                      fontWeight: '700',
                      background: u.role === 'admin' ? '#121212' : '#e6f4ea',
                      color: u.role === 'admin' ? '#ffffff' : '#137333'
                    }}
                  >
                    {u.role.toUpperCase()}
                  </span>
                </td>
                <td style={{ padding: '12px 16px', color: 'var(--muted)' }}>
                  <Calendar size={13} style={{ display: 'inline', marginRight: '5px' }} />
                  {u.created_at ? new Date(u.created_at).toLocaleDateString() : 'N/A'}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

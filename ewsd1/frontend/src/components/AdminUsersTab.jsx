import { useEffect, useMemo, useState } from 'react';
import { adminManagementAPI } from '../services/api';
import Modal from './Modal';

function normalize(value) {
  return String(value ?? '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

const roleOptions = [
  { value: 'Admin', label: 'Administrator' },
  { value: 'QAManager', label: 'QA Manager' },
  { value: 'QACoordinator', label: 'QA Coordinator' },
  { value: 'Staff', label: 'Staff Member' },
];

export default function AdminUsersTab({ onError, searchTerm = '' }) {
  const [users, setUsers] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState(null);
  const [generatedPassword, setGeneratedPassword] = useState('');
  const [formData, setFormData] = useState({
    full_name: '',
    email: '',
    username: '',
    department: '',
    role: 'Staff',
    is_active: 1,
    password: '',
  });

  const filteredUsers = useMemo(() => {
    const query = normalize(searchTerm.trim());
    if (!query) {
      return users;
    }
    return users.filter((user) => normalize(Object.values(user).join(' ')).includes(query));
  }, [users, searchTerm]);

  const departmentOptions = useMemo(() => {
    const names = (departments || [])
      .map((dept) => dept?.name)
      .filter(Boolean);
    if (formData.department && !names.includes(formData.department)) {
      return [formData.department, ...names];
    }
    return names;
  }, [departments, formData.department]);

  const fetchUsers = async () => {
    setIsLoading(true);
    try {
      const response = await adminManagementAPI.listUsers({ page: 1, per_page: 500 });
      setUsers(response.data.data || []);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load users');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  useEffect(() => {
    const fetchDepartments = async () => {
      try {
        const response = await adminManagementAPI.listDepartments();
        setDepartments(response.data.data || []);
      } catch (error) {
        setDepartments([]);
      }
    };
    fetchDepartments();
  }, []);

  const openCreate = () => {
    setEditingUser(null);
    setGeneratedPassword('');
    setFormData({
      full_name: '',
      email: '',
      username: '',
      department: '',
      role: 'Staff',
      is_active: 1,
      password: '',
    });
    setModalOpen(true);
  };

  const openEdit = (user) => {
    setEditingUser(user);
    setGeneratedPassword('');
    setFormData({
      user_id: user.user_id,
      full_name: user.name || '',
      email: user.email || '',
      username: user.username || '',
      department: user.department || '',
      role: user.role || 'Staff',
      is_active: user.is_active ? 1 : 0,
      password: '',
    });
    setModalOpen(true);
  };

  const submit = async (event) => {
    event.preventDefault();
    try {
      if (editingUser) {
        await adminManagementAPI.updateUser(formData);
      } else {
        const payload = { ...formData };
        if (!payload.password) {
          delete payload.password;
        }
        const response = await adminManagementAPI.createUser(payload);
        setGeneratedPassword(response.data.data?.generated_password || '');
      }
      await fetchUsers();
      if (editingUser) {
        setModalOpen(false);
      }
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save user');
    }
  };

  const deactivateUser = async (userId) => {
    if (!window.confirm('Deactivate this user account?')) return;
    try {
      await adminManagementAPI.deleteUser({ user_id: userId, mode: 'deactivate' });
      await fetchUsers();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to deactivate user');
    }
  };

  const deleteUser = async (userId) => {
    if (!window.confirm('Permanently delete this user?')) return;
    try {
      await adminManagementAPI.deleteUser({ user_id: userId, mode: 'delete' });
      await fetchUsers();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete user');
    }
  };

  const resetPassword = async (userId) => {
    try {
      const response = await adminManagementAPI.resetPassword({ user_id: userId });
      const password = response.data.data?.generated_password || '<unavailable>';
      window.alert(`New password: ${password}`);
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to reset password');
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-neutral-900">User Management</h2>
        <button
          type="button"
          onClick={openCreate}
          className="rounded-lg bg-primary-600 px-4 py-2 text-sm font-semibold text-white hover:bg-primary-700"
        >
          + Add User
        </button>
      </div>

      {isLoading ? (
        <div className="rounded-lg border border-neutral-200 bg-white p-6 text-sm text-neutral-600">Loading users...</div>
      ) : filteredUsers.length === 0 ? (
        <div className="rounded-lg border border-neutral-200 bg-white p-6 text-sm text-neutral-600">No users found.</div>
      ) : (
        <div className="overflow-x-auto rounded-lg border border-neutral-200 bg-white">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 text-neutral-700">
              <tr>
                <th className="px-3 py-2 text-left">Staff ID</th>
                <th className="px-3 py-2 text-left">Name</th>
                <th className="px-3 py-2 text-left">Email</th>
                <th className="px-3 py-2 text-left">Department</th>
                <th className="px-3 py-2 text-left">Role</th>
                <th className="px-3 py-2 text-left">Status</th>
                <th className="px-3 py-2 text-left">Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map((user) => (
                <tr key={user.user_id} className="border-t border-neutral-100">
                  <td className="px-3 py-2">{user.staff_id}</td>
                  <td className="px-3 py-2">{user.name}</td>
                  <td className="px-3 py-2">{user.email}</td>
                  <td className="px-3 py-2">{user.department || 'N/A'}</td>
                  <td className="px-3 py-2">{roleOptions.find((r) => r.value === user.role)?.label || user.role}</td>
                  <td className="px-3 py-2">{user.account_status}</td>
                  <td className="px-3 py-2">
                    <div className="flex flex-wrap gap-2">
                      <button type="button" onClick={() => openEdit(user)} className="rounded bg-primary-50 px-2 py-1 text-primary-700">
                        Edit
                      </button>
                      <button type="button" onClick={() => resetPassword(user.user_id)} className="rounded bg-warning-50 px-2 py-1 text-warning-700">
                        Reset Password
                      </button>
                      <button type="button" onClick={() => deactivateUser(user.user_id)} className="rounded bg-neutral-100 px-2 py-1 text-neutral-700">
                        Deactivate
                      </button>
                      <button type="button" onClick={() => deleteUser(user.user_id)} className="rounded bg-danger-50 px-2 py-1 text-danger-700">
                        Delete
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <Modal isOpen={modalOpen} onClose={() => setModalOpen(false)}>
        <h3 className="mb-4 text-lg font-semibold text-neutral-900">{editingUser ? 'Edit User' : 'Create User'}</h3>

        {generatedPassword && (
          <div className="mb-4 rounded border border-emerald-200 bg-emerald-50 px-3 py-2 text-sm text-emerald-700">
            Generated password: <span className="font-mono font-semibold">{generatedPassword}</span>
          </div>
        )}

        <form onSubmit={submit} className="space-y-3">
          <input
            type="text"
            required
            placeholder="Full name"
            value={formData.full_name}
            onChange={(e) => setFormData({ ...formData, full_name: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          />
          <input
            type="email"
            required
            placeholder="Email"
            value={formData.email}
            onChange={(e) => setFormData({ ...formData, email: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          />
          <input
            type="text"
            placeholder="Username (optional)"
            value={formData.username}
            onChange={(e) => setFormData({ ...formData, username: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          />
          {!editingUser && (
            <input
              type="text"
              placeholder="Password (optional: auto-generated if empty)"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              className="w-full rounded border border-neutral-300 px-3 py-2"
            />
          )}
          <select
            value={formData.department}
            onChange={(e) => setFormData({ ...formData, department: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          >
            <option value="">Select department</option>
            {departmentOptions.map((dept) => (
              <option key={dept} value={dept}>
                {dept}
              </option>
            ))}
          </select>
          <select
            value={formData.role}
            onChange={(e) => setFormData({ ...formData, role: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          >
            {roleOptions.map((role) => (
              <option key={role.value} value={role.value}>
                {role.label}
              </option>
            ))}
          </select>
          <label className="flex items-center gap-2 text-sm text-neutral-700">
            <input
              type="checkbox"
              checked={Boolean(formData.is_active)}
              onChange={(e) => setFormData({ ...formData, is_active: e.target.checked ? 1 : 0 })}
            />
            Active account
          </label>
          <div className="flex flex-col gap-3 pt-2 sm:flex-row">
            <button type="submit" className="flex-1 rounded bg-primary-600 px-4 py-2 font-semibold text-white">
              {editingUser ? 'Update' : 'Create'}
            </button>
            <button type="button" onClick={() => setModalOpen(false)} className="flex-1 rounded border border-neutral-300 px-4 py-2 font-semibold">
              Close
            </button>
          </div>
        </form>
      </Modal>
    </div>
  );
}

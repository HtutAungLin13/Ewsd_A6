import { useEffect, useMemo, useState } from 'react';
import { adminManagementAPI } from '../services/api';
import Modal from './Modal';

function normalize(value) {
  return String(value ?? '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

export default function AdminDepartmentsTab({ onError, searchTerm = '' }) {
  const [departments, setDepartments] = useState([]);
  const [coordinators, setCoordinators] = useState([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editing, setEditing] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    qa_coordinator_id: '',
    is_active: 1,
  });

  const filtered = useMemo(() => {
    const q = normalize(searchTerm.trim());
    if (!q) return departments;
    return departments.filter((dept) => normalize(Object.values(dept).join(' ')).includes(q));
  }, [departments, searchTerm]);

  const fetchData = async () => {
    setLoading(true);
    try {
      const [deptRes, usersRes] = await Promise.all([
        adminManagementAPI.listDepartments(),
        adminManagementAPI.listUsers({ role: 'QACoordinator', page: 1, per_page: 500 }),
      ]);
      setDepartments(deptRes.data.data || []);
      setCoordinators(usersRes.data.data || []);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load departments');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const openCreate = () => {
    setEditing(null);
    setFormData({ name: '', qa_coordinator_id: '', is_active: 1 });
    setModalOpen(true);
  };

  const openEdit = (dept) => {
    setEditing(dept);
    setFormData({
      department_id: dept.id,
      name: dept.name || '',
      qa_coordinator_id: dept.qa_coordinator_id || '',
      is_active: dept.is_active ? 1 : 0,
    });
    setModalOpen(true);
  };

  const submit = async (event) => {
    event.preventDefault();
    try {
      if (editing) {
        await adminManagementAPI.updateDepartment({
          ...formData,
          qa_coordinator_id: formData.qa_coordinator_id ? Number(formData.qa_coordinator_id) : 0,
        });
      } else {
        await adminManagementAPI.createDepartment({
          ...formData,
          qa_coordinator_id: formData.qa_coordinator_id ? Number(formData.qa_coordinator_id) : 0,
        });
      }
      setModalOpen(false);
      await fetchData();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save department');
    }
  };

  const removeDepartment = async (departmentId) => {
    if (!window.confirm('Delete this department? This only works when no users/staff are assigned.')) return;
    try {
      await adminManagementAPI.deleteDepartment(departmentId);
      await fetchData();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete department');
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-neutral-900">Department Management</h2>
        <button type="button" onClick={openCreate} className="rounded-lg bg-primary-600 px-4 py-2 text-sm font-semibold text-white hover:bg-primary-700">
          + Add Department
        </button>
      </div>

      {loading ? (
        <div className="rounded border border-neutral-200 bg-white p-5 text-sm text-neutral-600">Loading departments...</div>
      ) : filtered.length === 0 ? (
        <div className="rounded border border-neutral-200 bg-white p-5 text-sm text-neutral-600">No departments available yet.</div>
      ) : (
        <div className="overflow-x-auto rounded border border-neutral-200 bg-white">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 text-neutral-700">
              <tr>
                <th className="px-3 py-2 text-left">Department</th>
                <th className="px-3 py-2 text-left">QA Coordinator</th>
                <th className="px-3 py-2 text-left">Stats</th>
                <th className="px-3 py-2 text-left">Status</th>
                <th className="px-3 py-2 text-left">Actions</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map((dept) => (
                <tr key={dept.id} className="border-t border-neutral-100">
                  <td className="px-3 py-2">{dept.name}</td>
                  <td className="px-3 py-2">{dept.qa_coordinator_name || 'Not assigned yet'}</td>
                  <td className="px-3 py-2 text-xs text-neutral-700">
                    Users: {dept.total_users} | Active: {dept.active_users} | Staff: {dept.total_staff} | Ideas: {dept.total_ideas}
                  </td>
                  <td className="px-3 py-2">{dept.is_active ? 'Active' : 'Inactive'}</td>
                  <td className="px-3 py-2">
                    <div className="flex gap-2">
                      <button type="button" onClick={() => openEdit(dept)} className="rounded bg-primary-50 px-2 py-1 text-primary-700">
                        Edit
                      </button>
                      <button type="button" onClick={() => removeDepartment(dept.id)} className="rounded bg-danger-50 px-2 py-1 text-danger-700">
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
        <h3 className="mb-4 text-lg font-semibold text-neutral-900">{editing ? 'Edit Department' : 'Create Department'}</h3>
        <form onSubmit={submit} className="space-y-3">
          <input
            type="text"
            required
            placeholder="Department name"
            value={formData.name}
            onChange={(e) => setFormData({ ...formData, name: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          />
          <select
            value={formData.qa_coordinator_id}
            onChange={(e) => setFormData({ ...formData, qa_coordinator_id: e.target.value })}
            className="w-full rounded border border-neutral-300 px-3 py-2"
          >
            <option value="">Not assigned yet</option>
            {coordinators.map((user) => (
              <option key={user.user_id} value={user.user_id}>
                {user.name} ({user.email})
              </option>
            ))}
          </select>
          <label className="flex items-center gap-2 text-sm text-neutral-700">
            <input
              type="checkbox"
              checked={Boolean(formData.is_active)}
              onChange={(e) => setFormData({ ...formData, is_active: e.target.checked ? 1 : 0 })}
            />
            Active department
          </label>
          <div className="flex flex-col gap-3 sm:flex-row">
            <button type="submit" className="flex-1 rounded bg-primary-600 px-4 py-2 font-semibold text-white">
              {editing ? 'Update' : 'Create'}
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

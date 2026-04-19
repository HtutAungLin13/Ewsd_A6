// src/components/StaffTab.jsx
import { useState, useEffect, useMemo } from 'react';
import { staffAPI } from '../services/api';
import Modal from './Modal';

function normalizeSearchText(value) {
  return String(value ?? '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

export default function StaffTab({ onError, searchTerm = '' }) {
  const [staff, setStaff] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    role: 'Coordinator',
    department: '',
    phone: '',
  });

  const normalizedSearch = normalizeSearchText(searchTerm.trim());
  const filteredStaff = useMemo(() => {
    if (!normalizedSearch) {
      return staff;
    }

    return staff.filter((member) => {
      const searchableText = normalizeSearchText(
        Object.values(member)
          .filter((value) => value !== null && value !== undefined)
          .join(' '),
      );

      return searchableText.includes(normalizedSearch);
    });
  }, [staff, normalizedSearch]);

  // Fetch staff list
  const fetchStaff = async () => {
    setIsLoading(true);
    try {
      const response = await staffAPI.getAll(1, 500);
      setStaff(response.data.data);
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to fetch staff');
    } finally {
      setIsLoading(false);
    }
  };
  
  useEffect(() => {
    fetchStaff();
  }, []);
  
  // Open modal for creating new staff
  const openCreateModal = () => {
    setFormData({
      name: '',
      email: '',
      role: 'Coordinator',
      department: '',
      phone: '',
    });
    setEditingId(null);
    setIsModalOpen(true);
  };
  
  // Open modal for editing staff
  const openEditModal = (member) => {
    setFormData({
      name: member.name,
      email: member.email,
      role: member.role,
      department: member.department || '',
      phone: member.phone || '',
    });
    setEditingId(member.id);
    setIsModalOpen(true);
  };
  
  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      if (editingId) {
        // Update
        await staffAPI.update(editingId, formData);
        onError(''); // Clear any previous errors
      } else {
        // Create
        await staffAPI.create(formData);
        onError('');
      }
      
      setIsModalOpen(false);
      fetchStaff();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save staff member');
    }
  };
  
  // Handle delete
  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this staff member?')) {
      return;
    }
    
    try {
      await staffAPI.delete(id);
      onError('');
      fetchStaff();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete staff member');
    }
  };
  
  return (
    <div>
      {/* Header with Create Button */}
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-neutral-900">Staff Members</h2>
        <button
          onClick={openCreateModal}
          className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium"
        >
          + Add Staff Member
        </button>
      </div>
      
      {/* Loading State */}
      {isLoading && (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading staff members...</p>
        </div>
      )}
      
      {/* Staff List */}
      {!isLoading && staff.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600 mb-4">No staff members yet</p>
          <button
            onClick={openCreateModal}
            className="text-primary-600 hover:text-primary-700 font-medium"
          >
            Create the first one
          </button>
        </div>
      ) : !isLoading && filteredStaff.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No matching staff found for "{searchTerm}"</p>
        </div>
      ) : (
        <div className="grid gap-4">
          {filteredStaff.map((member) => (
            <div
              key={member.id}
              className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
            >
              <div className="flex justify-between items-start">
                <div className="flex-1">
                  <h3 className="text-base font-semibold text-neutral-900">{member.name}</h3>
                  <p className="text-sm text-neutral-600 mt-1">{member.email}</p>
                  <div className="flex gap-2 mt-3">
                    <span className="inline-block px-3 py-1 bg-primary-100 text-primary-700 rounded-full text-xs font-medium">
                      {member.role}
                    </span>
                    {member.department && (
                      <span className="inline-block px-3 py-1 bg-neutral-100 text-neutral-700 rounded-full text-xs">
                        {member.department}
                      </span>
                    )}
                  </div>
                  {member.phone && (
                    <p className="text-sm text-neutral-500 mt-2">{member.phone}</p>
                  )}
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => openEditModal(member)}
                    className="px-3 py-1 text-sm font-medium text-primary-600 hover:bg-primary-50 rounded transition"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDelete(member.id)}
                    className="px-3 py-1 text-sm font-medium text-danger-600 hover:bg-danger-50 rounded transition"
                  >
                    Delete
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
      
      {/* Modal */}
      <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          {editingId ? 'Edit Staff Member' : 'Add Staff Member'}
        </h3>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          {/* Name */}
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Full Name *
            </label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              placeholder="e.g., John Smith"
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          {/* Email */}
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Email *
            </label>
            <input
              type="email"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              placeholder="e.g., john@example.com"
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          {/* Role */}
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Role *
            </label>
            <select
              value={formData.role}
              onChange={(e) => setFormData({ ...formData, role: e.target.value })}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            >
              <option>Manager</option>
              <option>Coordinator</option>
              <option>Staff</option>
            </select>
          </div>
          
          {/* Department */}
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Department
            </label>
            <input
              type="text"
              value={formData.department}
              onChange={(e) => setFormData({ ...formData, department: e.target.value })}
              placeholder="e.g., Innovation"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          {/* Phone */}
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Phone
            </label>
            <input
              type="tel"
              value={formData.phone}
              onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
              placeholder="e.g., +1-234-567-8900"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          {/* Buttons */}
          <div className="flex gap-3 pt-4">
            <button
              type="submit"
              className="flex-1 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium"
            >
              {editingId ? 'Update' : 'Create'}
            </button>
            <button
              type="button"
              onClick={() => setIsModalOpen(false)}
              className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
            >
              Cancel
            </button>
          </div>
        </form>
      </Modal>
    </div>
  );
}

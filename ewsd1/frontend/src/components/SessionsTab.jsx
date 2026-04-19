// src/components/SessionsTab.jsx
import { useState, useEffect, useMemo } from 'react';
import { sessionsAPI, academicYearsAPI } from '../services/api';
import Modal from './Modal';

function normalizeSearchText(value) {
  return String(value ?? '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

export default function SessionsTab({ onError, searchTerm = '' }) {
  const [sessions, setSessions] = useState([]);
  const [academicYears, setAcademicYears] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [formData, setFormData] = useState({
    academic_year_id: '',
    category_id: 1,
    session_name: '',
    description: '',
    opens_at: '',
    closes_at: '',
    final_closure_date: '',
    status: 'Draft',
  });

  const normalizedSearch = normalizeSearchText(searchTerm.trim());
  const filteredSessions = useMemo(() => {
    if (!normalizedSearch) {
      return sessions;
    }

    return sessions.filter((session) => {
      const searchableText = normalizeSearchText(
        Object.values(session)
          .filter((value) => value !== null && value !== undefined)
          .join(' '),
      );

      return searchableText.includes(normalizedSearch);
    });
  }, [sessions, normalizedSearch]);

  // Fetch sessions and academic years
  const fetchData = async () => {
    setIsLoading(true);
    try {
      const [sessionsRes, yearsRes] = await Promise.all([
        sessionsAPI.getAll(1, 500),
        academicYearsAPI.getAll(1, 500),
      ]);
      setSessions(sessionsRes.data.data);
      setAcademicYears(yearsRes.data.data);
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to fetch data');
    } finally {
      setIsLoading(false);
    }
  };
  
  useEffect(() => {
    fetchData();
  }, []);
  
  // Initialize form with first academic year
  useEffect(() => {
    if (academicYears.length > 0 && !formData.academic_year_id) {
      setFormData(prev => ({ ...prev, academic_year_id: academicYears[0].id }));
    }
  }, [academicYears]);
  
  const openCreateModal = () => {
    setFormData({
      academic_year_id: academicYears[0]?.id || '',
      category_id: 1,
      session_name: '',
      description: '',
      opens_at: '',
      closes_at: '',
      final_closure_date: '',
      status: 'Draft',
    });
    setEditingId(null);
    setIsModalOpen(true);
  };
  
  const openEditModal = (session) => {
    setFormData({
      academic_year_id: session.academic_year_id,
      category_id: session.category_id,
      session_name: session.session_name,
      description: session.description || '',
      opens_at: session.opens_at,
      closes_at: session.closes_at,
      final_closure_date: session.final_closure_date || session.closes_at,
      status: session.status,
    });
    setEditingId(session.id);
    setIsModalOpen(true);
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      if (editingId) {
        await sessionsAPI.update(editingId, formData);
      } else {
        await sessionsAPI.create(formData);
      }
      
      setIsModalOpen(false);
      fetchData();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save session');
    }
  };
  
  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this session?')) {
      return;
    }
    
    try {
      await sessionsAPI.delete(id);
      fetchData();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete session');
    }
  };
  
  const getStatusColor = (status) => {
    switch (status) {
      case 'Active':
        return 'bg-success-100 text-success-700';
      case 'Closed':
        return 'bg-danger-100 text-danger-700';
      default:
        return 'bg-warning-100 text-warning-700';
    }
  };
  
  return (
    <div>
      <div className="mb-6">
        <h2 className="text-xl font-semibold text-neutral-900">Idea Category Sessions</h2>
      </div>
      
      {isLoading && (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading sessions...</p>
        </div>
      )}
      
      {!isLoading && sessions.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No sessions yet</p>
        </div>
      ) : !isLoading && filteredSessions.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No matching sessions found for "{searchTerm}"</p>
        </div>
      ) : (
        <div className="grid gap-4">
          {filteredSessions.map((session) => (
            <div
              key={session.id}
              className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
            >
              <div className="flex justify-between items-start mb-3">
                <div>
                  <h3 className="text-base font-semibold text-neutral-900">{session.session_name}</h3>
                  <p className="text-sm text-neutral-600 mt-1">{session.category_name} • {session.year_label}</p>
                </div>
                <span className={`inline-block px-3 py-1 rounded-full text-xs font-medium ${getStatusColor(session.status)}`}>
                  {session.status}
                </span>
              </div>
              
              {session.description && (
                <p className="text-sm text-neutral-600 mb-3">{session.description}</p>
              )}
              
              <div className="grid grid-cols-2 gap-4 mb-4 py-3 border-t border-neutral-100">
                <div>
                  <p className="text-xs text-neutral-600 font-medium">Opens</p>
                  <p className="text-sm text-neutral-900 font-semibold">
                    {new Date(session.opens_at).toLocaleDateString()}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-neutral-600 font-medium">Closes</p>
                  <p className="text-sm text-neutral-900 font-semibold">
                    {new Date(session.closes_at).toLocaleDateString()}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-neutral-600 font-medium">Final Comment Closure</p>
                  <p className="text-sm text-neutral-900 font-semibold">
                    {new Date(session.final_closure_date || session.closes_at).toLocaleDateString()}
                  </p>
                </div>
              </div>
              
              <div className="flex gap-2">
                <button
                  onClick={() => openEditModal(session)}
                  className="flex-1 px-3 py-1 text-sm font-medium text-primary-600 hover:bg-primary-50 rounded transition"
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(session.id)}
                  className="flex-1 px-3 py-1 text-sm font-medium text-danger-600 hover:bg-danger-50 rounded transition"
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
      
      {/* Modal */}
      <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          {editingId ? 'Edit Session' : 'Add Session'}
        </h3>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Academic Year *
            </label>
            <select
              value={formData.academic_year_id}
              onChange={(e) => setFormData({ ...formData, academic_year_id: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            >
              <option value="">Select an academic year</option>
              {academicYears.map(year => (
                <option key={year.id} value={year.id}>{year.year_label}</option>
              ))}
            </select>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Session Name *
            </label>
            <input
              type="text"
              value={formData.session_name}
              onChange={(e) => setFormData({ ...formData, session_name: e.target.value })}
              placeholder="e.g., Tech Ideas 2024"
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Description
            </label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              placeholder="Session description..."
              rows="3"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Opens At *
            </label>
            <input
              type="datetime-local"
              value={formData.opens_at}
              onChange={(e) => setFormData({ ...formData, opens_at: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Closes At *
            </label>
            <input
              type="datetime-local"
              value={formData.closes_at}
              onChange={(e) => setFormData({ ...formData, closes_at: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Final Comment Closure Date *
            </label>
            <input
              type="datetime-local"
              value={formData.final_closure_date}
              onChange={(e) => setFormData({ ...formData, final_closure_date: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Status
            </label>
            <select
              value={formData.status}
              onChange={(e) => setFormData({ ...formData, status: e.target.value })}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            >
              <option>Draft</option>
              <option>Active</option>
              <option>Closed</option>
            </select>
          </div>
          
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

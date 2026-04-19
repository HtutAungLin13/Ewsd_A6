// src/components/AcademicYearsTab.jsx
import { useState, useEffect, useMemo } from 'react';
import { academicYearsAPI } from '../services/api';
import Modal from './Modal';

function normalizeSearchText(value) {
  return String(value ?? '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

export default function AcademicYearsTab({ onError, searchTerm = '' }) {
  const [academicYears, setAcademicYears] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [formData, setFormData] = useState({
    year_label: '',
    start_date: '',
    end_date: '',
    is_active: 1,
  });

  const normalizedSearch = normalizeSearchText(searchTerm.trim());
  const filteredAcademicYears = useMemo(() => {
    if (!normalizedSearch) {
      return academicYears;
    }

    return academicYears.filter((year) => {
      const activeLabel = year.is_active ? 'active' : 'inactive';
      const searchableText = normalizeSearchText(
        [...Object.values(year), activeLabel]
          .filter((value) => value !== null && value !== undefined)
          .join(' '),
      );

      return searchableText.includes(normalizedSearch);
    });
  }, [academicYears, normalizedSearch]);

  // Fetch academic years
  const fetchAcademicYears = async () => {
    setIsLoading(true);
    try {
      const response = await academicYearsAPI.getAll(1, 500);
      setAcademicYears(response.data.data);
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to fetch academic years');
    } finally {
      setIsLoading(false);
    }
  };
  
  useEffect(() => {
    fetchAcademicYears();
  }, []);
  
  const openCreateModal = () => {
    setFormData({
      year_label: '',
      start_date: '',
      end_date: '',
      is_active: 1,
    });
    setEditingId(null);
    setIsModalOpen(true);
  };
  
  const openEditModal = (year) => {
    setFormData({
      year_label: year.year_label,
      start_date: year.start_date,
      end_date: year.end_date,
      is_active: year.is_active,
    });
    setEditingId(year.id);
    setIsModalOpen(true);
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      if (editingId) {
        await academicYearsAPI.update(editingId, formData);
      } else {
        await academicYearsAPI.create(formData);
      }
      
      setIsModalOpen(false);
      fetchAcademicYears();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save academic year');
    }
  };
  
  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this academic year?')) {
      return;
    }
    
    try {
      await academicYearsAPI.delete(id);
      fetchAcademicYears();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete academic year');
    }
  };
  
  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-neutral-900">Academic Years</h2>
        <button
          onClick={openCreateModal}
          className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium"
        >
          + Add Academic Year
        </button>
      </div>
      
      {isLoading && (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading academic years...</p>
        </div>
      )}
      
      {!isLoading && academicYears.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600 mb-4">No academic years yet</p>
          <button
            onClick={openCreateModal}
            className="text-primary-600 hover:text-primary-700 font-medium"
          >
            Create the first one
          </button>
        </div>
      ) : !isLoading && filteredAcademicYears.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No matching academic years found for "{searchTerm}"</p>
        </div>
      ) : (
        <div className="grid gap-4">
          {filteredAcademicYears.map((year) => (
            <div
              key={year.id}
              className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
            >
              <div className="flex justify-between items-start mb-3">
                <div>
                  <h3 className="text-base font-semibold text-neutral-900">{year.year_label}</h3>
                  {year.is_active ? (
                    <span className="inline-block mt-2 px-3 py-1 bg-success-100 text-success-700 rounded-full text-xs font-medium">
                      Active
                    </span>
                  ) : (
                    <span className="inline-block mt-2 px-3 py-1 bg-neutral-100 text-neutral-700 rounded-full text-xs font-medium">
                      Inactive
                    </span>
                  )}
                </div>
                <div className="text-right">
                  <p className="text-xs text-neutral-600 font-medium mb-1">Duration</p>
                  <p className="text-sm text-neutral-900">
                    {new Date(year.start_date).toLocaleDateString()} → {new Date(year.end_date).toLocaleDateString()}
                  </p>
                </div>
              </div>
              
              <div className="flex gap-2 pt-3 border-t border-neutral-100">
                <button
                  onClick={() => openEditModal(year)}
                  className="flex-1 px-3 py-1 text-sm font-medium text-primary-600 hover:bg-primary-50 rounded transition"
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(year.id)}
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
          {editingId ? 'Edit Academic Year' : 'Add Academic Year'}
        </h3>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Academic Year Label *
            </label>
            <input
              type="text"
              value={formData.year_label}
              onChange={(e) => setFormData({ ...formData, year_label: e.target.value })}
              placeholder="e.g., 2024-2025"
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Start Date *
            </label>
            <input
              type="date"
              value={formData.start_date}
              onChange={(e) => setFormData({ ...formData, start_date: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              End Date *
            </label>
            <input
              type="date"
              value={formData.end_date}
              onChange={(e) => setFormData({ ...formData, end_date: e.target.value })}
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div className="flex items-center">
            <input
              type="checkbox"
              id="is_active"
              checked={formData.is_active}
              onChange={(e) => setFormData({ ...formData, is_active: e.target.checked ? 1 : 0 })}
              className="w-4 h-4 text-primary-600 border border-neutral-300 rounded focus:ring-2 focus:ring-primary-500"
            />
            <label htmlFor="is_active" className="ml-2 block text-sm font-medium text-neutral-700">
              Mark as active
            </label>
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

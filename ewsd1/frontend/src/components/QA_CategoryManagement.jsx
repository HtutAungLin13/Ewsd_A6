// src/components/QA/CategoryManagement.jsx
import { useState, useEffect } from 'react';
import apiClient from '../services/api';
import Modal from './Modal';

export default function CategoryManagement({ onError }) {
  const [categories, setCategories] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    color: '#0EA5E9',
    icon: '',
    sort_order: 0,
  });
  
  // Fetch categories
  const fetchCategories = async () => {
    setIsLoading(true);
    try {
      const response = await apiClient.get('/QA_categories.php');
      setCategories(response.data.data);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to fetch categories');
    } finally {
      setIsLoading(false);
    }
  };
  
  useEffect(() => {
    fetchCategories();
  }, []);
  
  const openCreateModal = () => {
    setFormData({
      name: '',
      description: '',
      color: '#0EA5E9',
      icon: '',
      sort_order: 0,
    });
    setEditingId(null);
    setIsModalOpen(true);
  };
  
  const openEditModal = (category) => {
    setFormData({
      name: category.name,
      description: category.description || '',
      color: category.color || '#0EA5E9',
      icon: category.icon || '',
      sort_order: category.sort_order || 0,
    });
    setEditingId(category.id);
    setIsModalOpen(true);
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      if (editingId) {
        await apiClient.put(`/QA_categories.php?id=${editingId}`, formData);
      } else {
        await apiClient.post('/QA_categories.php', formData);
      }
      
      setIsModalOpen(false);
      fetchCategories();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save category');
    }
  };
  
  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this category?')) return;
    
    try {
      await apiClient.delete(`/QA_categories.php?id=${id}`);
      fetchCategories();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to delete category');
    }
  };
  
  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-neutral-900">Idea Categories</h2>
        <button
          onClick={openCreateModal}
          className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium"
        >
          + Add Category
        </button>
      </div>
      
      {isLoading && (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading categories...</p>
        </div>
      )}
      
      {!isLoading && categories.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600 mb-4">No categories yet</p>
          <button
            onClick={openCreateModal}
            className="text-primary-600 hover:text-primary-700 font-medium"
          >
            Create the first one
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {categories.map((category) => (
            <div
              key={category.id}
              className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
              style={{ borderLeftColor: category.color, borderLeftWidth: '4px' }}
            >
              <div className="flex justify-between items-start mb-2">
                <h3 className="text-base font-semibold text-neutral-900">{category.name}</h3>
                <span
                  className="w-4 h-4 rounded-full"
                  style={{ backgroundColor: category.color }}
                  title={category.color}
                />
              </div>
              
              {category.description && (
                <p className="text-sm text-neutral-600 mb-3">{category.description}</p>
              )}
              
              <div className="flex gap-2">
                <button
                  onClick={() => openEditModal(category)}
                  className="flex-1 px-3 py-1 text-sm font-medium text-primary-600 hover:bg-primary-50 rounded transition"
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(category.id)}
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
          {editingId ? 'Edit Category' : 'Add Category'}
        </h3>
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Category Name *
            </label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              placeholder="e.g., Technology"
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
              placeholder="Category description"
              rows="3"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Color
            </label>
            <input
              type="color"
              value={formData.color}
              onChange={(e) => setFormData({ ...formData, color: e.target.value })}
              className="w-16 h-10 border border-neutral-300 rounded-lg cursor-pointer"
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Sort Order
            </label>
            <input
              type="number"
              value={formData.sort_order}
              onChange={(e) => setFormData({ ...formData, sort_order: parseInt(e.target.value) })}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none transition"
            />
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

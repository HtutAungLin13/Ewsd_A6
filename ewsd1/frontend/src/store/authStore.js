// src/store/authStore.js
import { create } from 'zustand';
import { authAPI } from '../services/api';

const normalizeRole = (role) => {
  if (!role || typeof role !== 'string') return role;
  const cleaned = role.replace(/\s+/g, '').toLowerCase();
  if (cleaned === 'qamanager') return 'QAManager';
  if (cleaned === 'qacoordinator') return 'QACoordinator';
  if (cleaned === 'staff') return 'Staff';
  if (cleaned === 'admin') return 'Admin';
  return role;
};

const loadStoredUser = () => {
  try {
    const raw = localStorage.getItem('user');
    if (!raw) return null;
    const user = JSON.parse(raw);
    if (user?.role) {
      user.role = normalizeRole(user.role);
    }
    return user;
  } catch (error) {
    return null;
  }
};

export const useAuthStore = create((set) => ({
  user: loadStoredUser(),
  token: localStorage.getItem('authToken') || null,
  isLoading: false,
  error: null,
  
  login: async (username, password) => {
    set({ isLoading: true, error: null });
    try {
      const response = await authAPI.login(username, password);
      const { token, user } = response.data.data;
      const normalizedUser = user ? { ...user, role: normalizeRole(user.role) } : user;
      const loginAt = new Date().toISOString();
      const lastLoginAt = user?.last_login || null;
      
      // Store token and user
      localStorage.setItem('authToken', token);
      localStorage.setItem('user', JSON.stringify(normalizedUser));
      localStorage.setItem('loginAt', loginAt);
      localStorage.setItem('lastLoginAt', lastLoginAt || '');
      
      set({ user: normalizedUser, token, isLoading: false });
      return response.data;
    } catch (error) {
      const errorMessage = error.response?.data?.message || 'Login failed';
      set({ error: errorMessage, isLoading: false });
      throw error;
    }
  },
  
  logout: () => {
    authAPI.logout();
    set({ user: null, token: null, error: null });
  },
  
  setError: (error) => set({ error }),
  clearError: () => set({ error: null }),
  
  isAuthenticated: () => {
    const token = localStorage.getItem('authToken');
    return !!token;
  },
}));

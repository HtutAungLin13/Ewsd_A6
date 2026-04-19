// src/pages/LoginPage.jsx
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';

export default function LoginPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [fieldErrors, setFieldErrors] = useState({ username: '', password: '' });
  const [isLoading, setIsLoading] = useState(false);
  
  const navigate = useNavigate();
  const login = useAuthStore((state) => state.login);
  
  const normalizeRole = (role) => {
    if (!role || typeof role !== 'string') return role;
    const cleaned = role.replace(/\s+/g, '').toLowerCase();
    if (cleaned === 'qamanager') return 'QAManager';
    if (cleaned === 'qacoordinator') return 'QACoordinator';
    if (cleaned === 'staff') return 'Staff';
    if (cleaned === 'admin') return 'Admin';
    return role;
  };

  const validateUsername = (value) => {
    if (!value || !value.trim()) return 'Username is required';
    if (value.trim().length < 3) return 'Username must be at least 3 characters';
    return '';
  };

  const validatePassword = (value) => {
    if (!value) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return '';
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    const usernameError = validateUsername(username);
    const passwordError = validatePassword(password);
    setFieldErrors({ username: usernameError, password: passwordError });
    if (usernameError || passwordError) {
      return;
    }
    setIsLoading(true);
    
    try {
      const result = await login(username, password);
      const role = normalizeRole(result?.data?.user?.role);
      if (role === 'QAManager') {
        navigate('/qa');
      } else if (role === 'QACoordinator') {
        navigate('/coordinator');
      } else if (role === 'Staff') {
        navigate('/staff');
      } else {
        navigate('/admin');
      }
    } catch (err) {
      setError(err.response?.data?.message || 'Login failed. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };
  
  return (
    <div className="min-h-screen relative overflow-hidden bg-gradient-to-br from-primary-50 via-white to-neutral-100 flex items-center justify-center p-4">
      {/* Background accents */}
      <div className="absolute -top-24 -left-24 h-64 w-64 rounded-full bg-primary-200/40 blur-3xl" />
      <div className="absolute -bottom-28 -right-16 h-72 w-72 rounded-full bg-emerald-200/40 blur-3xl" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,rgba(0,0,0,0.04),transparent_55%)]" />

      <div className="relative z-10 w-full max-w-md">
        {/* Card */}
        <div className="rounded-2xl border border-white/60 bg-white/80 backdrop-blur shadow-2xl p-8">
          {/* Header */}
          <div className="text-center mb-8">
            <h1 className="text-3xl font-semibold text-neutral-900 tracking-tight mb-1">Welcome back</h1>
            <p className="text-neutral-600 text-sm">Sign in to your account</p>
          </div>
          
          {/* Error Message */}
          {error && (
            <div className="mb-4 p-4 bg-danger-50 border border-danger-200 rounded-lg">
              <p className="text-danger-700 text-sm">{error}</p>
            </div>
          )}
          
          {/* Form */}
          <form onSubmit={handleSubmit} className="space-y-4">
            {/* Username Field */}
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-2">
                Username
              </label>
              <input
                type="text"
                value={username}
                onChange={(e) => {
                  const nextValue = e.target.value;
                  setUsername(nextValue);
                  if (fieldErrors.username) {
                    setFieldErrors((prev) => ({ ...prev, username: validateUsername(nextValue) }));
                  }
                }}
                placeholder="Enter your username"
                className={`w-full px-4 py-2.5 border rounded-xl focus:ring-4 outline-none transition bg-white/90 ${
                  fieldErrors.username
                    ? 'border-danger-300 focus:ring-danger-200 focus:border-danger-400'
                    : 'border-neutral-300 focus:ring-primary-200 focus:border-primary-400'
                }`}
                disabled={isLoading}
              />
              {fieldErrors.username && (
                <p className="mt-2 text-xs text-danger-600">{fieldErrors.username}</p>
              )}
            </div>
            
            {/* Password Field */}
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-2">
                Password
              </label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => {
                    const nextValue = e.target.value;
                    setPassword(nextValue);
                    if (fieldErrors.password) {
                      setFieldErrors((prev) => ({ ...prev, password: validatePassword(nextValue) }));
                    }
                  }}
                  placeholder="Enter your password"
                  className={`w-full px-4 py-2.5 pr-12 border rounded-xl focus:ring-4 outline-none transition bg-white/90 ${
                    fieldErrors.password
                      ? 'border-danger-300 focus:ring-danger-200 focus:border-danger-400'
                      : 'border-neutral-300 focus:ring-primary-200 focus:border-primary-400'
                  }`}
                  disabled={isLoading}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword((prev) => !prev)}
                  className="absolute inset-y-0 right-0 px-3 flex items-center text-neutral-500 hover:text-neutral-700 focus:outline-none focus:ring-0 focus-visible:outline-none focus-visible:ring-0 border-0 bg-transparent"
                  aria-label={showPassword ? 'Hide password' : 'Show password'}
                  disabled={isLoading}
                >
                  {showPassword ? (
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      className="h-5 w-5"
                    >
                      <path d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6-10-6-10-6z" />
                      <circle cx="12" cy="12" r="3" />
                    </svg>
                  ) : (
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      className="h-5 w-5"
                    >
                      <path d="M17.94 17.94A10.94 10.94 0 0 1 12 20c-6.5 0-10-8-10-8a19.77 19.77 0 0 1 5.06-6.94" />
                      <path d="M9.9 4.24A10.94 10.94 0 0 1 12 4c6.5 0 10 8 10 8a19.77 19.77 0 0 1-2.66 3.94" />
                      <path d="M14.12 14.12A3 3 0 0 1 9.88 9.88" />
                      <path d="M1 1l22 22" />
                    </svg>
                  )}
                </button>
              </div>
              {fieldErrors.password && (
                <p className="mt-2 text-xs text-danger-600">{fieldErrors.password}</p>
              )}
            </div>
            
            {/* Submit Button */}
            <button
              type="submit"
              disabled={isLoading}
              className="w-full bg-primary-600 text-white font-medium py-2.5 px-4 rounded-xl hover:bg-primary-700 disabled:bg-neutral-400 transition duration-200 shadow-sm hover:shadow-md"
            >
              {isLoading ? 'Signing in...' : 'Sign In'}
            </button>
          </form>

          <div className="mt-6 text-center text-xs text-neutral-500">
            Protected by campus SSO policies
          </div>
        </div>
      </div>
    </div>
  );
}

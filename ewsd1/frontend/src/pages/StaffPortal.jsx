// src/pages/StaffPortal.jsx
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import SubmitIdeaForm from '../components/Staff/Staff_SubmitIdeaForm';
import IdeasList from '../components/Staff/Staff_IdeasList';
import NotificationsPanel from '../components/Staff/Staff_NotificationsPanel';
import IdeaDetail from '../components/Staff/Staff_IdeaDetail';
import WelcomeBackModal from '../components/WelcomeBackModal';

export default function StaffPortal() {
  const [activeTab, setActiveTab] = useState('browse');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [unreadCount, setUnreadCount] = useState(0);
  const [selectedIdeaId, setSelectedIdeaId] = useState(null);
  const [isWelcomeOpen, setIsWelcomeOpen] = useState(false);

  const navigate = useNavigate();
  const { user, logout, isAuthenticated } = useAuthStore();

  const loginAt = localStorage.getItem('loginAt');
  const lastLoginAt = localStorage.getItem('lastLoginAt');
  const formattedLoginAt = lastLoginAt ? new Date(lastLoginAt).toLocaleString() : '-';

  useEffect(() => {
    if (!isAuthenticated() || user?.role === 'Admin') {
      navigate('/login');
    }
  }, [navigate, isAuthenticated, user]);

  useEffect(() => {
    if (!loginAt) return;
    const key = `welcome_shown:${loginAt}`;
    if (!localStorage.getItem(key)) {
      setIsWelcomeOpen(true);
      localStorage.setItem(key, '1');
    }
  }, [loginAt]);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const handleIdeaSubmitted = () => {
    setSuccess('Idea submitted successfully.');
    setActiveTab('browse');
    setTimeout(() => setSuccess(''), 5000);
  };

  const communityName = `r/${(user?.department || 'department').toLowerCase().replace(/\s+/g, '-')}`;

  return (
    <div className="min-h-screen bg-slate-200">
      <header className="bg-white border-b border-slate-300 sticky top-0 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3">
          <div className="flex justify-between items-center">
            <div className="flex items-center gap-3">
              <div className="h-8 w-8 rounded-full bg-orange-500 text-white font-bold grid place-items-center">
                i
              </div>
              <div>
                <h1 className="text-lg font-semibold text-slate-900">CampusIdeas</h1>
                <p className="text-xs text-slate-500">{communityName} | {user?.full_name || user?.name || 'Staff'}</p>
                {lastLoginAt && (
                  <p className="text-[11px] text-slate-500">Last login: {formattedLoginAt}</p>
                )}
              </div>
            </div>

            <div className="flex items-center gap-3">
              <NotificationsPanel onUnreadChange={setUnreadCount} />
              <button
                onClick={handleLogout}
                className="px-4 py-2 bg-slate-900 text-white rounded-full hover:bg-slate-800 transition text-sm font-medium"
              >
                Logout
              </button>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
        {error && (
          <div className="mb-4 p-3 bg-rose-50 border border-rose-200 rounded-md flex justify-between items-center">
            <p className="text-rose-700 text-sm">{error}</p>
            <button onClick={() => setError('')} className="text-rose-700 hover:text-rose-900">x</button>
          </div>
        )}

        {success && (
          <div className="mb-4 p-3 bg-emerald-50 border border-emerald-200 rounded-md flex justify-between items-center">
            <p className="text-emerald-700 text-sm">{success}</p>
            <button onClick={() => setSuccess('')} className="text-emerald-700 hover:text-emerald-900">x</button>
          </div>
        )}

        <div className="flex gap-2 bg-white border border-slate-300 rounded-md p-1 mb-4">
          {[
            { id: 'browse', label: 'Browse Feed' },
            { id: 'submit', label: 'Create Post' },
          ].map((tab) => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`px-4 py-2 text-sm font-medium transition rounded-md whitespace-nowrap ${
                activeTab === tab.id ? 'bg-slate-900 text-white' : 'text-slate-700 hover:bg-slate-100'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {activeTab === 'browse' && (
          <div>
            <div className="mb-4 px-1">
              <p className="text-xs text-slate-500 mt-1">Unread notifications: {unreadCount}</p>
            </div>
            <IdeasList onError={setError} onSelectIdea={setSelectedIdeaId} />
          </div>
        )}

        {activeTab === 'submit' && (
          <div className="bg-white border border-slate-300 rounded-md p-4">
            <div className="mb-6 border-b border-slate-200 pb-3">
              <h2 className="text-lg font-semibold text-slate-900 mb-1">Create an idea post</h2>
              <p className="text-sm text-slate-600">Write clearly and provide useful details so others can discuss and vote.</p>
            </div>
            <SubmitIdeaForm onSuccess={handleIdeaSubmitted} onError={setError} />
          </div>
        )}

        {selectedIdeaId && (
          <IdeaDetail
            ideaId={selectedIdeaId}
            onClose={() => setSelectedIdeaId(null)}
          />
        )}
      </main>

      <WelcomeBackModal
        isOpen={isWelcomeOpen}
        onClose={() => setIsWelcomeOpen(false)}
        displayName={user?.full_name || user?.name || 'Staff'}
        lastLoginAt={lastLoginAt}
        loginAt={loginAt}
      />
    </div>
  );
}

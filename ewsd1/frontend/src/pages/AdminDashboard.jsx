import { useEffect, useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import apiClient from '../services/api';
import AdminUsersTab from '../components/AdminUsersTab';
import AdminDepartmentsTab from '../components/AdminDepartmentsTab';
import SessionsTab from '../components/SessionsTab';
import AcademicYearsTab from '../components/AcademicYearsTab';
import AdminConfigTab from '../components/AdminConfigTab';
import AdminBackupTab from '../components/AdminBackupTab';
import AdminMonitoringTab from '../components/AdminMonitoringTab';
import AdminModerationTab from '../components/AdminModerationTab';
import Modal from '../components/Modal';
import NotificationsPanel from '../components/NotificationsPanel';
import WelcomeBackModal from '../components/WelcomeBackModal';

const NOTIFICATIONS_READ_KEY = 'notification_read_ids:/admin_management.php?action=notifications';

const loadNotificationReadIds = () => {
  try {
    const raw = localStorage.getItem(NOTIFICATIONS_READ_KEY);
    const parsed = raw ? JSON.parse(raw) : [];
    return Array.isArray(parsed) ? parsed : [];
  } catch (error) {
    return [];
  }
};

function SidebarIcon({ active, children, label, onClick }) {
  return (
    <button
      type="button"
      aria-label={label}
      onClick={onClick}
      className={`group relative flex h-11 w-11 items-center justify-center rounded-xl border transition-[transform,box-shadow,background-color,color,border-color] duration-200 ease-out will-change-transform active:scale-[0.99] ${
        active
          ? 'border-primary-200 bg-primary-50 text-primary-600 shadow-[0_10px_20px_-14px_rgba(14,165,233,0.9)]'
          : 'border-transparent bg-white text-neutral-500 hover:border-neutral-200 hover:text-neutral-700'
      }`}
    >
      {children}
    </button>
  );
}

function StatCard({ title, value, change, tone, children }) {
  const toneClass =
    tone === 'emerald'
      ? 'from-emerald-100 via-emerald-50 to-white text-emerald-700'
      : 'from-sky-100 via-sky-50 to-white text-sky-700';

  return (
    <article className="group relative overflow-hidden rounded-[12px] border border-neutral-200 bg-white p-5 shadow-[0_8px_24px_-18px_rgba(15,23,42,0.35)] transition-[transform,box-shadow,border-color] duration-300 ease-out hover:-translate-y-[2px] hover:border-sky-200 hover:shadow-[0_20px_36px_-28px_rgba(15,23,42,0.45)]">
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_100%_0%,rgba(14,165,233,0.10),transparent_42%)] opacity-0 transition-opacity duration-300 group-hover:opacity-100" />
      <div className="flex items-start justify-between gap-4">
        <div className="relative z-10">
          <p className="text-sm font-medium text-neutral-500 transition-colors duration-300 group-hover:text-neutral-700">{title}</p>
          <p className="mt-2 text-3xl font-semibold tracking-tight text-neutral-900 transition-transform duration-300 group-hover:translate-x-[1px]">{value}</p>
          <p className="mt-2 text-sm font-medium text-emerald-600 transition-colors duration-300 group-hover:text-emerald-700">{change}</p>
        </div>
        <div className={`relative z-10 rounded-xl bg-gradient-to-br p-3 transition-transform duration-300 ease-out group-hover:scale-110 group-hover:-rotate-3 ${toneClass}`}>{children}</div>
      </div>
    </article>
  );
}

function MiniBars() {
  const bars = [62, 38, 55, 74, 49, 82, 63];
  return (
    <div className="flex h-36 items-end gap-2">
      {bars.map((height, idx) => (
        <div
          key={height + idx}
          className="w-7 origin-bottom rounded-t-lg bg-gradient-to-t from-sky-500 to-emerald-400 opacity-90 transition-transform duration-300 ease-out group-hover:-translate-y-[2px] group-hover:scale-y-105"
          style={{ height: `${height}%`, transitionDelay: `${idx * 26}ms` }}
        />
      ))}
    </div>
  );
}

export default function AdminDashboard() {
  const [activeTab, setActiveTab] = useState('users');
  const [activeMenu, setActiveMenu] = useState('overview');
  const [error, setError] = useState('');
  const [systemReport, setSystemReport] = useState(null);
  const [searchInput, setSearchInput] = useState('');
  const [appliedSearchTerm, setAppliedSearchTerm] = useState('');
  const [isSwitching, setIsSwitching] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [notificationCount, setNotificationCount] = useState(0);
  const [isWelcomeOpen, setIsWelcomeOpen] = useState(false);
  const [loadedTabs, setLoadedTabs] = useState({
    users: true,
    departments: false,
    sessions: false,
    academic: false,
    config: false,
    backups: false,
    monitoring: false,
    moderation: false,
  });

  const navigate = useNavigate();
  const { user, logout } = useAuthStore();
  const switchTimerRef = useRef(null);
  const searchInputRef = useRef(null);
  const notificationsTimerRef = useRef(null);

  const displayName = user?.full_name || 'Administrator';
  const loginAt = localStorage.getItem('loginAt');
  const lastLoginAt = localStorage.getItem('lastLoginAt');
  const formattedLoginAt = lastLoginAt ? new Date(lastLoginAt).toLocaleString() : '-';
  const initials = useMemo(
    () =>
      displayName
        .split(' ')
        .filter(Boolean)
        .slice(0, 2)
        .map((part) => part[0]?.toUpperCase())
        .join('') || 'AD',
    [displayName],
  );

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  useEffect(() => {
    if (!loginAt) return;
    const key = `welcome_shown:${loginAt}`;
    if (!localStorage.getItem(key)) {
      setIsWelcomeOpen(true);
      localStorage.setItem(key, '1');
    }
  }, [loginAt]);

  const menuTabsMap = useMemo(
    () => ({
      overview: [
        { id: 'users', label: 'User Management' },
        { id: 'departments', label: 'Departments' },
        { id: 'sessions', label: 'Session Settings' },
        { id: 'academic', label: 'Academic Years' },
        { id: 'config', label: 'System Config' },
        { id: 'backups', label: 'Backup' },
        { id: 'monitoring', label: 'Monitoring' },
        { id: 'moderation', label: 'Moderation' },
      ],
      analytics: [
        { id: 'monitoring', label: 'Monitoring' },
        { id: 'backups', label: 'Backup' },
      ],
      team: [
        { id: 'users', label: 'User Management' },
        { id: 'departments', label: 'Departments' },
      ],
      settings: [
        { id: 'config', label: 'System Config' },
        { id: 'sessions', label: 'Session Settings' },
        { id: 'academic', label: 'Academic Years' },
        { id: 'moderation', label: 'Moderation' },
      ],
    }),
    [],
  );

  const visibleTabs = menuTabsMap[activeMenu] || menuTabsMap.overview;
  const searchPlaceholder = useMemo(() => {
    if (activeTab === 'users') return 'Search users...';
    if (activeTab === 'departments') return 'Search departments...';
    if (activeTab === 'sessions') return 'Search sessions...';
    if (activeTab === 'academic') return 'Search academic years...';
    return 'Search...';
  }, [activeTab]);

  useEffect(() => {
    return () => {
      if (switchTimerRef.current) {
        clearTimeout(switchTimerRef.current);
      }
    };
  }, []);

  useEffect(() => {
    const handleGlobalShortcut = (event) => {
      const isSearchShortcut = (event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'k';
      if (!isSearchShortcut) {
        return;
      }

      event.preventDefault();
      searchInputRef.current?.focus();
      searchInputRef.current?.select();
    };

    window.addEventListener('keydown', handleGlobalShortcut);
    return () => window.removeEventListener('keydown', handleGlobalShortcut);
  }, []);

  useEffect(() => {
    const fetchNotificationCount = async () => {
      try {
        const response = await apiClient.get('/admin_management.php', { params: { action: 'notifications' } });
        const rows = response.data.data || [];
        const readIds = loadNotificationReadIds();
        const unread = rows.filter((row) => !readIds.includes(row.id)).length;
        setNotificationCount(unread);
      } catch (err) {
        setNotificationCount(0);
      }
    };

    fetchNotificationCount();
    notificationsTimerRef.current = setInterval(fetchNotificationCount, 60000);
    return () => {
      if (notificationsTimerRef.current) {
        clearInterval(notificationsTimerRef.current);
      }
    };
  }, []);

  useEffect(() => {
    let isMounted = true;

    const fetchSystemReport = async () => {
      try {
        const response = await apiClient.get('/admin_management.php', { params: { action: 'system_report' } });
        if (isMounted) {
          setSystemReport(response.data.data || null);
        }
      } catch (err) {
        if (isMounted) {
          setSystemReport(null);
          setError(err.response?.data?.message || 'Failed to load system report');
        }
      }
    };

    fetchSystemReport();
    return () => {
      isMounted = false;
    };
  }, []);

  const formatCount = (value) => Number(value || 0).toLocaleString();

  const startSoftTransition = () => {
    setIsSwitching(true);
    if (switchTimerRef.current) {
      clearTimeout(switchTimerRef.current);
    }
    switchTimerRef.current = setTimeout(() => {
      setIsSwitching(false);
    }, 160);
  };

  const ensureTabLoaded = (tabId) => {
    setLoadedTabs((prev) => (prev[tabId] ? prev : { ...prev, [tabId]: true }));
  };

  const handleMenuChange = (menuId) => {
    if (menuId === activeMenu) {
      return;
    }

    const nextTabs = menuTabsMap[menuId] || menuTabsMap.overview;
    const tabStillVisible = nextTabs.some((tab) => tab.id === activeTab);
    const nextActiveTab = tabStillVisible ? activeTab : (nextTabs[0]?.id || activeTab);

    startSoftTransition();
    setActiveMenu(menuId);
    setActiveTab(nextActiveTab);
    ensureTabLoaded(nextActiveTab);
  };

  const handleTabChange = (tabId) => {
    if (tabId === activeTab) {
      return;
    }
    startSoftTransition();
    setActiveTab(tabId);
    ensureTabLoaded(tabId);
  };

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    setAppliedSearchTerm(searchInput.trim());
  };

  const handleClearSearch = () => {
    setSearchInput('');
    setAppliedSearchTerm('');
    searchInputRef.current?.focus();
  };

  const handleOpenNotifications = () => {
    setIsNotificationsOpen(true);
    setNotificationCount(0);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-white via-neutral-50 to-slate-100/70 text-neutral-900">
      <div className="mx-auto flex w-full max-w-[1920px] gap-4 px-3 py-4 sm:px-5 lg:gap-6 lg:px-6 xl:px-8 2xl:px-10">
        <aside className="hidden w-20 flex-col items-center rounded-[12px] border border-neutral-200 bg-white py-5 shadow-[0_14px_28px_-24px_rgba(15,23,42,0.45)] md:flex">
          <div className="mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-gradient-to-br from-sky-500 to-emerald-400 text-lg font-bold text-white">
            A
          </div>

          <button
            type="button"
            onClick={handleLogout}
            className="mb-8 flex h-11 w-11 items-center justify-center rounded-xl border border-danger-100 bg-danger-50 text-danger-600 transition hover:bg-danger-100"
            aria-label="Logout"
            title="Logout"
          >
            <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
              <path d="M16 17l5-5-5-5M21 12H9M13 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h8" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </button>

          <div className="space-y-3">
            <SidebarIcon active={activeMenu === 'overview'} label="Overview" onClick={() => handleMenuChange('overview')}>
              <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path d="M4 4h7v7H4zM13 4h7v4h-7zM13 10h7v10h-7zM4 13h7v7H4z" />
              </svg>
            </SidebarIcon>
            <SidebarIcon active={activeMenu === 'analytics'} label="Analytics" onClick={() => handleMenuChange('analytics')}>
              <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path d="M5 19V9m7 10V5m7 14v-7" strokeLinecap="round" />
              </svg>
            </SidebarIcon>
            <SidebarIcon active={activeMenu === 'team'} label="Team" onClick={() => handleMenuChange('team')}>
              <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path d="M16 11a4 4 0 1 0-4-4 4 4 0 0 0 4 4Zm-8 2a3 3 0 1 0-3-3 3 3 0 0 0 3 3Zm8 2c-3.314 0-6 1.343-6 3v1h12v-1c0-1.657-2.686-3-6-3ZM8 15c-2.761 0-5 1.119-5 2.5V19h5" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </SidebarIcon>
            <SidebarIcon active={activeMenu === 'settings'} label="Settings" onClick={() => handleMenuChange('settings')}>
              <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
                <path d="M12 15.5A3.5 3.5 0 1 0 12 8.5a3.5 3.5 0 0 0 0 7Zm8-3.5 2 1-2 1-.4 1.2 1.2 1.8-1.4 1.4-1.8-1.2L16 20l-1 2h-2l-1-2-1.2-.4-1.8 1.2-1.4-1.4 1.2-1.8L4 14l-2-1 2-1 .4-1.2-1.2-1.8 1.4-1.4 1.8 1.2L8 4l1-2h2l1 2 1.2.4 1.8-1.2 1.4 1.4-1.2 1.8z" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </SidebarIcon>
          </div>

        </aside>

        <main className="flex-1 space-y-5">
          <header className="rounded-[12px] border border-neutral-200 bg-white p-4 shadow-[0_10px_24px_-22px_rgba(15,23,42,0.45)] sm:p-5">
            <div className="flex flex-wrap items-center justify-between gap-4">
              <div>
                <h1 className="text-2xl font-semibold tracking-tight text-neutral-900">Admin Command Center</h1>
                <p className="mt-1 text-sm text-neutral-500">Monitor operations, staff activity, and campaign health</p>
              </div>

              <div className="flex w-full items-center gap-3 sm:w-auto">
                <form
                  role="search"
                  onSubmit={handleSearchSubmit}
                  className="flex w-full min-w-[220px] items-center rounded-xl border border-neutral-200 bg-white p-1 shadow-[0_8px_18px_-16px_rgba(15,23,42,0.35)] sm:w-[420px]"
                >
                  <span className="pointer-events-none ml-2 text-neutral-400">
                    <svg viewBox="0 0 24 24" className="h-4 w-4" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="m21 21-4.3-4.3M10 18a8 8 0 1 1 0-16 8 8 0 0 1 0 16Z" strokeLinecap="round" />
                    </svg>
                  </span>
                  <input
                    ref={searchInputRef}
                    type="text"
                    value={searchInput}
                    onChange={(e) => setSearchInput(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === 'Escape') {
                        handleClearSearch();
                      }
                    }}
                    placeholder={searchPlaceholder}
                    className="h-9 w-full bg-transparent px-3 text-sm text-neutral-700 outline-none focus:outline-none focus:ring-0 focus:ring-offset-0 focus-visible:ring-0 focus-visible:ring-offset-0"
                  />
                  {searchInput && (
                    <button
                      type="button"
                      onClick={handleClearSearch}
                      aria-label="Clear search"
                      className="mr-1 rounded-md p-1 text-neutral-400 transition hover:bg-neutral-100 hover:text-neutral-700"
                    >
                      <svg viewBox="0 0 24 24" className="h-4 w-4" fill="none" stroke="currentColor" strokeWidth="2">
                        <path d="M18 6 6 18M6 6l12 12" strokeLinecap="round" />
                      </svg>
                    </button>
                  )}
                  <button
                    type="submit"
                    className="rounded-lg bg-gradient-to-r from-sky-600 to-emerald-500 px-3 py-1.5 text-xs font-semibold text-white transition hover:from-sky-700 hover:to-emerald-600"
                  >
                    Search
                  </button>
                </form>

                <div className="flex items-center gap-3">
                  <div className="rounded-xl bg-white p-2 shadow-[0_8px_18px_-16px_rgba(15,23,42,0.35)]">
                    <button
                      type="button"
                      onClick={handleOpenNotifications}
                      className="relative flex h-9 w-9 items-center justify-center rounded-xl border border-neutral-200 bg-white text-neutral-600 transition hover:bg-neutral-100"
                      aria-label="Notifications"
                      title="Notifications"
                    >
                      <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth="1.8">
                        <path d="M4 6h16a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2Z" strokeLinecap="round" strokeLinejoin="round" />
                        <path d="m22 8-10 6L2 8" strokeLinecap="round" strokeLinejoin="round" />
                      </svg>
                      {notificationCount > 0 && (
                        <span className="absolute -top-1 -right-1 min-w-[18px] rounded-full bg-danger-600 px-1 text-[10px] font-semibold text-white">
                          {notificationCount > 99 ? '99+' : notificationCount}
                        </span>
                      )}
                    </button>
                  </div>

                  <div className="flex items-center gap-3 rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2">
                    <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-gradient-to-br from-sky-500 to-emerald-400 text-sm font-semibold text-white">
                      {initials}
                    </div>
                  <div className="leading-tight">
                    <p className="text-sm font-medium text-neutral-800">{displayName}</p>
                    <p className="text-xs text-neutral-500">System Administrator</p>
                    {lastLoginAt && (
                      <p className="text-[11px] text-neutral-500">Last login: {formattedLoginAt}</p>
                    )}
                  </div>
                </div>
                </div>
              </div>
            </div>
          </header>

          {error && (
            <div className="rounded-[12px] border border-danger-200 bg-danger-50 px-4 py-3 text-sm text-danger-700">
              {error}
            </div>
          )}

          <div className={`space-y-5 transition-[opacity,transform] duration-150 ease-out ${isSwitching ? 'opacity-75 translate-y-[2px]' : 'opacity-100 translate-y-0'}`}>
            {(activeMenu === 'overview' || activeMenu === 'analytics') && (
              <section className="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-4">
                <StatCard title="Total Admin Users" value={formatCount(systemReport?.totals?.total_users)} change="All admin accounts in system" tone="blue">
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M16 11a4 4 0 1 0-4-4 4 4 0 0 0 4 4Zm-8 2a3 3 0 1 0-3-3 3 3 0 0 0 3 3Zm8 2c-3.314 0-6 1.343-6 3v1h12v-1c0-1.657-2.686-3-6-3Z" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
                <StatCard title="Active Admin Users" value={formatCount(systemReport?.totals?.active_users)} change="Enabled accounts currently active" tone="emerald">
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M8 7V5a4 4 0 0 1 8 0v2m-9 0h10a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2Z" strokeLinecap="round" strokeLinejoin="round" />
                    <path d="M12 12v2" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
                <StatCard title="Active Sessions" value={formatCount(systemReport?.totals?.active_sessions)} change="Live admin sessions right now" tone="blue">
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M4 17l5-5 3 3 8-8M14 7h6v6" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
                <StatCard title="Total Documents" value={formatCount(systemReport?.totals?.total_documents)} change="Files uploaded to ideas" tone="emerald">
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M8 4h6l4 4v12a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2Z" strokeLinecap="round" strokeLinejoin="round" />
                    <path d="M14 4v4h4" strokeLinecap="round" strokeLinejoin="round" />
                    <path d="M8 13h8M8 17h5" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
              </section>
            )}

            <section className="rounded-[12px] border border-neutral-200 bg-white p-4 shadow-[0_12px_30px_-26px_rgba(15,23,42,0.5)] sm:p-5">
              <div className="mb-3 text-sm font-medium text-neutral-500">
                {activeMenu === 'overview' && 'Management'}
                {activeMenu === 'analytics' && 'Analytics Actions'}
                {activeMenu === 'team' && 'Team Management'}
                {activeMenu === 'settings' && 'System Settings'}
              </div>
              <div className="mb-4 flex flex-wrap gap-2 border-b border-neutral-100 pb-3">
                {visibleTabs.map((tab) => (
                  <button
                    key={tab.id}
                    type="button"
                    onClick={() => handleTabChange(tab.id)}
                    className={`rounded-xl px-4 py-2 text-sm font-medium transition-[transform,box-shadow,background-color,color] duration-200 ease-out will-change-transform active:scale-[0.98] ${
                      activeTab === tab.id
                        ? 'bg-sky-50 text-sky-700 ring-1 ring-sky-200 shadow-[0_10px_20px_-14px_rgba(14,165,233,0.9)]'
                        : 'text-neutral-500 hover:bg-neutral-100 hover:text-neutral-700'
                    }`}
                  >
                    {tab.label}
                  </button>
                ))}
              </div>

              {loadedTabs.users && (
                <div className={activeTab === 'users' ? 'block' : 'hidden'}>
                  <AdminUsersTab onError={setError} searchTerm={appliedSearchTerm} />
                </div>
              )}
              {loadedTabs.departments && (
                <div className={activeTab === 'departments' ? 'block' : 'hidden'}>
                  <AdminDepartmentsTab onError={setError} searchTerm={appliedSearchTerm} />
                </div>
              )}
              {loadedTabs.sessions && (
                <div className={activeTab === 'sessions' ? 'block' : 'hidden'}>
                  <SessionsTab onError={setError} searchTerm={appliedSearchTerm} />
                </div>
              )}
              {loadedTabs.academic && (
                <div className={activeTab === 'academic' ? 'block' : 'hidden'}>
                  <AcademicYearsTab onError={setError} searchTerm={appliedSearchTerm} />
                </div>
              )}
              {loadedTabs.config && (
                <div className={activeTab === 'config' ? 'block' : 'hidden'}>
                  <AdminConfigTab onError={setError} />
                </div>
              )}
              {loadedTabs.backups && (
                <div className={activeTab === 'backups' ? 'block' : 'hidden'}>
                  <AdminBackupTab onError={setError} />
                </div>
              )}
              {loadedTabs.monitoring && (
                <div className={activeTab === 'monitoring' ? 'block' : 'hidden'}>
                  <AdminMonitoringTab onError={setError} />
                </div>
              )}
              {loadedTabs.moderation && (
                <div className={activeTab === 'moderation' ? 'block' : 'hidden'}>
                  <AdminModerationTab onError={setError} />
                </div>
              )}
            </section>
          </div>
        </main>
      </div>

      <Modal isOpen={isNotificationsOpen} onClose={() => setIsNotificationsOpen(false)}>
        <NotificationsPanel
          onError={setError}
          endpoint="/admin_management.php?action=notifications"
          title="Admin Email Notifications"
          onMarkedRead={() => setNotificationCount(0)}
        />
      </Modal>

      <WelcomeBackModal
        isOpen={isWelcomeOpen}
        onClose={() => setIsWelcomeOpen(false)}
        displayName={displayName}
        lastLoginAt={lastLoginAt}
        loginAt={loginAt}
      />
    </div>
  );
}

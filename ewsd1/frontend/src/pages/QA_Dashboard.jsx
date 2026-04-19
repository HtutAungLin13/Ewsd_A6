import { useEffect, useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import apiClient from '../services/api';
import CategoryManagement from '../components/QA_CategoryManagement';
import IdeasManagement from '../components/QA_IdeasManagement';
import StatisticsReports from '../components/QA_StatisticsReports';
import UserAccountManagement from '../components/QA_UserAccountManagement';
import InappropriateContent from '../components/QA_InappropriateContent';
import QAMonitoringSecurity from '../components/QA_MonitoringSecurity';
import QADepartmentsTab from '../components/QADepartmentsTab';
import SessionManagement from '../components/QA_SessionManagement';
import Modal from '../components/Modal';
import NotificationsPanel from '../components/NotificationsPanel';
import WelcomeBackModal from '../components/WelcomeBackModal';

const NOTIFICATIONS_READ_KEY = 'notification_read_ids:/qa_management.php?action=notifications';

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

function MiniBars({ data }) {
  const maxValue = Math.max(1, ...data.map((item) => item.total));
  return (
    <div className="flex h-36 items-end gap-2">
      {data.map((item, idx) => {
        const height = Math.round((item.total / maxValue) * 100);
        return (
          <div
            key={item.day}
            title={`${item.label}: ${item.total} items (Ideas ${item.ideas}, Comments ${item.comments})`}
            className="w-7 origin-bottom rounded-t-lg bg-gradient-to-t from-sky-500 to-emerald-400 opacity-90 transition-transform duration-300 ease-out group-hover:-translate-y-[2px] group-hover:scale-y-105"
            style={{ height: `${height}%`, transitionDelay: `${idx * 26}ms` }}
          />
        );
      })}
    </div>
  );
}

export default function QAManagerDashboard() {
  const [activeTab, setActiveTab] = useState('categories');
  const [activeMenu, setActiveMenu] = useState('overview');
  const [error, setError] = useState('');
  const [qaMetrics, setQaMetrics] = useState(null);
  const [isSwitching, setIsSwitching] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [notificationCount, setNotificationCount] = useState(0);
  const [isWelcomeOpen, setIsWelcomeOpen] = useState(false);
  const [loadedTabs, setLoadedTabs] = useState({
    categories: true,
    ideas: false,
    statistics: false,
    users: false,
    departments: false,
    sessions: false,
    inappropriate: false,
    monitoring: false,
  });

  const navigate = useNavigate();
  const { user, logout, isAuthenticated } = useAuthStore();
  const switchTimerRef = useRef(null);
  const notificationsTimerRef = useRef(null);

  const displayName = user?.full_name || 'QA Manager';
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
        .join('') || 'QM',
    [displayName],
  );

  useEffect(() => {
    if (!isAuthenticated() || (user && user.role !== 'QAManager' && user.role !== 'Admin')) {
      navigate('/login');
    }
  }, [navigate, isAuthenticated, user]);

  useEffect(() => {
    return () => {
      if (switchTimerRef.current) {
        clearTimeout(switchTimerRef.current);
      }
    };
  }, []);

  useEffect(() => {
    if (!loginAt) return;
    const key = `welcome_shown:${loginAt}`;
    if (!localStorage.getItem(key)) {
      setIsWelcomeOpen(true);
      localStorage.setItem(key, '1');
    }
  }, [loginAt]);

  useEffect(() => {
    const fetchNotificationCount = async () => {
      try {
        const response = await apiClient.get('/qa_management.php', { params: { action: 'notifications' } });
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

    const fetchQaMetrics = async () => {
      try {
        const [statusRes, inappropriateRes, monitoringRes] = await Promise.all([
          apiClient.get('/qa_reports.php', { params: { action: 'ideas_status_summary' } }),
          apiClient.get('/qa_reports.php', { params: { action: 'inappropriate_stats' } }),
          apiClient.get('/qa_reports.php', { params: { action: 'monitoring_overview' } }),
        ]);

        const statusRows = statusRes.data.data || [];
        const statusMap = statusRows.reduce((acc, row) => {
          acc[row.status] = Number(row.count || 0);
          return acc;
        }, {});

        const inappropriate = inappropriateRes.data.data || {};
        const monitoring = monitoringRes.data.data || {};
        const dailySeries = buildDailySeries(
          monitoring.daily_idea_activity || [],
          monitoring.daily_comment_activity || [],
          7,
        );
        const ideas7d = dailySeries.reduce((sum, item) => sum + item.ideas, 0);
        const comments7d = dailySeries.reduce((sum, item) => sum + item.comments, 0);

        if (isMounted) {
          setQaMetrics({
            pendingIdeas: statusMap.Pending || 0,
            approvedIdeas: statusMap.Approved || 0,
            rejectedIdeas: statusMap.Rejected || 0,
            flaggedStatus: statusMap.Flagged || 0,
            flaggedIdeas: Number(inappropriate.total_flagged_ideas || 0),
            flaggedComments: Number(inappropriate.total_flagged_comments || 0),
            disabledUsers: Number(inappropriate.disabled_users || 0),
            blockedUsers: Number(inappropriate.blocked_users || 0),
            dailySeries,
            ideas7d,
            comments7d,
            lastUpdated: new Date(),
          });
          setError('');
        }
      } catch (err) {
        if (isMounted) {
          setQaMetrics(null);
          setError(err.response?.data?.message || 'Failed to load QA metrics');
        }
      }
    };

    fetchQaMetrics();
    const refreshTimer = setInterval(fetchQaMetrics, 60000);
    return () => {
      isMounted = false;
      clearInterval(refreshTimer);
    };
  }, []);

  const menuTabsMap = useMemo(
    () => ({
      overview: [
        { id: 'categories', label: 'Category Management' },
        { id: 'ideas', label: 'Ideas & Oversight' },
        { id: 'statistics', label: 'Statistics & Export' },
        { id: 'sessions', label: 'Session Settings' },
        { id: 'users', label: 'User Controls' },
        { id: 'departments', label: 'Departments' },
        { id: 'inappropriate', label: 'Moderation' },
        { id: 'monitoring', label: 'Monitoring & Security' },
      ],
      analytics: [
        { id: 'statistics', label: 'Statistics & Export' },
        { id: 'monitoring', label: 'Monitoring & Security' },
      ],
      team: [
        { id: 'users', label: 'User Controls' },
        { id: 'ideas', label: 'Ideas & Oversight' },
        { id: 'departments', label: 'Departments' },
      ],
      settings: [
        { id: 'sessions', label: 'Session Settings' },
        { id: 'categories', label: 'Category Management' },
        { id: 'departments', label: 'Departments' },
        { id: 'inappropriate', label: 'Moderation' },
      ],
    }),
    [],
  );

  const visibleTabs = menuTabsMap[activeMenu] || menuTabsMap.overview;

  const formatCount = (value) => {
    if (value === null || value === undefined) return '-';
    return Number(value).toLocaleString();
  };

  const buildDailySeries = (ideaRows = [], commentRows = [], days = 7) => {
    const map = new Map();
    ideaRows.forEach((row) => {
      const day = row.day;
      if (!day) return;
      map.set(day, { day, ideas: Number(row.ideas || 0), comments: 0 });
    });
    commentRows.forEach((row) => {
      const day = row.day;
      if (!day) return;
      const current = map.get(day) || { day, ideas: 0, comments: 0 };
      current.comments = Number(row.comments || 0);
      map.set(day, current);
    });

    const results = [];
    for (let i = days - 1; i >= 0; i -= 1) {
      const date = new Date();
      date.setDate(date.getDate() - i);
      const key = date.toISOString().slice(0, 10);
      const item = map.get(key) || { ideas: 0, comments: 0 };
      results.push({
        day: key,
        label: date.toLocaleDateString(undefined, { weekday: 'short' }),
        ideas: item.ideas || 0,
        comments: item.comments || 0,
        total: (item.ideas || 0) + (item.comments || 0),
      });
    }
    return results;
  };

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
    if (menuId === activeMenu) return;
    const nextTabs = menuTabsMap[menuId] || menuTabsMap.overview;
    const tabStillVisible = nextTabs.some((tab) => tab.id === activeTab);
    const nextActiveTab = tabStillVisible ? activeTab : (nextTabs[0]?.id || activeTab);
    startSoftTransition();
    setActiveMenu(menuId);
    setActiveTab(nextActiveTab);
    ensureTabLoaded(nextActiveTab);
  };

  const handleTabChange = (tabId) => {
    if (tabId === activeTab) return;
    startSoftTransition();
    setActiveTab(tabId);
    ensureTabLoaded(tabId);
  };

  const handleLogout = () => {
    logout();
    navigate('/login');
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
            Q
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
                <h1 className="text-2xl font-semibold tracking-tight text-neutral-900">QA Manager Command Center</h1>
                <p className="mt-1 text-sm text-neutral-500">Review submissions, moderate content, and monitor platform quality</p>
              </div>

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
                    <p className="text-xs text-neutral-500">QA Manager</p>
                    {lastLoginAt && (
                      <p className="text-[11px] text-neutral-500">Last login: {formattedLoginAt}</p>
                    )}
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
              <section className="grid grid-cols-1 gap-4 xl:grid-cols-3">
                <StatCard
                  title="Pending Reviews"
                  value={formatCount(qaMetrics ? qaMetrics.pendingIdeas : null)}
                  change={`Approved: ${formatCount(qaMetrics?.approvedIdeas)} • Rejected: ${formatCount(qaMetrics?.rejectedIdeas)}`}
                  tone="blue"
                >
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M12 8v5l3 3M22 12A10 10 0 1 1 12 2a10 10 0 0 1 10 10Z" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
                <StatCard
                  title="Flagged Content"
                  value={formatCount(
                    qaMetrics ? (qaMetrics.flaggedIdeas || 0) + (qaMetrics.flaggedComments || 0) : null,
                  )}
                  change={`Ideas: ${formatCount(qaMetrics?.flaggedIdeas)} • Comments: ${formatCount(qaMetrics?.flaggedComments)}`}
                  tone="emerald"
                >
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M12 3 4 7v6c0 5.2 3.4 9.8 8 11 4.6-1.2 8-5.8 8-11V7l-8-4Z" strokeLinecap="round" strokeLinejoin="round" />
                  </svg>
                </StatCard>
                <StatCard
                  title="User Enforcement"
                  value={formatCount(
                    qaMetrics ? (qaMetrics.disabledUsers || 0) + (qaMetrics.blockedUsers || 0) : null,
                  )}
                  change={`Disabled: ${formatCount(qaMetrics?.disabledUsers)} • Blocked: ${formatCount(qaMetrics?.blockedUsers)}`}
                  tone="blue"
                >
                  <svg viewBox="0 0 24 24" className="h-6 w-6" fill="none" stroke="currentColor" strokeWidth="1.8">
                    <path d="M4 19h16M7 16V8m5 8V5m5 11v-6" strokeLinecap="round" />
                  </svg>
                </StatCard>
              </section>
            )}

            {(activeMenu === 'overview' || activeMenu === 'analytics') && (
              <section className="grid grid-cols-1 gap-4 2xl:grid-cols-[1.6fr_1fr]">
                <article className="group relative overflow-hidden rounded-[12px] border border-neutral-200 bg-white p-5 shadow-[0_10px_28px_-24px_rgba(15,23,42,0.45)] transition-[transform,box-shadow,border-color] duration-300 ease-out hover:-translate-y-[2px] hover:border-sky-200 hover:shadow-[0_24px_40px_-30px_rgba(15,23,42,0.45)]">
                  <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(130deg,rgba(14,165,233,0.05),transparent_48%,rgba(16,185,129,0.05))] opacity-0 transition-opacity duration-300 group-hover:opacity-100" />
                  <div className="mb-4 flex items-center justify-between">
                    <div>
                      <h2 className="text-lg font-semibold text-neutral-900">QA Activity Pulse</h2>
                      <p className="text-sm text-neutral-500">Ideas and comment activity over the last 7 days</p>
                    </div>
                    <span className="rounded-full bg-sky-50 px-3 py-1 text-xs font-medium text-sky-700 transition-transform duration-300 group-hover:scale-105">
                      {qaMetrics?.lastUpdated
                        ? `Updated ${qaMetrics.lastUpdated.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`
                        : 'Loading'}
                    </span>
                  </div>
                  <div className="mb-3 flex flex-wrap gap-2 text-xs text-neutral-600">
                    <span className="rounded-full bg-neutral-100 px-2 py-1">Ideas: {formatCount(qaMetrics?.ideas7d)}</span>
                    <span className="rounded-full bg-neutral-100 px-2 py-1">Comments: {formatCount(qaMetrics?.comments7d)}</span>
                    <span className="rounded-full bg-neutral-100 px-2 py-1">Flagged status: {formatCount(qaMetrics?.flaggedStatus)}</span>
                  </div>
                  {qaMetrics?.dailySeries?.length ? (
                    <MiniBars data={qaMetrics.dailySeries} />
                  ) : (
                    <p className="text-sm text-neutral-500">No activity data yet.</p>
                  )}
                </article>

                <article className="group rounded-[12px] border border-neutral-200 bg-white p-5 shadow-[0_10px_28px_-24px_rgba(15,23,42,0.45)] transition-[transform,box-shadow,border-color] duration-300 ease-out hover:-translate-y-[2px] hover:border-emerald-200 hover:shadow-[0_24px_40px_-30px_rgba(15,23,42,0.45)]">
                  <h2 className="text-lg font-semibold text-neutral-900">QA Focus Areas</h2>
                  <p className="mt-1 text-sm text-neutral-500">Operational focus split</p>
                  <div className="mt-5 space-y-4 text-sm">
                    {(() => {
                      const pendingValue = qaMetrics?.pendingIdeas ?? 0;
                      const approvedValue = qaMetrics?.approvedIdeas ?? 0;
                      const focusTotal = pendingValue + approvedValue;
                      const focusItems = [
                        {
                          label: `Pending Review - ${formatCount(qaMetrics ? pendingValue : null)}`,
                          value: pendingValue,
                          color: 'bg-sky-500',
                        },
                        {
                          label: `Approved Ideas - ${formatCount(qaMetrics ? approvedValue : null)}`,
                          value: approvedValue,
                          color: 'bg-sky-300',
                        },
                      ];
                      return focusItems.map((item) => {
                        const percentage = focusTotal ? Math.round((item.value / focusTotal) * 100) : 0;
                        return (
                          <div key={item.label}>
                            <div className="mb-1 flex items-center justify-between text-neutral-600">
                              <span>{item.label}</span>
                              <span>{percentage}%</span>
                            </div>
                            <div className="h-2 rounded-full bg-neutral-100">
                              <div
                                className={`h-2 origin-left rounded-full ${item.color} transition-transform duration-300 ease-out group-hover:scale-x-[1.02]`}
                                style={{ width: `${percentage}%` }}
                              />
                            </div>
                          </div>
                        );
                      });
                    })()}
                  </div>
                </article>
              </section>
            )}

            <section className="rounded-[12px] border border-neutral-200 bg-white p-4 shadow-[0_12px_30px_-26px_rgba(15,23,42,0.5)] sm:p-5">
              <div className="mb-3 text-sm font-medium text-neutral-500">
                {activeMenu === 'overview' && 'QA Management'}
                {activeMenu === 'analytics' && 'QA Analytics'}
                {activeMenu === 'team' && 'QA User Oversight'}
                {activeMenu === 'settings' && 'QA Controls'}
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

              {loadedTabs.categories && (
                <div className={activeTab === 'categories' ? 'block' : 'hidden'}>
                  <CategoryManagement onError={setError} />
                </div>
              )}
              {loadedTabs.ideas && (
                <div className={activeTab === 'ideas' ? 'block' : 'hidden'}>
                  <IdeasManagement onError={setError} />
                </div>
              )}
              {loadedTabs.statistics && (
                <div className={activeTab === 'statistics' ? 'block' : 'hidden'}>
                  <StatisticsReports onError={setError} />
                </div>
              )}
              {loadedTabs.users && (
                <div className={activeTab === 'users' ? 'block' : 'hidden'}>
                  <UserAccountManagement onError={setError} />
                </div>
              )}
              {loadedTabs.departments && (
                <div className={activeTab === 'departments' ? 'block' : 'hidden'}>
                  <QADepartmentsTab onError={setError} />
                </div>
              )}
              {loadedTabs.sessions && (
                <div className={activeTab === 'sessions' ? 'block' : 'hidden'}>
                  <SessionManagement onError={setError} />
                </div>
              )}
              {loadedTabs.inappropriate && (
                <div className={activeTab === 'inappropriate' ? 'block' : 'hidden'}>
                  <InappropriateContent onError={setError} />
                </div>
              )}
              {loadedTabs.monitoring && (
                <div className={activeTab === 'monitoring' ? 'block' : 'hidden'}>
                  <QAMonitoringSecurity onError={setError} />
                </div>
              )}
            </section>
          </div>
        </main>
      </div>

      <Modal isOpen={isNotificationsOpen} onClose={() => setIsNotificationsOpen(false)}>
        <NotificationsPanel
          onError={setError}
          endpoint="/qa_management.php?action=notifications"
          title="QA Manager Email Notifications"
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



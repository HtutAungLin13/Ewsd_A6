import { useEffect, useMemo, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuthStore } from "../store/authStore";
import axios from "axios";
import Modal from "../components/Modal";
import DepartmentIdeas from "../components/Coordinator_DepartmentIdeas";
import StaffEngagement from "../components/Coordinator_StaffEngagement";
import UnfinishedComments from "../components/Coordinator_UnfinishedComments";
import ContentReporting from "../components/Coordinator_ContentReporting";
import EncouragementTools from "../components/Coordinator_EncouragementTools";
import DepartmentStats from "../components/Coordinator_DepartmentStats";
import CoordinatorNotifications from "../components/Coordinator_Notifications";
import CoordinatorSecurityCompliance from "../components/Coordinator_SecurityCompliance";
import WelcomeBackModal from "../components/WelcomeBackModal";

function SidebarIcon({ active, children, label, onClick }) {
  return (
    <button
      type="button"
      aria-label={label}
      onClick={onClick}
      className={`group relative flex h-11 w-11 items-center justify-center rounded-xl border transition-[transform,box-shadow,background-color,color,border-color] duration-200 ease-out will-change-transform active:scale-[0.99] ${
        active
          ? "border-primary-200 bg-primary-50 text-primary-600 shadow-[0_10px_20px_-14px_rgba(14,165,233,0.9)]"
          : "border-transparent bg-white text-neutral-500 hover:border-neutral-200 hover:text-neutral-700"
      }`}
    >
      {children}
    </button>
  );
}

function StatCard({ title, value, change, tone, children }) {
  const toneClass =
    tone === "emerald"
      ? "from-emerald-100 via-emerald-50 to-white text-emerald-700"
      : "from-sky-100 via-sky-50 to-white text-sky-700";

  return (
    <article className="group relative overflow-hidden rounded-[12px] border border-neutral-200 bg-white p-5 shadow-[0_8px_24px_-18px_rgba(15,23,42,0.35)] transition-[transform,box-shadow,border-color] duration-300 ease-out hover:-translate-y-[2px] hover:border-sky-200 hover:shadow-[0_20px_36px_-28px_rgba(15,23,42,0.45)]">
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_100%_0%,rgba(14,165,233,0.10),transparent_42%)] opacity-0 transition-opacity duration-300 group-hover:opacity-100" />
      <div className="flex items-start justify-between gap-4">
        <div className="relative z-10">
          <p className="text-sm font-medium text-neutral-500 transition-colors duration-300 group-hover:text-neutral-700">
            {title}
          </p>
          <p className="mt-2 text-3xl font-semibold tracking-tight text-neutral-900 transition-transform duration-300 group-hover:translate-x-[1px]">
            {value}
          </p>
          <p className="mt-2 text-sm font-medium text-emerald-600 transition-colors duration-300 group-hover:text-emerald-700">
            {change}
          </p>
        </div>
        <div
          className={`relative z-10 rounded-xl bg-gradient-to-br p-3 transition-transform duration-300 ease-out group-hover:scale-110 group-hover:-rotate-3 ${toneClass}`}
        >
          {children}
        </div>
      </div>
    </article>
  );
}

function MiniBars() {
  const bars = [54, 47, 62, 74, 58, 69, 63];
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

export default function CoordinatorDashboard() {
  const [activeTab, setActiveTab] = useState("ideas");
  const [activeMenu, setActiveMenu] = useState("overview");
  const [error, setError] = useState("");
  const [isSwitching, setIsSwitching] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [notificationCount, setNotificationCount] = useState(0);
  const [isWelcomeOpen, setIsWelcomeOpen] = useState(false);
  const [loadedTabs, setLoadedTabs] = useState({
    ideas: true,
    engagement: false,
    comments: false,
    statistics: false,
    encourage: false,
    reporting: false,
    notifications: false,
    security: false,
  });

  const navigate = useNavigate();
  const { user, logout, isAuthenticated } = useAuthStore();
  const switchTimerRef = useRef(null);
  const notificationsTimerRef = useRef(null);
  const API_BASE = "http://localhost/ewsd1/api";

  const displayName = user?.full_name || "QA Coordinator";
  const loginAt = localStorage.getItem("loginAt");
  const lastLoginAt = localStorage.getItem("lastLoginAt");
  const formattedLoginAt = lastLoginAt ? new Date(lastLoginAt).toLocaleString() : "-";
  const initials = useMemo(
    () =>
      displayName
        .split(" ")
        .filter(Boolean)
        .slice(0, 2)
        .map((part) => part[0]?.toUpperCase())
        .join("") || "QC",
    [displayName],
  );

  useEffect(() => {
    if (
      !isAuthenticated() ||
      (user && user.role !== "QACoordinator" && user.role !== "Admin")
    ) {
      navigate("/login");
    }
  }, [navigate, isAuthenticated, user]);

  useEffect(() => {
    if (!loginAt) return;
    const key = `welcome_shown:${loginAt}`;
    if (!localStorage.getItem(key)) {
      setIsWelcomeOpen(true);
      localStorage.setItem(key, "1");
    }
  }, [loginAt]);

  useEffect(() => {
    const fetchNotificationCount = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=notifications`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        const rows = response.data.data || [];
        const raw = localStorage.getItem(
          "notification_read_ids:/qa_coordinator.php?action=notifications",
        );
        const parsed = raw ? JSON.parse(raw) : [];
        const readIds = Array.isArray(parsed) ? parsed : [];
        const unread = rows.filter((row) => !readIds.includes(row.id)).length;
        setNotificationCount(unread);
      } catch (err) {
        setNotificationCount(0);
      }
    };

    fetchNotificationCount();
    notificationsTimerRef.current = setInterval(fetchNotificationCount, 10000);
    return () => {
      if (notificationsTimerRef.current) {
        clearInterval(notificationsTimerRef.current);
      }
    };
  }, []);

  useEffect(() => {
    return () => {
      if (switchTimerRef.current) {
        clearTimeout(switchTimerRef.current);
      }
    };
  }, []);

  const menuTabsMap = useMemo(
    () => ({
      overview: [
        { id: "ideas", label: "Ideas and Visibility" },
        { id: "engagement", label: "Staff Engagement" },
        { id: "comments", label: "Unanswered Comments" },
        { id: "statistics", label: "Department Monitoring" },
        { id: "encourage", label: "Encourage Participation" },
        { id: "reporting", label: "Report Content" },
        { id: "notifications", label: "Notifications" },
        { id: "security", label: "Security and Compliance" },
      ],
      analytics: [
        { id: "statistics", label: "Department Monitoring" },
        { id: "notifications", label: "Notifications" },
        { id: "security", label: "Security and Compliance" },
      ],
      team: [
        { id: "engagement", label: "Staff Engagement" },
        { id: "encourage", label: "Encourage Participation" },
        { id: "comments", label: "Unanswered Comments" },
      ],
      settings: [
        { id: "reporting", label: "Report Content" },
        { id: "security", label: "Security and Compliance" },
      ],
    }),
    [],
  );

  const visibleTabs = menuTabsMap[activeMenu] || menuTabsMap.overview;

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
    const nextActiveTab = tabStillVisible
      ? activeTab
      : nextTabs[0]?.id || activeTab;
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
    navigate("/login");
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-white via-neutral-50 to-slate-100/70 text-neutral-900">
      <div className="mx-auto flex w-full max-w-[1920px] gap-4 px-3 py-4 sm:px-5 lg:gap-6 lg:px-6 xl:px-8 2xl:px-10">
        <aside className="hidden w-20 flex-col items-center rounded-[12px] border border-neutral-200 bg-white py-5 shadow-[0_14px_28px_-24px_rgba(15,23,42,0.45)] md:flex">
          <div className="mb-3 flex h-11 w-11 items-center justify-center rounded-xl bg-gradient-to-br from-sky-500 to-emerald-400 text-lg font-bold text-white">
            C
          </div>

          <button
            type="button"
            onClick={handleLogout}
            className="mb-8 flex h-11 w-11 items-center justify-center rounded-xl border border-danger-100 bg-danger-50 text-danger-600 transition hover:bg-danger-100"
            aria-label="Logout"
            title="Logout"
          >
            <svg
              viewBox="0 0 24 24"
              className="h-5 w-5"
              fill="none"
              stroke="currentColor"
              strokeWidth="1.8"
            >
              <path
                d="M16 17l5-5-5-5M21 12H9M13 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h8"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </button>

          <div className="space-y-3">
            <SidebarIcon
              active={activeMenu === "overview"}
              label="Overview"
              onClick={() => handleMenuChange("overview")}
            >
              <svg
                viewBox="0 0 24 24"
                className="h-5 w-5"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.8"
              >
                <path d="M4 4h7v7H4zM13 4h7v4h-7zM13 10h7v10h-7zM4 13h7v7H4z" />
              </svg>
            </SidebarIcon>
            <SidebarIcon
              active={activeMenu === "analytics"}
              label="Analytics"
              onClick={() => handleMenuChange("analytics")}
            >
              <svg
                viewBox="0 0 24 24"
                className="h-5 w-5"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.8"
              >
                <path d="M5 19V9m7 10V5m7 14v-7" strokeLinecap="round" />
              </svg>
            </SidebarIcon>
            <SidebarIcon
              active={activeMenu === "team"}
              label="Team"
              onClick={() => handleMenuChange("team")}
            >
              <svg
                viewBox="0 0 24 24"
                className="h-5 w-5"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.8"
              >
                <path
                  d="M16 11a4 4 0 1 0-4-4 4 4 0 0 0 4 4Zm-8 2a3 3 0 1 0-3-3 3 3 0 0 0 3 3Zm8 2c-3.314 0-6 1.343-6 3v1h12v-1c0-1.657-2.686-3-6-3ZM8 15c-2.761 0-5 1.119-5 2.5V19h5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </SidebarIcon>
            <SidebarIcon
              active={activeMenu === "settings"}
              label="Settings"
              onClick={() => handleMenuChange("settings")}
            >
              <svg
                viewBox="0 0 24 24"
                className="h-5 w-5"
                fill="none"
                stroke="currentColor"
                strokeWidth="1.8"
              >
                <path
                  d="M12 15.5A3.5 3.5 0 1 0 12 8.5a3.5 3.5 0 0 0 0 7Zm8-3.5 2 1-2 1-.4 1.2 1.2 1.8-1.4 1.4-1.8-1.2L16 20l-1 2h-2l-1-2-1.2-.4-1.8 1.2-1.4-1.4 1.2-1.8L4 14l-2-1 2-1 .4-1.2-1.2-1.8 1.4-1.4 1.8 1.2L8 4l1-2h2l1 2 1.2.4 1.8-1.2 1.4 1.4-1.2 1.8z"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </SidebarIcon>
          </div>
        </aside>

        <main className="flex-1 space-y-5">
          <header className="rounded-[12px] border border-neutral-200 bg-white p-4 shadow-[0_10px_24px_-22px_rgba(15,23,42,0.45)] sm:p-5">
            <div className="flex flex-wrap items-center justify-between gap-4">
              <div>
                <h1 className="text-2xl font-semibold tracking-tight text-neutral-900">
                  QA Coordinator Command Center
                </h1>
                <p className="mt-1 text-sm text-neutral-500">
                  Department:{" "}
                  <span className="font-medium">
                    {user?.department || "Not assigned yet"}
                  </span>
                </p>
              </div>

              <div className="flex items-center gap-3">
                <div className="rounded-xl bg-white p-2 shadow-[0_8px_18px_-16px_rgba(15,23,42,0.35)]">
                  <button
                    type="button"
                    onClick={() => {
                      setIsNotificationsOpen(true);
                      setNotificationCount(0);
                    }}
                    className="relative flex h-9 w-9 items-center justify-center rounded-xl border border-neutral-200 bg-white text-neutral-600 transition hover:bg-neutral-100"
                    aria-label="Notifications"
                    title="Notifications"
                  >
                    <svg
                      viewBox="0 0 24 24"
                      className="h-5 w-5"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                    >
                      <path
                        d="M4 6h16a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2Z"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                      <path
                        d="m22 8-10 6L2 8"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                    </svg>
                    {notificationCount > 0 && (
                      <span className="absolute -top-1 -right-1 min-w-[18px] rounded-full bg-danger-600 px-1 text-[10px] font-semibold text-white">
                        {notificationCount > 99 ? "99+" : notificationCount}
                      </span>
                    )}
                  </button>
                </div>

                <div className="flex items-center gap-3 rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2">
                  <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-gradient-to-br from-sky-500 to-emerald-400 text-sm font-semibold text-white">
                    {initials}
                  </div>
                  <div className="leading-tight">
                    <p className="text-sm font-medium text-neutral-800">
                      {displayName}
                    </p>
                    <p className="text-xs text-neutral-500">QA Coordinator</p>
                    <p className="text-[11px] text-neutral-500">
                      {lastLoginAt && <>Last login: {formattedLoginAt}</>}
                    </p>
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

          <div
            className={`space-y-5 transition-[opacity,transform] duration-150 ease-out ${isSwitching ? "opacity-75 translate-y-[2px]" : "opacity-100 translate-y-0"}`}
          >
            <section className="rounded-[12px] border border-neutral-200 bg-white p-4 shadow-[0_12px_30px_-26px_rgba(15,23,42,0.5)] sm:p-5">
              <div className="mb-3 text-sm font-medium text-neutral-500">
                {activeMenu === "overview" && "Coordinator Workspace"}
                {activeMenu === "analytics" && "Analytics and Tracking"}
                {activeMenu === "team" && "Team Participation"}
                {activeMenu === "settings" && "Reporting and Security"}
              </div>
              <div className="mb-4 flex flex-wrap gap-2 border-b border-neutral-100 pb-3">
                {visibleTabs.map((tab) => (
                  <button
                    key={tab.id}
                    type="button"
                    onClick={() => handleTabChange(tab.id)}
                    className={`rounded-xl px-4 py-2 text-sm font-medium transition-[transform,box-shadow,background-color,color] duration-200 ease-out will-change-transform active:scale-[0.98] ${
                      activeTab === tab.id
                        ? "bg-sky-50 text-sky-700 ring-1 ring-sky-200 shadow-[0_10px_20px_-14px_rgba(14,165,233,0.9)]"
                        : "text-neutral-500 hover:bg-neutral-100 hover:text-neutral-700"
                    }`}
                  >
                    {tab.label}
                  </button>
                ))}
              </div>

              {loadedTabs.ideas && (
                <div className={activeTab === "ideas" ? "block" : "hidden"}>
                  <DepartmentIdeas onError={setError} />
                </div>
              )}
              {loadedTabs.engagement && (
                <div
                  className={activeTab === "engagement" ? "block" : "hidden"}
                >
                  <StaffEngagement onError={setError} />
                </div>
              )}
              {loadedTabs.comments && (
                <div className={activeTab === "comments" ? "block" : "hidden"}>
                  <UnfinishedComments onError={setError} />
                </div>
              )}
              {loadedTabs.statistics && (
                <div
                  className={activeTab === "statistics" ? "block" : "hidden"}
                >
                  <DepartmentStats onError={setError} />
                </div>
              )}
              {loadedTabs.encourage && (
                <div className={activeTab === "encourage" ? "block" : "hidden"}>
                  <EncouragementTools onError={setError} />
                </div>
              )}
              {loadedTabs.reporting && (
                <div className={activeTab === "reporting" ? "block" : "hidden"}>
                  <ContentReporting onError={setError} />
                </div>
              )}
              {loadedTabs.notifications && (
                <div
                  className={activeTab === "notifications" ? "block" : "hidden"}
                >
                  <CoordinatorNotifications onError={setError} />
                </div>
              )}
              {loadedTabs.security && (
                <div className={activeTab === "security" ? "block" : "hidden"}>
                  <CoordinatorSecurityCompliance onError={setError} />
                </div>
              )}
            </section>
          </div>
        </main>
      </div>

      <Modal
        isOpen={isNotificationsOpen}
        onClose={() => setIsNotificationsOpen(false)}
      >
        <CoordinatorNotifications onError={setError} />
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

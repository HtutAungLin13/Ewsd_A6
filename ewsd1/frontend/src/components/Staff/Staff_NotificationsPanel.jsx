import { useState, useEffect, useMemo } from "react";
import axios from "axios";

const API_BASE = "http://localhost/ewsd1/api";
const READ_IDS_KEY = "staff_notification_read_ids";

function loadReadIds() {
  try {
    const raw = localStorage.getItem(READ_IDS_KEY);
    const parsed = raw ? JSON.parse(raw) : [];
    return Array.isArray(parsed) ? parsed : [];
  } catch (error) {
    return [];
  }
}

function saveReadIds(ids) {
  localStorage.setItem(READ_IDS_KEY, JSON.stringify(ids));
}

export default function NotificationsPanel({ onUnreadChange }) {
  const [notifications, setNotifications] = useState([]);
  const [isOpen, setIsOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [readIds, setReadIds] = useState(loadReadIds);

  const unreadCount = useMemo(
    () => notifications.filter((item) => !item.is_read).length,
    [notifications],
  );

  const fetchNotifications = async () => {
    setIsLoading(true);
    try {
      const response = await axios.get(
        `${API_BASE}/staff_ideas.php?action=notifications&limit=50`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      const rows = response.data.data || [];
      const hydrated = rows.map((row) => ({
        ...row,
        is_read: readIds.includes(row.id),
      }));
      setNotifications(hydrated);
    } catch (error) {
      console.error("Failed to fetch notifications");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchNotifications();
    const timer = setInterval(fetchNotifications, 10000);
    return () => clearInterval(timer);
  }, [readIds]);

  useEffect(() => {
    onUnreadChange?.(unreadCount);
  }, [unreadCount]);

  const handleMarkAsRead = (notificationId) => {
    if (readIds.includes(notificationId)) {
      return;
    }
    const nextIds = [...readIds, notificationId];
    setReadIds(nextIds);
    saveReadIds(nextIds);
    setNotifications((prev) =>
      prev.map((n) => (n.id === notificationId ? { ...n, is_read: true } : n)),
    );
  };

  const handleMarkAllAsRead = () => {
    const allIds = notifications.map((n) => n.id);
    const merged = Array.from(new Set([...readIds, ...allIds]));
    setReadIds(merged);
    saveReadIds(merged);
    setNotifications((prev) => prev.map((n) => ({ ...n, is_read: true })));
  };

  const sortedNotifications = useMemo(() => {
    return [...notifications].sort((a, b) => {
      const aTime = new Date(a.created_at || 0).getTime();
      const bTime = new Date(b.created_at || 0).getTime();
      return bTime - aTime;
    });
  }, [notifications]);

  const latestNotifications = sortedNotifications.slice(0, 4);
  const remainingNotifications = sortedNotifications.slice(4);

  return (
    <div className="relative">
      <button
        onClick={() => {
          const nextOpen = !isOpen;
          setIsOpen(nextOpen);
          if (nextOpen && notifications.length > 0) {
            handleMarkAllAsRead();
          }
        }}
        className="relative p-2 text-gray-700 hover:text-gray-900 transition"
        title="Notifications"
      >
        <svg
          viewBox="0 0 24 24"
          className="h-6 w-6"
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
        {unreadCount > 0 && (
          <span className="absolute top-0 right-0 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white transform translate-x-1/2 -translate-y-1/2 bg-red-600 rounded-full">
            {unreadCount}
          </span>
        )}
      </button>

      {isOpen && (
        <div className="absolute right-0 mt-2 w-96 bg-white rounded-lg shadow-lg border border-gray-200 z-40">
          <div className="border-b border-gray-200 p-4 flex justify-between items-center">
            <h3 className="font-semibold text-gray-900">Notifications</h3>
            {notifications.length > 0 && (
              <button
                onClick={handleMarkAllAsRead}
                className="text-xs text-blue-600 hover:text-blue-700 font-medium"
              >
                Mark All Read
              </button>
            )}
          </div>

          <div className="max-h-96 overflow-y-auto">
            {isLoading ? (
              <div className="p-4 text-center text-gray-600">
                <p>Loading notifications...</p>
              </div>
            ) : notifications.length === 0 ? (
              <div className="p-8 text-center text-gray-600">
                <p className="mt-2">No notifications available yet</p>
                <p className="text-xs text-gray-500 mt-1">
                  You will see updates here once new activity arrives.
                </p>
              </div>
            ) : (
              <div className="space-y-2">
                <div className="space-y-1">
                  {latestNotifications.map((notification) => (
                    <div
                      key={notification.id}
                      className={`border-b border-gray-100 p-4 hover:bg-gray-50 transition cursor-pointer ${!notification.is_read ? "bg-blue-50" : ""}`}
                      onClick={() => handleMarkAsRead(notification.id)}
                    >
                      <div className="flex justify-between items-start gap-2">
                        <div className="flex-1">
                          <p className="font-medium text-sm text-gray-900">
                            {notification.title || "New activity update"}
                          </p>
                          <p className="text-sm text-gray-600 mt-1">
                            {notification.message ||
                              "No message details available."}
                          </p>
                          <p className="text-xs text-gray-500 mt-2">
                            {notification.created_at
                              ? new Date(
                                  notification.created_at,
                                ).toLocaleString()
                              : "Time not available"}
                          </p>
                        </div>
                        {!notification.is_read && (
                          <div className="w-2 h-2 bg-blue-600 rounded-full flex-shrink-0 mt-1" />
                        )}
                      </div>
                    </div>
                  ))}
                </div>

                {remainingNotifications.length > 0 && (
                  <div className="pt-2">
                    <p className="px-4 text-[11px] font-semibold uppercase tracking-wide text-gray-400">
                      More messages
                    </p>
                    <div className="mt-2 max-h-64 overflow-y-auto">
                      {remainingNotifications.map((notification) => (
                        <div
                          key={`more-${notification.id}`}
                          className={`border-b border-gray-100 p-4 hover:bg-gray-50 transition cursor-pointer ${!notification.is_read ? "bg-blue-50" : ""}`}
                          onClick={() => handleMarkAsRead(notification.id)}
                        >
                          <div className="flex justify-between items-start gap-2">
                            <div className="flex-1">
                              <p className="font-medium text-sm text-gray-900">
                                {notification.title || "New activity update"}
                              </p>
                              <p className="text-sm text-gray-600 mt-1">
                                {notification.message ||
                                  "No message details available."}
                              </p>
                              <p className="text-xs text-gray-500 mt-2">
                                {notification.created_at
                                  ? new Date(
                                      notification.created_at,
                                    ).toLocaleString()
                                  : "Time not available"}
                              </p>
                            </div>
                            {!notification.is_read && (
                              <div className="w-2 h-2 bg-blue-600 rounded-full flex-shrink-0 mt-1" />
                            )}
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      )}

      {isOpen && (
        <div className="fixed inset-0 z-30" onClick={() => setIsOpen(false)} />
      )}
    </div>
  );
}

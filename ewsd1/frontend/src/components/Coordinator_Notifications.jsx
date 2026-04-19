import { useEffect, useMemo, useState } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";
const READ_IDS_KEY =
  "notification_read_ids:/qa_coordinator.php?action=notifications";

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

export default function CoordinatorNotifications({ onError }) {
  const [notifications, setNotifications] = useState([]);
  const [selectedIdea, setSelectedIdea] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [readIds, setReadIds] = useState(loadReadIds);

  const loadNotifications = async () => {
    setIsLoading(true);
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
      const hydrated = rows.map((row) => ({
        ...row,
        is_read: readIds.includes(row.id),
      }));
      setNotifications(hydrated);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to load notifications");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    loadNotifications();
    const timer = setInterval(loadNotifications, 10000);
    return () => clearInterval(timer);
  }, [readIds]);

  useEffect(() => {
    if (!notifications.length) return;
    const allIds = notifications.map((item) => item.id).filter(Boolean);
    if (!allIds.length) return;
    const hasUnread = notifications.some((item) => !item.is_read);
    if (!hasUnread) return;
    const merged = Array.from(new Set([...readIds, ...allIds]));
    setReadIds(merged);
    saveReadIds(merged);
    setNotifications((prev) =>
      prev.map((item) => ({ ...item, is_read: true })),
    );
  }, [notifications]);

  const openIdea = async (ideaId) => {
    if (!ideaId) return;
    try {
      const response = await axios.get(
        `${API_BASE}/qa_coordinator.php?action=idea_detail&idea_id=${ideaId}`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setSelectedIdea(response.data.data || null);
      setIsModalOpen(true);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to open linked idea");
    }
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
    <div className="space-y-4">
      <div className="flex items-center justify-between gap-4 pr-10">
        <div>
          <h2 className="text-lg font-semibold text-neutral-900">
            Email Notifications
          </h2>
          <p className="text-xs text-neutral-500">
            Latest email alerts and messages
          </p>
        </div>
        <button
          onClick={loadNotifications}
          className="rounded-full border border-neutral-200 bg-white px-3 py-1.5 text-xs font-semibold text-neutral-700 shadow-sm transition hover:bg-neutral-100"
        >
          Refresh
        </button>
      </div>

      {isLoading ? (
        <div className="rounded-lg border border-neutral-200 bg-white p-6 text-center text-sm text-neutral-600">
          Loading notifications...
        </div>
      ) : notifications.length === 0 ? (
        <div className="rounded-xl border border-neutral-200 bg-gradient-to-br from-white via-neutral-50 to-slate-50 p-8 text-center">
          <div className="mx-auto mb-3 flex h-10 w-10 items-center justify-center rounded-full bg-sky-50 text-sky-600">
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
          </div>
          <p className="text-sm font-medium text-neutral-700">
            No email notifications yet
          </p>
          <p className="mt-1 text-xs text-neutral-500">
            New email alerts will appear here automatically.
          </p>
        </div>
      ) : (
        <div className="space-y-3">
          <div className="max-h-96 space-y-3 overflow-y-auto pr-1">
            {latestNotifications.map((item) => (
              <div
                key={item.id}
                className="group rounded-xl border border-neutral-200 bg-white p-4 shadow-sm transition hover:-translate-y-[1px] hover:border-sky-200 hover:shadow-md"
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-sm font-semibold text-neutral-900">
                      {item.title || item.notification_type || "System update"}
                    </p>
                    <p className="mt-1 text-sm text-neutral-700">
                      {item.message || "No message details provided."}
                    </p>
                  </div>
                  <span className="rounded-full bg-neutral-100 px-2 py-1 text-[10px] font-semibold text-neutral-600">
                    {item.notification_type || "General"}
                  </span>
                </div>
                <div className="mt-3 flex items-center justify-between text-xs text-neutral-500">
                  <span>
                    {item.created_at
                      ? new Date(item.created_at).toLocaleString()
                      : "Time not available"}
                  </span>
                  {item.idea_id ? (
                    <button
                      onClick={() => openIdea(item.idea_id)}
                      className="rounded-full border border-sky-200 bg-sky-50 px-3 py-1 text-xs font-semibold text-sky-700 transition hover:bg-sky-100"
                    >
                      View Idea
                    </button>
                  ) : (
                    <span className="text-xs text-neutral-400">
                      No related idea
                    </span>
                  )}
                </div>
              </div>
            ))}
            {remainingNotifications.length > 0 && (
              <div>
                <p className="text-xs font-semibold uppercase tracking-wide text-neutral-400">
                  More messages
                </p>
                <div className="mt-2 space-y-3">
                  {remainingNotifications.map((item) => (
                    <div
                      key={`more-${item.id}`}
                      className="group rounded-xl border border-neutral-200 bg-white p-4 shadow-sm transition hover:-translate-y-[1px] hover:border-sky-200 hover:shadow-md"
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <p className="text-sm font-semibold text-neutral-900">
                            {item.title ||
                              item.notification_type ||
                              "System update"}
                          </p>
                          <p className="mt-1 text-sm text-neutral-700">
                            {item.message || "No message details provided."}
                          </p>
                        </div>
                        <span className="rounded-full bg-neutral-100 px-2 py-1 text-[10px] font-semibold text-neutral-600">
                          {item.notification_type || "General"}
                        </span>
                      </div>
                      <div className="mt-3 flex items-center justify-between text-xs text-neutral-500">
                        <span>
                          {item.created_at
                            ? new Date(item.created_at).toLocaleString()
                            : "Time not available"}
                        </span>
                        {item.idea_id ? (
                          <button
                            onClick={() => openIdea(item.idea_id)}
                            className="rounded-full border border-sky-200 bg-sky-50 px-3 py-1 text-xs font-semibold text-sky-700 transition hover:bg-sky-100"
                          >
                            View Idea
                          </button>
                        ) : (
                          <span className="text-xs text-neutral-400">
                            No related idea
                          </span>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      )}

      <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
        {!selectedIdea ? (
          <div className="text-neutral-600">No idea data.</div>
        ) : (
          <div>
            <h3 className="text-lg font-semibold text-neutral-900 mb-2">
              {selectedIdea.title}
            </h3>
            <p className="text-sm text-neutral-700 mb-3">
              {selectedIdea.description}
            </p>
            <p className="text-xs text-neutral-600">
              Department: {selectedIdea.department}
            </p>
            <p className="text-xs text-neutral-600">
              Session: {selectedIdea.session_name}
            </p>
          </div>
        )}
      </Modal>
    </div>
  );
}

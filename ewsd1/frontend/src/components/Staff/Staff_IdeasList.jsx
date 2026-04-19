// src/components/Staff/Staff_IdeasList.jsx
import { useState, useEffect } from "react";
import axios from "axios";
import FilterTabs from "./Staff_FilterTabs";
import IdeaCard from "./Staff_IdeaCard";

const API_BASE = "http://localhost/ewsd1/api";

export default function IdeasList({ onError, onSelectIdea }) {
  const [ideas, setIdeas] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [categories, setCategories] = useState([]);
  const [latestComments, setLatestComments] = useState([]);
  const [filter, setFilter] = useState("latest");
  const [page, setPage] = useState(1);
  const [totalIdeas, setTotalIdeas] = useState(0);
  const [selectedSession, setSelectedSession] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const perPage = 5;

  useEffect(() => {
    const fetchSessions = async () => {
      try {
        const [sessionResponse, categoryResponse] = await Promise.all([
          axios.get(`${API_BASE}/staff_ideas.php?action=get_sessions`, {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          }),
          axios.get(`${API_BASE}/staff_ideas.php?action=get_categories`, {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          }),
        ]);

        const sessionList = sessionResponse.data.data || [];
        const categoryList = categoryResponse.data.data || [];
        setSessions(sessionList);
        setCategories(categoryList);

        if (sessionList.length > 0) {
          setSelectedSession(sessionList[0].id);
        }
      } catch (error) {
        onError?.("Failed to fetch sessions");
      }
    };

    fetchSessions();
  }, [onError]);

  useEffect(() => {
    const fetchIdeas = async () => {
      if (!selectedSession) return;

      setIsLoading(true);
      try {
        let url = `${API_BASE}/staff_ideas.php?action=get_ideas&filter=${filter}&page=${page}&per_page=${perPage}`;
        url += `&session_id=${selectedSession}`;
        if (selectedCategory) {
          url += `&category_id=${selectedCategory}`;
        }

        const response = await axios.get(url, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        });

        setIdeas(response.data.data || []);
        setTotalIdeas(response.data.pagination?.total || 0);
        onError?.("");
      } catch (error) {
        onError?.(error.response?.data?.message || "Failed to fetch ideas");
      } finally {
        setIsLoading(false);
      }
    };

    fetchIdeas();
  }, [selectedSession, selectedCategory, filter, page, onError]);

  useEffect(() => {
    const fetchLatestComments = async () => {
      if (!selectedSession) {
        setLatestComments([]);
        return;
      }
      try {
        const response = await axios.get(
          `${API_BASE}/staff_ideas.php?action=latest_comments&limit=5&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        setLatestComments(response.data.data || []);
      } catch (error) {
        setLatestComments([]);
      }
    };

    fetchLatestComments();
  }, [selectedSession]);

  const selectedSessionMeta = sessions.find(
    (s) => String(s.id) === String(selectedSession),
  );
  const totalPages = Math.max(1, Math.ceil(totalIdeas / perPage));

  return (
    <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 items-start">
      <section className="lg:col-span-8 space-y-3">
        <div className="bg-white border border-slate-300 rounded-md p-3 flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between">
          <div className="flex-1">
            <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1">
              Session
            </label>
            <select
              value={selectedSession}
              onChange={(e) => {
                setSelectedSession(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-slate-300 rounded-md focus:ring-2 focus:ring-orange-400 outline-none text-sm"
            >
              <option value="">Choose a session</option>
              {sessions.map((session) => (
                <option key={session.id} value={session.id}>
                  {session.session_name} ({session.days_until_closure}d)
                </option>
              ))}
            </select>
          </div>

          <div className="flex-1">
            <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1">
              Category
            </label>
            <select
              value={selectedCategory}
              onChange={(e) => {
                setSelectedCategory(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-slate-300 rounded-md focus:ring-2 focus:ring-orange-400 outline-none text-sm"
            >
              <option value="">All categories</option>
              {categories.map((cat) => (
                <option key={cat.id} value={cat.id}>
                  {cat.name}
                </option>
              ))}
            </select>
          </div>

          <div className="sm:w-auto">
            <FilterTabs
              activeFilter={filter}
              onFilterChange={(value) => {
                setFilter(value);
                setPage(1);
              }}
            />
          </div>
        </div>

        {isLoading ? (
          <div className="bg-white border border-slate-300 rounded-md p-8 text-center text-slate-600">
            Loading feed...
          </div>
        ) : ideas.length === 0 ? (
          <div className="bg-white border border-slate-300 rounded-md p-8 text-center">
            <p className="text-slate-700 font-medium">
              No posts in this session yet.
            </p>
            <p className="text-slate-500 text-sm mt-1">
              Switch session or create the first post.
            </p>
          </div>
        ) : (
          <>
            <div className="space-y-3">
              {ideas.map((idea) => (
                <IdeaCard
                  key={idea.id}
                  idea={idea}
                  onClick={() => onSelectIdea?.(idea.id)}
                />
              ))}
            </div>

            {totalIdeas > perPage && (
              <div className="bg-white border border-slate-300 rounded-md p-3 flex items-center justify-between">
                <button
                  type="button"
                  onClick={() => setPage((prev) => Math.max(1, prev - 1))}
                  disabled={page === 1}
                  className="px-3 py-1.5 text-sm border border-slate-300 rounded-md hover:bg-slate-100 disabled:opacity-50"
                >
                  Previous
                </button>

                <span className="text-sm text-slate-600">
                  Page {page} of {totalPages}
                </span>

                <button
                  type="button"
                  onClick={() => setPage((prev) => prev + 1)}
                  disabled={page >= totalPages}
                  className="px-3 py-1.5 text-sm border border-slate-300 rounded-md hover:bg-slate-100 disabled:opacity-50"
                >
                  Next
                </button>
              </div>
            )}
          </>
        )}
      </section>

      <aside className="lg:col-span-4 space-y-3">
        <div className="bg-white border border-slate-300 rounded-md overflow-hidden">
          <div className="bg-orange-500 text-white px-4 py-3 text-sm font-semibold">
            About This Community
          </div>
          <div className="p-4 text-sm text-slate-700 space-y-3">
            <p>
              This board collects staff ideas for departmental improvements and
              collaboration.
            </p>
            <div className="flex justify-between">
              <span className="text-slate-500">Current Session</span>
              <span className="font-medium text-slate-900">
                {selectedSessionMeta?.session_name || "N/A"}
              </span>
            </div>
            <div className="flex justify-between">
              <span className="text-slate-500">Posts Loaded</span>
              <span className="font-medium text-slate-900">{ideas.length}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-slate-500">Total Posts</span>
              <span className="font-medium text-slate-900">{totalIdeas}</span>
            </div>
          </div>
        </div>

        <div className="bg-white border border-slate-300 rounded-md p-4 text-sm text-slate-700">
          <p className="font-semibold text-slate-900 mb-2">Posting Rules</p>
          <ul className="list-disc pl-5 space-y-1">
            <li>Keep feedback constructive and specific.</li>
            <li>Do not include sensitive information.</li>
            <li>Use clear titles and practical details.</li>
          </ul>
        </div>

        <div className="bg-white border border-slate-300 rounded-md p-4 text-sm text-slate-700">
          <p className="font-semibold text-slate-900 mb-2">Latest Comments</p>
          {latestComments.length === 0 ? (
            <p className="text-slate-500">No recent comments.</p>
          ) : (
            <ul className="space-y-3">
              {latestComments.map((comment) => (
                <li
                  key={comment.id}
                  className="border-b border-slate-100 pb-2 last:border-b-0 last:pb-0"
                >
                  <p className="text-xs text-slate-500 mb-1">
                    {comment.contributor_name} on {comment.idea_title}
                  </p>
                  <p className="text-sm text-slate-700 line-clamp-2">
                    {comment.content}
                  </p>
                </li>
              ))}
            </ul>
          )}
        </div>
      </aside>
    </div>
  );
}

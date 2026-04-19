import { useState, useEffect } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

export default function DepartmentIdeas({ onError }) {
  const [ideas, setIdeas] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedSession, setSelectedSession] = useState("");
  const [scope, setScope] = useState("department");
  const [sortBy, setSortBy] = useState("latest");
  const [page, setPage] = useState(1);
  const [totalIdeas, setTotalIdeas] = useState(0);
  const [latestComments, setLatestComments] = useState([]);
  const [selectedIdeaId, setSelectedIdeaId] = useState(null);
  const [selectedIdea, setSelectedIdea] = useState(null);
  const [isDetailOpen, setIsDetailOpen] = useState(false);
  const [commentText, setCommentText] = useState("");
  const [commentAnonymous, setCommentAnonymous] = useState(false);
  const perPage = 8;

  useEffect(() => {
    const fetchSessions = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=sessions_closure_dates`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        const rows = response.data.data || [];
        setSessions(rows);
        if (rows.length > 0) {
          setSelectedSession(rows[0].id);
        }
      } catch (error) {
        onError("Failed to load sessions");
      }
    };
    fetchSessions();
  }, []);

  const loadIdeas = async () => {
    setIsLoading(true);
    try {
      const response = await axios.get(
        `${API_BASE}/qa_coordinator.php?action=ideas_feed`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
          params: {
            scope,
            sort: sortBy,
            session_id: selectedSession || undefined,
            page,
            per_page: perPage,
          },
        },
      );
      setIdeas(response.data.data || []);
      setTotalIdeas(response.data.pagination?.total || 0);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to fetch ideas");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    loadIdeas();
  }, [scope, sortBy, selectedSession, page]);

  useEffect(() => {
    const loadLatestComments = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=latest_comments&limit=8`,
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
    loadLatestComments();
  }, []);

  const openIdeaDetail = async (ideaId) => {
    try {
      setSelectedIdeaId(ideaId);
      const response = await axios.get(
        `${API_BASE}/qa_coordinator.php?action=idea_detail&idea_id=${ideaId}`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setSelectedIdea(response.data.data || null);
      setIsDetailOpen(true);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to load idea detail");
    }
  };

  const handleVote = async (ideaId, voteType) => {
    try {
      await axios.post(
        `${API_BASE}/qa_coordinator.php?action=vote_idea`,
        { idea_id: ideaId, vote_type: voteType },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      await loadIdeas();
      if (selectedIdeaId === ideaId) {
        await openIdeaDetail(ideaId);
      }
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to vote");
    }
  };

  const handleComment = async () => {
    if (!selectedIdeaId || !commentText.trim()) {
      onError("Comment text is required");
      return;
    }
    try {
      await axios.post(
        `${API_BASE}/qa_coordinator.php?action=post_comment`,
        {
          idea_id: selectedIdeaId,
          content: commentText.trim(),
          is_anonymous: commentAnonymous,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setCommentText("");
      setCommentAnonymous(false);
      await loadIdeas();
      setIsDetailOpen(false);
      setSelectedIdea(null);
      setSelectedIdeaId(null);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to post comment");
    }
  };

  return (
    <div>
      <div className="mb-6">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          Idea Visibility and Engagement
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-3 bg-white rounded-lg border border-neutral-200 p-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Scope
            </label>
            <select
              value={scope}
              onChange={(e) => {
                setScope(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg outline-none focus:ring-2 focus:ring-primary-500"
            >
              <option value="department">My Department</option>
              <option value="all">All Departments</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Sort
            </label>
            <select
              value={sortBy}
              onChange={(e) => {
                setSortBy(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg outline-none focus:ring-2 focus:ring-primary-500"
            >
              <option value="latest">Latest Ideas</option>
              <option value="popular">Most Popular</option>
              <option value="viewed">Most Viewed</option>
              <option value="comments">Most Commented</option>
              <option value="trending">Trending</option>
            </select>
          </div>

          <div className="md:col-span-2">
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Session
            </label>
            <select
              value={selectedSession}
              onChange={(e) => {
                setSelectedSession(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg outline-none focus:ring-2 focus:ring-primary-500"
            >
              <option value="">All Sessions</option>
              {sessions.map((session) => (
                <option key={session.id} value={session.id}>
                  {session.session_name} ({session.category_name})
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {isLoading ? (
        <div className="text-center py-10 text-neutral-600">
          Loading ideas...
        </div>
      ) : ideas.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200 text-neutral-600">
          No ideas found for current filters.
        </div>
      ) : (
        <>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {ideas.map((idea) => (
              <article
                key={idea.id}
                className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
              >
                <div className="flex justify-between gap-3 mb-2">
                  <h3 className="font-semibold text-neutral-900">
                    {idea.title}
                  </h3>
                  <span className="text-xs px-2 py-1 rounded bg-neutral-100 text-neutral-700">
                    {idea.department}
                  </span>
                </div>
                <p className="text-sm text-neutral-700 line-clamp-2 mb-3">
                  {idea.description}
                </p>
                <div className="flex flex-wrap gap-3 text-xs text-neutral-600 mb-3">
                  <span>Views: {idea.view_count}</span>
                  <span>Comments: {idea.comment_count}</span>
                  <span>
                    Votes:{" "}
                    {Number(idea.upvote_count || 0) -
                      Number(idea.downvote_count || 0)}
                  </span>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => openIdeaDetail(idea.id)}
                    className="px-3 py-1.5 text-sm bg-primary-600 text-white rounded hover:bg-primary-700"
                  >
                    View Details
                  </button>
                  <button
                    onClick={() => handleVote(idea.id, "up")}
                    className="px-3 py-1.5 text-sm border border-success-300 text-success-700 rounded hover:bg-success-50"
                  >
                    Upvote
                  </button>
                  <button
                    onClick={() => handleVote(idea.id, "down")}
                    className="px-3 py-1.5 text-sm border border-danger-300 text-danger-700 rounded hover:bg-danger-50"
                  >
                    Downvote
                  </button>
                </div>
              </article>
            ))}
          </div>

          {totalIdeas > perPage && (
            <div className="flex justify-center gap-2 mt-8">
              <button
                onClick={() => setPage(Math.max(1, page - 1))}
                disabled={page === 1}
                className="px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 disabled:opacity-50"
              >
                Previous
              </button>
              <span className="px-4 py-2 text-neutral-700">
                Page {page} of {Math.ceil(totalIdeas / perPage)}
              </span>
              <button
                onClick={() => setPage(page + 1)}
                disabled={page * perPage >= totalIdeas}
                className="px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 disabled:opacity-50"
              >
                Next
              </button>
            </div>
          )}

          <section className="mt-8 bg-white rounded-lg border border-neutral-200 p-4">
            <h3 className="text-base font-semibold text-neutral-900 mb-3">
              Latest Comments (System-wide)
            </h3>
            <div className="space-y-2">
              {latestComments.map((comment) => (
                <div
                  key={comment.id}
                  className="border border-neutral-100 rounded p-2"
                >
                  <p className="text-sm text-neutral-800">
                    <span className="font-medium">
                      {comment.contributor_name}:
                    </span>{" "}
                    {comment.content}
                  </p>
                  <p className="text-xs text-neutral-500 mt-1">
                    Idea: {comment.idea_title} |{" "}
                    {new Date(comment.created_at).toLocaleString()}
                  </p>
                </div>
              ))}
              {latestComments.length === 0 && (
                <p className="text-sm text-neutral-500">No recent comments.</p>
              )}
            </div>
          </section>
        </>
      )}

      <Modal isOpen={isDetailOpen} onClose={() => setIsDetailOpen(false)}>
        {!selectedIdea ? (
          <div className="text-neutral-600">Loading idea detail...</div>
        ) : (
          <div>
            <h3 className="text-lg font-semibold text-neutral-900 mb-3">
              {selectedIdea.title}
            </h3>
            <p className="text-sm text-neutral-700 mb-3">
              {selectedIdea.description}
            </p>
            <div className="flex flex-wrap gap-2 text-xs text-neutral-600 mb-4">
              <span>Department: {selectedIdea.department}</span>
              <span>Session: {selectedIdea.session_name}</span>
              <span>Views: {selectedIdea.view_count}</span>
            </div>

            {selectedIdea.tags && selectedIdea.tags.length > 0 && (
              <div className="mb-4">
                <p className="text-sm font-medium text-neutral-700 mb-1">
                  Tags
                </p>
                <div className="flex flex-wrap gap-2">
                  {selectedIdea.tags.map((tag) => (
                    <span
                      key={tag.id}
                      className="px-2 py-1 text-xs rounded bg-primary-100 text-primary-700"
                    >
                      {tag.name}
                    </span>
                  ))}
                </div>
              </div>
            )}

            <div className="mb-4">
              <p className="text-sm font-medium text-neutral-700 mb-1">
                Attachments
              </p>
              {selectedIdea.attachments?.length > 0 ? (
                <ul className="space-y-1 text-sm">
                  {selectedIdea.attachments.map((file) => (
                    <li key={file.id} className="text-neutral-700">
                      {file.file_name} ({file.file_type || "file"})
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="text-sm text-neutral-500">No attachments.</p>
              )}
            </div>

            <div className="mb-4">
              <p className="text-sm font-medium text-neutral-700 mb-1">
                Latest Comments
              </p>
              <div className="max-h-40 overflow-y-auto space-y-2 border border-neutral-200 rounded p-2">
                {(selectedIdea.comments || []).slice(0, 12).map((comment) => (
                  <div
                    key={comment.id}
                    className="text-sm text-neutral-700 border-b border-neutral-100 pb-2"
                  >
                    <span className="font-medium">
                      {comment.contributor_name}:
                    </span>{" "}
                    {comment.content}
                  </div>
                ))}
                {(!selectedIdea.comments ||
                  selectedIdea.comments.length === 0) && (
                  <p className="text-sm text-neutral-500">No comments yet.</p>
                )}
              </div>
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Add Comment
              </label>
              <textarea
                value={commentText}
                onChange={(e) => setCommentText(e.target.value)}
                rows={3}
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg outline-none focus:ring-2 focus:ring-primary-500"
                placeholder="Write a clarifying or guiding comment"
              />
              <label className="inline-flex items-center gap-2 mt-2 text-sm text-neutral-700">
                <input
                  type="checkbox"
                  checked={commentAnonymous}
                  onChange={(e) => setCommentAnonymous(e.target.checked)}
                />
                Comment anonymously
              </label>
            </div>

            <div className="mt-4 space-y-3">
              <div className="flex flex-wrap gap-2">
                <button
                  onClick={handleComment}
                  className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700"
                >
                  Post Comment
                </button>
              </div>
              <div className="flex flex-wrap gap-2">
                <button
                  onClick={() => handleVote(selectedIdea.id, "up")}
                  className="px-4 py-2 border border-success-300 text-success-700 rounded-lg hover:bg-success-50"
                >
                  Upvote
                </button>
                <button
                  onClick={() => handleVote(selectedIdea.id, "down")}
                  className="px-4 py-2 border border-danger-300 text-danger-700 rounded-lg hover:bg-danger-50"
                >
                  Downvote
                </button>
              </div>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

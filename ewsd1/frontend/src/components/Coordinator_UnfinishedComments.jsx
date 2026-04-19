// src/components/Coordinator/UnfinishedComments.jsx
import { useState, useEffect } from "react";
import axios from "axios";

const API_BASE = "http://localhost/ewsd1/api";

export default function UnfinishedComments({ onError }) {
  const [comments, setComments] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedSession, setSelectedSession] = useState("");
  const [sortBy, setSortBy] = useState("days_without_response");

  // Fetch sessions
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
        setSessions(response.data.data || []);
        if (response.data.data?.length > 0) {
          setSelectedSession(response.data.data[0].id);
        }
      } catch (error) {
        console.error("Failed to fetch sessions");
      }
    };
    fetchSessions();
  }, []);

  // Fetch unanswered comments
  useEffect(() => {
    const fetchComments = async () => {
      if (!selectedSession) return;

      setIsLoading(true);
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=unanswered_comments&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );

        let commentsList = response.data.data || [];

        // Sort
        if (sortBy === "days_without_response") {
          commentsList.sort(
            (a, b) => b.days_without_response - a.days_without_response,
          );
        } else if (sortBy === "recent") {
          commentsList.sort(
            (a, b) => new Date(b.created_at) - new Date(a.created_at),
          );
        }

        setComments(commentsList);
        onError("");
      } catch (error) {
        onError(error.response?.data?.message || "Failed to fetch comments");
      } finally {
        setIsLoading(false);
      }
    };

    if (selectedSession) {
      fetchComments();
    }
  }, [selectedSession, sortBy]);

  const getUrgencyColor = (daysWithout) => {
    if (daysWithout >= 7) return "bg-danger-100 border-danger-300";
    if (daysWithout >= 3) return "bg-warning-100 border-warning-300";
    return "bg-neutral-100 border-neutral-300";
  };

  const getUrgencyLabel = (daysWithout) => {
    if (daysWithout >= 7) return "🔴 Critical";
    if (daysWithout >= 3) return "🟡 Moderate";
    return "🟢 Recent";
  };

  return (
    <div>
      <div className="mb-8">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          Comments Awaiting Responses
        </h2>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-2">
              Select Session
            </label>
            <select
              value={selectedSession}
              onChange={(e) => setSelectedSession(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">Choose a session...</option>
              {sessions.map((session) => (
                <option key={session.id} value={session.id}>
                  {session.session_name} ({session.days_until_closure}d
                  remaining)
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-2">
              Sort By
            </label>
            <select
              value={sortBy}
              onChange={(e) => setSortBy(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="days_without_response">
                Days Without Response (Most Urgent)
              </option>
              <option value="recent">Recently Posted</option>
            </select>
          </div>
        </div>
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading comments...</p>
        </div>
      ) : comments.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600 mb-2">Excellent! 🎉</p>
          <p className="text-neutral-600">
            All comments have been responded to
          </p>
        </div>
      ) : (
        <>
          {/* Summary */}
          <div className="bg-primary-50 border border-primary-200 rounded-lg p-4 mb-6">
            <p className="text-primary-900 font-semibold">
              💬 {comments.length} comment{comments.length !== 1 ? "s" : ""}{" "}
              awaiting response{comments.length !== 1 ? "s" : ""}
            </p>
          </div>

          {/* Comments List */}
          <div className="space-y-4">
            {comments.map((comment, idx) => (
              <div
                key={idx}
                className={`rounded-lg border-2 p-4 ${getUrgencyColor(comment.days_without_response)}`}
              >
                <div className="flex justify-between items-start mb-3">
                  <div className="flex-1">
                    <h3 className="text-base font-semibold text-neutral-900 mb-1">
                      {comment.idea_title}
                    </h3>
                    <p className="text-sm text-neutral-700 mb-2">
                      <span className="font-medium">Session:</span>{" "}
                      {comment.session_name}
                    </p>
                  </div>
                  <span className="px-3 py-1 bg-white rounded-full text-xs font-semibold whitespace-nowrap ml-2">
                    {getUrgencyLabel(comment.days_without_response)}
                  </span>
                </div>

                {/* Comment Content */}
                <div className="bg-white bg-opacity-60 rounded p-3 mb-3">
                  <p className="text-sm text-neutral-700">
                    <span className="font-medium">
                      {comment.comment_author_name}:
                    </span>{" "}
                    {comment.content}
                  </p>
                </div>

                {/* Comment Meta */}
                <div className="flex justify-between items-center text-xs text-neutral-600">
                  <div>
                    <span>📧 {comment.comment_author_email}</span>
                    <span className="ml-3">
                      📅 {new Date(comment.created_at).toLocaleDateString()}
                    </span>
                  </div>
                  <div className="font-semibold text-neutral-900">
                    ⏳ {comment.days_without_response} day
                    {comment.days_without_response !== 1 ? "s" : ""} without
                    response
                  </div>
                </div>

                {/* Action Suggestion */}
                {comment.days_without_response >= 3 && (
                  <div className="mt-3 pt-3 border-t border-white border-opacity-50">
                    <p className="text-xs text-neutral-700">
                      💡 <strong>Suggestion:</strong> Consider reaching out to
                      encourage a response.
                    </p>
                  </div>
                )}
              </div>
            ))}
          </div>

          {/* Engagement Tips */}
          <div className="mt-8 bg-neutral-50 rounded-lg border border-neutral-200 p-4">
            <h3 className="font-semibold text-neutral-900 mb-2">
              💡 Tips for Better Engagement
            </h3>
            <ul className="text-sm text-neutral-700 space-y-1">
              <li>
                ✓ Encourage idea authors to respond to questions within 48 hours
              </li>
              <li>
                ✓ Highlight interesting ideas that have unanswered questions
              </li>
              <li>✓ Send reminders when comments are over 3 days old</li>
              <li>✓ Facilitate discussions between team members in comments</li>
            </ul>
          </div>
        </>
      )}
    </div>
  );
}

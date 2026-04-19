// src/components/Staff/IdeaDetail.jsx
import { useState, useEffect } from "react";
import axios from "axios";
import CommentsSection from "./Staff_CommentsSection";
import VotingButtons from "./Staff_VotingButtons";
import ReportModal from "./Staff_ReportModal";

const API_BASE = "http://localhost/ewsd1/api";

export default function IdeaDetail({ ideaId, onClose }) {
  const [idea, setIdea] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState("");
  const [showReport, setShowReport] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [editForm, setEditForm] = useState({
    title: "",
    description: "",
    is_anonymous: false,
    category_ids: [],
  });
  const [categories, setCategories] = useState([]);
  const [isSaving, setIsSaving] = useState(false);

  const authHeaders = {
    Authorization: `Bearer ${localStorage.getItem("authToken")}`,
  };

  const loadIdea = async () => {
    setIsLoading(true);
    try {
      const response = await axios.get(
        `${API_BASE}/staff_ideas.php?action=get_idea&idea_id=${ideaId}`,
        { headers: authHeaders },
      );
      setIdea(response.data.data);
      setError("");
    } catch (err) {
      setError(err.response?.data?.message || "Failed to load idea");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    if (ideaId) {
      loadIdea();
    }
  }, [ideaId]);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/staff_ideas.php?action=get_categories`,
          {
            headers: authHeaders,
          },
        );
        setCategories(response.data.data || []);
      } catch (err) {
        setCategories([]);
      }
    };

    fetchCategories();
  }, []);

  useEffect(() => {
    if (idea) {
      setEditForm({
        title: idea.title || "",
        description: idea.description || "",
        is_anonymous: Boolean(idea.is_anonymous),
        category_ids: Array.isArray(idea.tags)
          ? idea.tags.map((tag) => tag.id)
          : [],
      });
    }
  }, [idea]);

  const toggleCategory = (catId) => {
    setEditForm((prev) => ({
      ...prev,
      category_ids: prev.category_ids.includes(catId)
        ? prev.category_ids.filter((id) => id !== catId)
        : [...prev.category_ids, catId],
    }));
  };

  const handleSave = async () => {
    if (!editForm.title.trim() || !editForm.description.trim()) {
      setError("Title and description are required");
      return;
    }

    setIsSaving(true);
    try {
      await axios.post(
        `${API_BASE}/staff_ideas.php?action=update_idea`,
        {
          idea_id: ideaId,
          title: editForm.title,
          description: editForm.description,
          is_anonymous: editForm.is_anonymous,
          category_ids: editForm.category_ids,
        },
        { headers: authHeaders },
      );

      setIsEditing(false);
      await loadIdea();
    } catch (err) {
      setError(err.response?.data?.message || "Failed to update idea");
    } finally {
      setIsSaving(false);
    }
  };

  const handleDelete = async () => {
    if (!window.confirm("Delete this idea? This cannot be undone.")) {
      return;
    }

    setIsSaving(true);
    try {
      await axios.post(
        `${API_BASE}/staff_ideas.php?action=delete_idea`,
        { idea_id: ideaId },
        { headers: authHeaders },
      );
      onClose();
    } catch (err) {
      setError(err.response?.data?.message || "Failed to delete idea");
    } finally {
      setIsSaving(false);
    }
  };

  if (isLoading) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-lg w-full max-w-3xl max-h-96 overflow-y-auto p-6">
          <p className="text-gray-600">Loading idea...</p>
        </div>
      </div>
    );
  }

  if (error || !idea) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div className="bg-white rounded-lg w-full max-w-3xl p-6">
          <p className="text-red-600">{error || "Idea not found"}</p>
          <button
            onClick={onClose}
            className="mt-4 px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300"
          >
            Close
          </button>
        </div>
      </div>
    );
  }

  const submissionCloseAt = idea.closes_at || null;
  const commentCloseAt = idea.final_closure_date || idea.closes_at || null;
  const daysUntilSubmissionClosure = submissionCloseAt
    ? Math.ceil(
        (new Date(submissionCloseAt) - new Date()) / (1000 * 60 * 60 * 24),
      )
    : null;
  const daysUntilCommentClosure = commentCloseAt
    ? Math.ceil((new Date(commentCloseAt) - new Date()) / (1000 * 60 * 60 * 24))
    : null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg w-full max-w-4xl max-h-screen overflow-y-auto">
        <div className="sticky top-0 border-b border-gray-200 p-6 bg-white flex justify-between items-start">
          <div className="flex-1">
            <h2 className="text-2xl font-bold text-gray-900">{idea.title}</h2>
            <p className="text-sm text-gray-600 mt-2">
              {idea.is_anonymous ? "Anonymous" : idea.contributor_name} |{" "}
              {idea.department}
            </p>
          </div>
          <button
            onClick={onClose}
            className="text-gray-500 hover:text-gray-700 text-2xl"
          >
            x
          </button>
        </div>

        <div className="p-6">
          <div className="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <div className="flex justify-between items-start">
              <div>
                <p className="text-sm font-medium text-blue-900">
                  Session: {idea.session_name}
                </p>
                <p className="text-xs text-blue-700 mt-1">
                  {idea.can_submit
                    ? `Submissions open for ${daysUntilSubmissionClosure ?? 0} more day${Number(daysUntilSubmissionClosure ?? 0) === 1 ? "" : "s"}`
                    : "Submissions closed"}
                </p>
              </div>
              <div className="flex flex-wrap gap-2 justify-end">
                <span className="px-3 py-1 bg-slate-100 text-slate-700 text-xs font-medium rounded">
                  Status: {idea.status || "N/A"}
                </span>
                <span className="px-3 py-1 bg-indigo-100 text-indigo-700 text-xs font-medium rounded">
                  Approval: {idea.approval_status || "N/A"}
                </span>
                {idea.can_comment ? (
                  <span className="px-3 py-1 bg-green-100 text-green-700 text-xs font-medium rounded">
                    Comments Open
                  </span>
                ) : (
                  <span className="px-3 py-1 bg-red-100 text-red-700 text-xs font-medium rounded">
                    Session Closed
                  </span>
                )}
              </div>
            </div>
            <div className="mt-3 grid grid-cols-1 md:grid-cols-2 gap-2">
              <p className="text-xs text-blue-800">
                <span className="font-semibold">Submission window:</span>{" "}
                {daysUntilSubmissionClosure === null
                  ? "N/A"
                  : daysUntilSubmissionClosure < 0
                  ? `Closed ${Math.abs(daysUntilSubmissionClosure)} day${Math.abs(daysUntilSubmissionClosure) === 1 ? "" : "s"} ago`
                  : `${daysUntilSubmissionClosure} day${daysUntilSubmissionClosure === 1 ? "" : "s"} remaining`}
              </p>
              <p className="text-xs text-blue-800">
                <span className="font-semibold">Comment window:</span>{" "}
                {daysUntilCommentClosure === null
                  ? "N/A"
                  : daysUntilCommentClosure < 0
                  ? `Closed ${Math.abs(daysUntilCommentClosure)} day${Math.abs(daysUntilCommentClosure) === 1 ? "" : "s"} ago`
                  : `${daysUntilCommentClosure} day${daysUntilCommentClosure === 1 ? "" : "s"} remaining`}
              </p>
            </div>
          </div>

          {idea.latest_invitation && (
            <div className="mb-6 p-4 bg-amber-50 border border-amber-200 rounded-lg">
              <div className="flex items-center justify-between gap-3 mb-2">
                <p className="text-sm font-semibold text-amber-900">
                  Latest Invitation From QA Coordinator
                </p>
                <span className="text-xs text-amber-700">
                  {idea.latest_invitation.sent_at
                    ? new Date(idea.latest_invitation.sent_at).toLocaleString()
                    : "Unknown time"}
                </span>
              </div>
              <p className="text-xs text-amber-800 mb-2">
                From: {idea.latest_invitation.coordinator_name || "QA Coordinator"}
              </p>
              <p className="text-xs text-amber-800 mb-2">
                Sent to: {idea.latest_invitation.recipient_name || "Staff"}{" "}
                {idea.latest_invitation.recipient_email
                  ? `(${idea.latest_invitation.recipient_email})`
                  : ""}
              </p>
              <p className="text-sm text-amber-900 whitespace-pre-wrap">
                {idea.latest_invitation.message || "No invitation message provided."}
              </p>
            </div>
          )}

          {idea.is_owner && idea.can_submit && (
            <div className="mb-6 flex items-center gap-2">
              <button
                onClick={() => setIsEditing((prev) => !prev)}
                className="px-3 py-1.5 text-sm border border-slate-300 rounded hover:bg-slate-50"
              >
                {isEditing ? "Cancel Edit" : "Edit Idea"}
              </button>
              <button
                onClick={handleDelete}
                disabled={isSaving}
                className="px-3 py-1.5 text-sm border border-red-300 text-red-600 rounded hover:bg-red-50 disabled:opacity-50"
              >
                Delete
              </button>
            </div>
          )}

          {isEditing ? (
            <div className="mb-6 border border-slate-200 rounded-lg p-4 bg-slate-50">
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Title
                </label>
                <input
                  type="text"
                  value={editForm.title}
                  onChange={(e) =>
                    setEditForm({ ...editForm, title: e.target.value })
                  }
                  className="w-full px-3 py-2 border border-gray-300 rounded"
                />
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Description
                </label>
                <textarea
                  value={editForm.description}
                  onChange={(e) =>
                    setEditForm({ ...editForm, description: e.target.value })
                  }
                  rows={4}
                  className="w-full px-3 py-2 border border-gray-300 rounded"
                />
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Tags
                </label>
                <div className="flex flex-wrap gap-2">
                  {categories.map((cat) => (
                    <button
                      key={cat.id}
                      type="button"
                      onClick={() => toggleCategory(cat.id)}
                      className={`px-3 py-1 rounded-full text-sm font-medium transition ${
                        editForm.category_ids.includes(cat.id)
                          ? "bg-blue-600 text-white"
                          : "bg-gray-100 text-gray-700 hover:bg-gray-200"
                      }`}
                    >
                      {cat.name}
                    </button>
                  ))}
                </div>
              </div>
              <label className="flex items-center gap-2 text-sm text-gray-700">
                <input
                  type="checkbox"
                  checked={editForm.is_anonymous}
                  onChange={(e) =>
                    setEditForm({ ...editForm, is_anonymous: e.target.checked })
                  }
                  className="w-4 h-4 rounded border-gray-300"
                />
                Post anonymously
              </label>
              <div className="mt-4 flex gap-2">
                <button
                  onClick={handleSave}
                  disabled={isSaving}
                  className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
                >
                  {isSaving ? "Saving..." : "Save Changes"}
                </button>
                <button
                  onClick={() => setIsEditing(false)}
                  className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                >
                  Cancel
                </button>
              </div>
            </div>
          ) : (
            <>
              <div className="mb-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  Description
                </h3>
                <p className="text-gray-700 whitespace-pre-wrap">
                  {idea.description}
                </p>
              </div>

              {idea.tags && idea.tags.length > 0 && (
                <div className="mb-6">
                  <h3 className="text-lg font-semibold text-gray-900 mb-2">
                    Tags
                  </h3>
                  <div className="flex flex-wrap gap-2">
                    {idea.tags.map((tag) => (
                      <span
                        key={tag.id}
                        className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded"
                      >
                        {tag.name}
                      </span>
                    ))}
                  </div>
                </div>
              )}
            </>
          )}

          {idea.attachments && idea.attachments.length > 0 && (
            <div className="mb-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-3">
                Attachments
              </h3>
              <div className="space-y-2">
                {idea.attachments.map((file) => (
                  <div
                    key={file.id}
                    className="flex items-center gap-2 p-3 bg-gray-50 rounded"
                  >
                    <span className="text-lg">[file]</span>
                    <a
                      href={file.file_path}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-blue-600 hover:text-blue-700 underline flex-1"
                    >
                      {file.file_name}
                    </a>
                    <span className="text-xs text-gray-500">
                      {(file.file_size / 1024 / 1024).toFixed(1)} MB
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}

          <div className="mb-6 grid grid-cols-3 gap-4">
            <div className="p-3 bg-gray-50 rounded-lg text-center">
              <p className="text-2xl font-bold text-gray-900">
                {idea.view_count || 0}
              </p>
              <p className="text-xs text-gray-600">Views</p>
            </div>
            <div className="p-3 bg-gray-50 rounded-lg text-center">
              <p className="text-2xl font-bold text-gray-900">
                {idea.comment_count || 0}
              </p>
              <p className="text-xs text-gray-600">Comments</p>
            </div>
            <div className="p-3 bg-gray-50 rounded-lg text-center">
              <p className="text-2xl font-bold text-gray-900">
                {(idea.upvote_count || 0) - (idea.downvote_count || 0)}
              </p>
              <p className="text-xs text-gray-600">Net Votes</p>
            </div>
          </div>

          <div className="mb-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-3">
              Your Vote
            </h3>
            <VotingButtons idea={idea} onError={setError} />
          </div>

          {idea.can_comment && (
            <div className="mb-6">
              <CommentsSection ideaId={idea.id} onError={setError} />
            </div>
          )}

          <div className="flex gap-2">
            <button
              onClick={() => setShowReport(true)}
              className="flex-1 px-4 py-2 border border-red-300 text-red-600 rounded-lg hover:bg-red-50 transition font-medium"
            >
              Report Inappropriate Content
            </button>
          </div>
        </div>
      </div>

      <ReportModal
        isOpen={showReport}
        onClose={() => setShowReport(false)}
        contentType="Idea"
        contentId={idea.id}
      />
    </div>
  );
}

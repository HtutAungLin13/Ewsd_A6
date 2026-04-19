// src/components/QA/IdeasManagement.jsx
import { useState, useEffect } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

export default function IdeasManagement({ onError }) {
  const [ideas, setIdeas] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedIdea, setSelectedIdea] = useState(null);
  const [isDetailModalOpen, setIsDetailModalOpen] = useState(false);
  const [isFlagModalOpen, setIsFlagModalOpen] = useState(false);
  const [flagReason, setFlagReason] = useState("");
  const [isHideModalOpen, setIsHideModalOpen] = useState(false);
  const [hideReason, setHideReason] = useState("");
  const [filterSession, setFilterSession] = useState("");
  const [filterStatus, setFilterStatus] = useState("");
  const [filterApproval, setFilterApproval] = useState("");
  const [page, setPage] = useState(1);
  const [totalIdeas, setTotalIdeas] = useState(0);
  const [lastAction, setLastAction] = useState(null);
  const [isUndoing, setIsUndoing] = useState(false);
  const perPage = 10;

  // Fetch sessions
  useEffect(() => {
    const fetchSessions = async () => {
      try {
        const response = await axios.get(`${API_BASE}/sessions.php`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        });
        setSessions(response.data.data || []);
      } catch (error) {
        console.error("Failed to fetch sessions");
      }
    };
    fetchSessions();
  }, []);

  // Fetch ideas
  const fetchIdeas = async () => {
    setIsLoading(true);
    try {
      let url = `${API_BASE}/qa_ideas.php?page=${page}&per_page=${perPage}`;
      if (filterSession) url += `&session_id=${filterSession}`;
      if (filterStatus) url += `&status=${filterStatus}`;
      if (filterApproval) url += `&approval_status=${filterApproval}`;

      const response = await axios.get(url, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });

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
    fetchIdeas();
  }, [page, filterSession, filterStatus, filterApproval]);

  const openIdeaDetail = async (ideaId) => {
    try {
      const response = await axios.get(`${API_BASE}/qa_ideas.php?id=${ideaId}`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setSelectedIdea(response.data.data || null);
      setIsDetailModalOpen(true);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to load idea detail");
    }
  };

  const handleApprove = async (idea) => {
    try {
      await axios.put(
        `${API_BASE}/qa_ideas.php?id=${idea.id}`,
        { approval_action: "approve" },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      fetchIdeas();
      setIsDetailModalOpen(false);
      onError("");
    } catch (error) {
      onError("Failed to approve idea");
    }
  };

  const handleReject = async (idea) => {
    try {
      await axios.put(
        `${API_BASE}/qa_ideas.php?id=${idea.id}`,
        { approval_action: "reject" },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      fetchIdeas();
      setIsDetailModalOpen(false);
      onError("");
    } catch (error) {
      onError("Failed to reject idea");
    }
  };

  const handleFlag = async () => {
    if (!selectedIdea || !flagReason) {
      onError("Please select a reason");
      return;
    }

    try {
      await axios.put(
        `${API_BASE}/qa_ideas.php?id=${selectedIdea.id}`,
        { approval_action: "flag", reason: flagReason },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      fetchIdeas();
      setIsFlagModalOpen(false);
      setFlagReason("");
      setLastAction({
        scope: "idea",
        action: "flag",
        ideaId: selectedIdea.id,
        label: `Flagged idea "${selectedIdea.title}"`,
      });
      onError("");
    } catch (error) {
      onError("Failed to flag idea");
    }
  };

  const handleUnhideIdea = async (ideaToUnhide = selectedIdea) => {
    if (!ideaToUnhide) return;
    try {
      await axios.put(
        `${API_BASE}/qa_ideas.php?id=${ideaToUnhide.id}`,
        { approval_action: "unhide" },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      await fetchIdeas();
      if (
        isDetailModalOpen &&
        selectedIdea &&
        selectedIdea.id === ideaToUnhide.id
      ) {
        await openIdeaDetail(ideaToUnhide.id);
      }
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to unhide idea");
    }
  };

  const handleHideIdea = async () => {
    if (!selectedIdea) return;
    const reason = window.prompt("Reason for hiding this idea?", "Inappropriate content");
    if (reason === null) return;
    try {
      await axios.put(
        `${API_BASE}/qa_ideas.php?id=${selectedIdea.id}`,
        { approval_action: "hide", reason: reason || "Inappropriate content" },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      fetchIdeas();
      setIsDetailModalOpen(false);
      setLastAction({
        scope: "idea",
        action: "hide",
        ideaId: selectedIdea.id,
        label: `Hidden idea "${selectedIdea.title}"`,
      });
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to hide idea");
    }
  };

  const handleModerateComment = async (commentId, actionType) => {
    const reason = window.prompt(`Reason for ${actionType} this comment?`, "Inappropriate content");
    if (reason === null) return;
    try {
      await axios.put(
        `${API_BASE}/qa_management.php?action=manage_comment`,
        {
          comment_id: commentId,
          comment_action: actionType,
          reason: reason || "Inappropriate content",
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setLastAction({
        scope: "comment",
        action: actionType === "flag" ? "flag" : "hide",
        ideaId: selectedIdea.id,
        commentId: commentId,
        label:
          actionType === "flag"
            ? "Flagged a comment"
            : "Hidden a comment",
      });
      await openIdeaDetail(selectedIdea.id);
    } catch (error) {
      onError(error.response?.data?.message || "Failed to moderate comment");
    }
  };

  const handleHideAllContent = async () => {
    if (!selectedIdea || !selectedIdea.contributor_id) {
      onError("Contributor information not available");
      return;
    }
    if (!hideReason) {
      onError("Please select a reason");
      return;
    }

    try {
      await axios.put(
        `${API_BASE}/qa_management.php?action=manage_contributor`,
        {
          contributor_id: selectedIdea.contributor_id,
          contributor_action: "hide_content",
          reason: hideReason,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      fetchIdeas();
      setIsHideModalOpen(false);
      setHideReason("");
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to hide user content");
    }
  };

  const getStatusBadgeColor = (status) => {
    const colors = {
      Draft: "bg-neutral-100 text-neutral-700",
      Submitted: "bg-primary-100 text-primary-700",
      "Under Review": "bg-warning-100 text-warning-700",
      Approved: "bg-success-100 text-success-700",
      Rejected: "bg-danger-100 text-danger-700",
    };
    return colors[status] || "bg-neutral-100 text-neutral-700";
  };

  const getApprovalBadgeColor = (approval) => {
    const colors = {
      Pending: "bg-warning-100 text-warning-700",
      Approved: "bg-success-100 text-success-700",
      Rejected: "bg-danger-100 text-danger-700",
      Flagged: "bg-danger-100 text-danger-700",
    };
    return colors[approval] || "bg-neutral-100 text-neutral-700";
  };

  const isIdeaHidden = (idea) => {
    const status = String(idea?.status ?? "").trim().toLowerCase();
    const approvalStatus = String(idea?.approval_status ?? "")
      .trim()
      .toLowerCase();
    const canUnhide = Number(idea?.can_unhide ?? 0) === 1;
    return status === "deleted" || approvalStatus === "deleted" || canUnhide;
  };

  const handleUndoLastAction = async () => {
    if (!lastAction || isUndoing) return;
    setIsUndoing(true);
    try {
      if (lastAction.scope === "idea") {
        await axios.put(
          `${API_BASE}/qa_ideas.php?id=${lastAction.ideaId}`,
          { approval_action: "undo", undo_action: lastAction.action },
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
      } else if (lastAction.scope === "comment") {
        await axios.put(
          `${API_BASE}/qa_management.php?action=manage_comment`,
          {
            comment_id: lastAction.commentId,
            comment_action:
              lastAction.action === "flag" ? "undo_flag" : "undo_hide",
          },
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
      }
      setLastAction(null);
      await fetchIdeas();
      if (lastAction.ideaId) {
        await openIdeaDetail(lastAction.ideaId);
      }
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to undo action");
    } finally {
      setIsUndoing(false);
    }
  };

  return (
    <div>
      <div className="mb-6">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          Ideas & Submissions
        </h2>

        {/* Filters */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Session
            </label>
            <select
              value={filterSession}
              onChange={(e) => {
                setFilterSession(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">All Sessions</option>
              {sessions.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.session_name}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Status
            </label>
            <select
              value={filterStatus}
              onChange={(e) => {
                setFilterStatus(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">All Statuses</option>
              <option value="Submitted">Submitted</option>
              <option value="Under Review">Under Review</option>
              <option value="Approved">Approved</option>
              <option value="Rejected">Rejected</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Approval
            </label>
            <select
              value={filterApproval}
              onChange={(e) => {
                setFilterApproval(e.target.value);
                setPage(1);
              }}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">All</option>
              <option value="Pending">Pending</option>
              <option value="Approved">Approved</option>
              <option value="Rejected">Rejected</option>
              <option value="Flagged">Flagged</option>
            </select>
          </div>
        </div>
      </div>

      {lastAction && (
        <div className="mb-4 flex flex-col gap-3 rounded-lg border border-warning-200 bg-warning-50 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
          <div className="text-sm text-warning-800">
            {lastAction.label}
          </div>
          <button
            type="button"
            onClick={handleUndoLastAction}
            disabled={isUndoing}
            className="rounded border border-warning-300 bg-white px-3 py-1.5 text-sm text-warning-800 hover:bg-warning-100 disabled:opacity-60 sm:w-auto"
          >
            {isUndoing ? "Undoing..." : "Undo"}
          </button>
        </div>
      )}

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading ideas...</p>
        </div>
      ) : ideas.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No ideas found</p>
        </div>
      ) : (
        <>
          <div className="space-y-4">
            {ideas.map((idea) => (
              <div
                key={idea.id}
                className="bg-white rounded-lg border border-neutral-200 p-4 hover:shadow-md transition"
              >
                <div className="flex justify-between items-start mb-3">
                  <div className="flex-1">
                    <h3 className="text-base font-semibold text-neutral-900">
                      {idea.title}
                    </h3>
                    <p className="text-sm text-neutral-600 mt-1">
                      {idea.department}
                    </p>
                  </div>
                  <div className="flex gap-2 flex-shrink-0">
                    <span
                      className={`px-3 py-1 rounded-full text-xs font-medium ${getStatusBadgeColor(idea.status)}`}
                    >
                      {idea.status}
                    </span>
                    <span
                      className={`px-3 py-1 rounded-full text-xs font-medium ${getApprovalBadgeColor(idea.approval_status)}`}
                    >
                      {idea.approval_status}
                    </span>
                  </div>
                </div>

                <p className="text-sm text-neutral-700 mb-3 line-clamp-2">
                  {idea.description}
                </p>

                <div className="flex items-center gap-4 text-sm text-neutral-600 mb-4">
                  <span>Comments: {idea.comment_count}</span>
                  <span>Likes: {idea.like_count}</span>
                  <span>
                    by {idea.is_anonymous ? "Anonymous" : idea.contributor_name}
                  </span>
                </div>

                <div className="flex flex-wrap items-center gap-3">
                  <button
                    onClick={() => openIdeaDetail(idea.id)}
                    className="text-primary-600 hover:text-primary-700 font-medium text-sm"
                  >
                    View Details &amp; Manage &rarr;
                  </button>
                  <button
                    type="button"
                    onClick={() => handleUnhideIdea(idea)}
                    disabled={!isIdeaHidden(idea)}
                    title={
                      isIdeaHidden(idea)
                        ? "Restore this hidden idea"
                        : "This idea is not hidden yet"
                    }
                    className={`px-3 py-1.5 text-xs rounded border font-medium transition ${
                      isIdeaHidden(idea)
                        ? "border-success-200 text-success-700 bg-success-50 hover:bg-success-100"
                        : "border-neutral-200 text-neutral-400 bg-neutral-100 cursor-not-allowed"
                    }`}
                  >
                    Unhide Idea
                  </button>
                </div>
              </div>
            ))}
          </div>

          {/* Pagination */}
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
        </>
      )}

      {/* Detail Modal */}
      <Modal
        isOpen={isDetailModalOpen}
        onClose={() => setIsDetailModalOpen(false)}
      >
        {selectedIdea && (
          <div className="space-y-6">
            <div>
              <h3 className="text-xl font-semibold text-neutral-900">
                {selectedIdea.title}
              </h3>
              <p className="text-sm text-neutral-500 mt-1">
                Idea details and moderation tools
              </p>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div className="rounded-lg border border-neutral-200 bg-neutral-50 p-3">
                <p className="text-xs text-neutral-500 uppercase">Contributor</p>
                <p className="text-sm font-medium text-neutral-900 mt-1">
                  {selectedIdea.is_anonymous
                    ? "Anonymous"
                    : selectedIdea.contributor_name}
                </p>
              </div>
              <div className="rounded-lg border border-neutral-200 bg-neutral-50 p-3">
                <p className="text-xs text-neutral-500 uppercase">Department</p>
                <p className="text-sm font-medium text-neutral-900 mt-1">
                  {selectedIdea.department}
                </p>
              </div>
              <div className="rounded-lg border border-neutral-200 bg-neutral-50 p-3">
                <p className="text-xs text-neutral-500 uppercase">Category</p>
                <p className="text-sm font-medium text-neutral-900 mt-1">
                  {selectedIdea.category_name}
                </p>
              </div>
              <div className="rounded-lg border border-neutral-200 bg-neutral-50 p-3">
                <p className="text-xs text-neutral-500 uppercase">Status</p>
                <div className="mt-2 flex flex-wrap gap-2">
                  <span
                    className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${getStatusBadgeColor(selectedIdea.status)}`}
                  >
                    {selectedIdea.status || "N/A"}
                  </span>
                  <span
                    className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${getApprovalBadgeColor(selectedIdea.approval_status)}`}
                  >
                    {selectedIdea.approval_status || "N/A"}
                  </span>
                </div>
              </div>
            </div>

            <div className="rounded-lg border border-neutral-200 bg-white p-4">
              <p className="text-xs text-neutral-500 uppercase">Description</p>
              <p className="text-sm text-neutral-700 mt-2">
                {selectedIdea.description}
              </p>
            </div>

            {/* Comments Section */}
            {selectedIdea.comments && selectedIdea.comments.length > 0 && (
              <div className="p-4 bg-neutral-50 rounded-lg border border-neutral-200">
                <div className="flex items-center justify-between mb-3">
                  <h4 className="font-semibold text-neutral-900">
                    Comments
                  </h4>
                  <span className="text-xs text-neutral-500">
                    {selectedIdea.comments.length} total
                  </span>
                </div>
                <div className="space-y-3 max-h-52 overflow-y-auto pr-1">
                  {selectedIdea.comments.map((comment) => (
                    <div
                      key={comment.id}
                      className="bg-white p-3 rounded-lg border border-neutral-200 flex items-start justify-between gap-3"
                    >
                      <div className="flex-1">
                        <p className="text-xs text-neutral-500 mb-1">
                          {comment.is_anonymous ? "Anonymous" : comment.name}
                        </p>
                        <p className="text-sm text-neutral-700">
                          {comment.content}
                        </p>
                      </div>
                      <div className="flex gap-2">
                        <button
                          type="button"
                          onClick={() => handleModerateComment(comment.id, "flag")}
                          className="px-2.5 py-1 text-xs rounded border border-warning-200 text-warning-700 bg-warning-50 hover:bg-warning-100"
                        >
                          Flag
                        </button>
                        <button
                          type="button"
                          onClick={() => handleModerateComment(comment.id, "delete")}
                          className="px-2.5 py-1 text-xs rounded border border-danger-200 text-danger-700 bg-danger-50 hover:bg-danger-100"
                        >
                          Hide
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Actions */}
            <div className="flex flex-wrap gap-2">
              {selectedIdea.approval_status === "Pending" && (
                <>
                  <button
                    onClick={() => handleApprove(selectedIdea)}
                    className="w-full rounded-lg bg-success-600 px-4 py-2 font-medium text-white transition hover:bg-success-700 sm:w-auto"
                  >
                    Approve
                  </button>
                  <button
                    onClick={() => handleReject(selectedIdea)}
                    className="w-full rounded-lg bg-danger-600 px-4 py-2 font-medium text-white transition hover:bg-danger-700 sm:w-auto"
                  >
                    Reject
                  </button>
                </>
              )}
              <button
                onClick={() => {
                  setIsFlagModalOpen(true);
                  setIsDetailModalOpen(false);
                }}
                className="w-full rounded-lg border border-amber-700 bg-amber-600 px-4 py-2 font-semibold text-white shadow-sm transition hover:bg-amber-700 sm:w-auto"
              >
                Flag
              </button>
              {!isIdeaHidden(selectedIdea) && (
                <button
                  onClick={handleHideIdea}
                  className="w-full rounded-lg bg-danger-600 px-4 py-2 font-medium text-white transition hover:bg-danger-700 sm:w-auto"
                >
                  Hide Idea
                </button>
              )}
              {selectedIdea.contributor_id && (
                <button
                  onClick={() => {
                    setIsHideModalOpen(true);
                    setIsDetailModalOpen(false);
                  }}
                  className="w-full rounded-lg bg-danger-600 px-4 py-2 font-medium text-white transition hover:bg-danger-700 sm:w-auto"
                >
                  Hide All User Content
                </button>
              )}
              <button
                onClick={() => setIsDetailModalOpen(false)}
                className="w-full rounded-lg border border-neutral-300 px-4 py-2 font-medium transition hover:bg-neutral-50 sm:w-auto"
              >
                Close
              </button>
            </div>
          </div>
        )}
      </Modal>

      {/* Flag Modal */}
      <Modal isOpen={isFlagModalOpen} onClose={() => setIsFlagModalOpen(false)}>
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          Flag as Inappropriate
        </h3>

        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-2">
              Reason
            </label>
            <select
              value={flagReason}
              onChange={(e) => setFlagReason(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">Select reason...</option>
              <option value="Offensive language">Offensive language</option>
              <option value="Spam">Spam</option>
              <option value="Harassment">Harassment</option>
              <option value="Inappropriate content">
                Inappropriate content
              </option>
              <option value="Privacy violation">Privacy violation</option>
              <option value="Misinformation">Misinformation</option>
              <option value="Other">Other</option>
            </select>
          </div>

          <div className="flex gap-2">
            <button
              onClick={handleFlag}
              className="flex-1 px-4 py-2 bg-danger-600 text-white rounded-lg hover:bg-danger-700 transition font-medium"
            >
              Flag Idea
            </button>
            <button
              onClick={() => {
                setIsFlagModalOpen(false);
                setIsDetailModalOpen(true);
                setFlagReason("");
              }}
              className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
            >
              Cancel
            </button>
          </div>
        </div>
      </Modal>

      {/* Hide All Content Modal */}
      <Modal isOpen={isHideModalOpen} onClose={() => setIsHideModalOpen(false)}>
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          Hide All Ideas & Comments By This User
        </h3>

        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-2">
              Reason
            </label>
            <select
              value={hideReason}
              onChange={(e) => setHideReason(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">Select reason...</option>
              <option value="Inappropriate content">Inappropriate content</option>
              <option value="Offensive language">Offensive language</option>
              <option value="Harassment">Harassment</option>
              <option value="Spam">Spam</option>
              <option value="Privacy violation">Privacy violation</option>
              <option value="Misinformation">Misinformation</option>
              <option value="Repeated violations">Repeated violations</option>
              <option value="Investigation required">Investigation required</option>
              <option value="Other">Other</option>
            </select>
          </div>

          <div className="flex gap-2">
            <button
              onClick={handleHideAllContent}
              className="flex-1 px-4 py-2 bg-danger-600 text-white rounded-lg hover:bg-danger-700 transition font-medium"
            >
              Hide All Content
            </button>
            <button
              onClick={() => {
                setIsHideModalOpen(false);
                setIsDetailModalOpen(true);
                setHideReason("");
              }}
              className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
            >
              Cancel
            </button>
          </div>
        </div>
      </Modal>
    </div>
  );
}

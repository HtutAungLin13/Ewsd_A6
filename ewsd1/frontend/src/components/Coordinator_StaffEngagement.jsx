import { useState, useEffect, useRef } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

export default function StaffEngagement({ onError }) {
  const [staffNotSubmitted, setStaffNotSubmitted] = useState([]);
  const [staffInviteOptions, setStaffInviteOptions] = useState([]);
  const [sessions, setSessions] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedSession, setSelectedSession] = useState("");
  const [isInviteModalOpen, setIsInviteModalOpen] = useState(false);
  const [selectedStaff, setSelectedStaff] = useState(null);
  const [selectedInviteIdea, setSelectedInviteIdea] = useState(null);
  const [topUpvoted, setTopUpvoted] = useState([]);
  const [topCommented, setTopCommented] = useState([]);
  const [inviteMessage, setInviteMessage] = useState(
    "We would love to hear your ideas! Please share your thoughts and suggestions for improvement.",
  );
  const [isSending, setIsSending] = useState(false);
  const inviteTextareaRef = useRef(null);
  const selectedSessionMeta = sessions.find(
    (session) => String(session.id) === String(selectedSession),
  );
  const selectedStaffId = selectedStaff?.staff_id || selectedStaff?.id || null;
  const selectedInviteSessionId = selectedStaff?.session_id || selectedSession || null;
  const selectedStaffOptionValue =
    selectedStaffId && selectedInviteSessionId
      ? `${selectedStaffId}:${selectedInviteSessionId}`
      : "";
  const hasValidInviteTarget = Boolean(
    selectedStaffId && selectedInviteSessionId,
  );
  const canSendInvite = Boolean(hasValidInviteTarget && !isSending);

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

  useEffect(() => {
    const fetchStaff = async () => {
      if (!selectedSession) return;

      setIsLoading(true);
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=staff_not_submitted&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        setStaffNotSubmitted(response.data.data || []);
        onError("");
      } catch (error) {
        setStaffNotSubmitted([]);
        onError(error.response?.data?.message || "Failed to fetch staff data");
      } finally {
        setIsLoading(false);
      }
    };

    if (selectedSession) {
      fetchStaff();
    }
  }, [selectedSession, onError]);

  useEffect(() => {
    const fetchStaffInviteOptions = async () => {
      if (!selectedSession) {
        setStaffInviteOptions([]);
        return;
      }
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=staff_for_invite&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        setStaffInviteOptions(response.data.data || []);
      } catch (error) {
        setStaffInviteOptions([]);
      }
    };
    fetchStaffInviteOptions();
  }, [selectedSession]);

  useEffect(() => {
    const fetchEngagementLeaders = async () => {
      if (!selectedSession) {
        setTopUpvoted([]);
        setTopCommented([]);
        return;
      }

      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=top_engagement_ideas&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        setTopUpvoted(response.data.data?.top_upvoted || []);
        setTopCommented(response.data.data?.top_commented || []);
      } catch (error) {
        setTopUpvoted([]);
        setTopCommented([]);
      }
    };

    fetchEngagementLeaders();
  }, [selectedSession]);

  const openInviteModal = (staff) => {
    setSelectedStaff(staff);
    setSelectedInviteIdea(null);
    setInviteMessage((prev) =>
      prev && prev.trim().length > 0
        ? prev
        : "We would love to hear your ideas! Please share your thoughts and suggestions for improvement.",
    );
    setIsInviteModalOpen(true);
  };

  const buildEngagementMessage = (idea, mode) => {
    if (!idea) {
      return "We would love to hear your ideas! Please share your thoughts and suggestions for improvement.";
    }
    if (mode === "upvote") {
      return `One of the most upvoted ideas this session is "${idea.title}" with ${idea.upvote_count} upvotes. We'd love your ideas too!`;
    }
    return `A top discussed idea this session is "${idea.title}" with ${idea.comment_count} comments. Please share your ideas and join the conversation!`;
  };

  const handleUseInInvite = (idea, mode) => {
    setInviteMessage(buildEngagementMessage(idea, mode));
    setSelectedInviteIdea(idea || null);
    if (staffNotSubmitted.length > 0) {
      setSelectedStaff(staffNotSubmitted[0]);
      setIsInviteModalOpen(true);
      return;
    }
    if (staffInviteOptions.length > 0) {
      setSelectedStaff(staffInviteOptions[0]);
      setIsInviteModalOpen(true);
      return;
    }
    if (staffNotSubmitted.length === 0) {
      setSelectedStaff({
        name: "No staff selected",
        email: "No email",
        session_name: selectedSessionMeta?.session_name || "Unknown session",
        days_until_closure:
          selectedSessionMeta?.days_until_closure !== undefined &&
          selectedSessionMeta?.days_until_closure !== null
            ? Number(selectedSessionMeta.days_until_closure)
            : null,
      });
      setIsInviteModalOpen(true);
      onError("No staff members available to invite for this session.");
      return;
    }
  };

  const handleSelectStaff = (value) => {
    if (!value) {
      return;
    }
    const [staffId, sessionId] = value.split(":");
    const matched = staffInviteOptions.find(
      (staff) =>
        String(staff.staff_id || staff.id) === String(staffId) &&
        String(staff.session_id || selectedSession) === String(sessionId),
    );
    if (matched) {
      setSelectedStaff(matched);
      onError("");
    }
  };

  useEffect(() => {
    if (!isInviteModalOpen) return;
    const timer = setTimeout(() => {
      if (inviteTextareaRef.current) {
        inviteTextareaRef.current.focus();
        inviteTextareaRef.current.select();
      }
    }, 0);
    return () => clearTimeout(timer);
  }, [isInviteModalOpen]);

  const handleSendInvite = async () => {
    if (!selectedStaff || !inviteMessage?.trim()) {
      onError("Message is required");
      return;
    }
    if (!selectedStaffId || !selectedInviteSessionId) {
      onError("Please select a valid staff member to invite.");
      return;
    }

    setIsSending(true);
    try {
      await axios.post(
        `${API_BASE}/qa_coordinator.php?action=send_invitation`,
        {
          staff_id: Number(selectedStaffId),
          session_id: Number(selectedInviteSessionId),
          idea_id: selectedInviteIdea?.id ? Number(selectedInviteIdea.id) : null,
          message: inviteMessage,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      setIsInviteModalOpen(false);
      onError("");
      const response = await axios.get(
        `${API_BASE}/qa_coordinator.php?action=staff_not_submitted&session_id=${selectedSession}`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setStaffNotSubmitted(response.data.data || []);
    } catch (error) {
      onError(error.response?.data?.message || "Failed to send invitation");
    } finally {
      setIsSending(false);
    }
  };

  const getUrgencyColor = (daysLeft) => {
    if (daysLeft < 0) return "bg-danger-100 border-danger-300 text-danger-700";
    if (daysLeft <= 1) return "bg-danger-100 border-danger-300 text-danger-700";
    if (daysLeft <= 3)
      return "bg-warning-100 border-warning-300 text-warning-700";
    return "bg-neutral-100 border-neutral-300 text-neutral-700";
  };

  return (
    <div>
      <div className="mb-8">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          Staff Engagement & Encouragement
        </h2>

        <div className="bg-white rounded-lg border border-neutral-200 p-4 mb-6">
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
                {session.session_name} -{" "}
                {session.days_until_closure === null ||
                session.days_until_closure === undefined
                  ? "N/A"
                  : `${session.days_until_closure}d`}{" "}
                remaining
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="mb-6 grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-4">
        <div className="rounded-lg border border-neutral-200 bg-white p-4">
          <p className="text-xs font-medium uppercase text-neutral-500">Session</p>
          <p className="mt-1 text-sm font-semibold text-neutral-900">
            {selectedSessionMeta?.session_name || "N/A"}
          </p>
        </div>
        <div className="rounded-lg border border-neutral-200 bg-white p-4">
          <p className="text-xs font-medium uppercase text-neutral-500">Total Staff</p>
          <p className="mt-1 text-xl font-semibold text-neutral-900">
            {Number(selectedSessionMeta?.total_staff || 0)}
          </p>
        </div>
        <div className="rounded-lg border border-neutral-200 bg-white p-4">
          <p className="text-xs font-medium uppercase text-neutral-500">Total Ideas</p>
          <p className="mt-1 text-xl font-semibold text-neutral-900">
            {Number(selectedSessionMeta?.total_ideas || 0)}
          </p>
        </div>
        <div className="rounded-lg border border-neutral-200 bg-white p-4">
          <p className="text-xs font-medium uppercase text-neutral-500">Not Submitted</p>
          <p className="mt-1 text-xl font-semibold text-warning-700">
            {Number(staffNotSubmitted.length || 0)}
          </p>
        </div>
      </div>

      <div className="mb-6 grid grid-cols-1 gap-4 lg:grid-cols-2">
        <div className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="text-sm font-semibold text-neutral-900 mb-3">
            Most Upvoted Ideas
          </h3>
          {topUpvoted.length === 0 ? (
            <p className="text-sm text-neutral-600">No upvoted ideas found yet.</p>
          ) : (
            <div className="space-y-2">
              {topUpvoted.map((idea) => (
                <div key={idea.id} className="flex items-center justify-between rounded border border-neutral-200 px-3 py-2 text-sm">
                  <div>
                    <p className="font-medium text-neutral-900">{idea.title}</p>
                    <p className="text-xs text-neutral-500">
                      {idea.upvote_count} upvotes | {idea.comment_count} comments
                      {idea.department ? ` | ${idea.department}` : ""}
                    </p>
                  </div>
                  <button
                    type="button"
                    onClick={() => handleUseInInvite(idea, "upvote")}
                    className="px-2 py-1 text-xs rounded bg-primary-100 text-primary-700 hover:bg-primary-200 transition"
                  >
                    Use in invite
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
        <div className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="text-sm font-semibold text-neutral-900 mb-3">
            Most Commented Ideas
          </h3>
          {topCommented.length === 0 ? (
            <p className="text-sm text-neutral-600">No commented ideas found yet.</p>
          ) : (
            <div className="space-y-2">
              {topCommented.map((idea) => (
                <div key={idea.id} className="flex items-center justify-between rounded border border-neutral-200 px-3 py-2 text-sm">
                  <div>
                    <p className="font-medium text-neutral-900">{idea.title}</p>
                    <p className="text-xs text-neutral-500">
                      {idea.comment_count} comments | {idea.upvote_count} upvotes
                      {idea.department ? ` | ${idea.department}` : ""}
                    </p>
                  </div>
                  <button
                    type="button"
                    onClick={() => handleUseInInvite(idea, "comment")}
                    className="px-2 py-1 text-xs rounded bg-primary-100 text-primary-700 hover:bg-primary-200 transition"
                  >
                    Use in invite
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading staff data...</p>
        </div>
      ) : staffNotSubmitted.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600 mb-2">Great!</p>
          <p className="text-neutral-600">
            All staff members have submitted ideas
          </p>
        </div>
      ) : (
        <>
          <div className="bg-warning-50 border border-warning-200 rounded-lg p-4 mb-6">
            <p className="text-warning-900 font-semibold">
              {staffNotSubmitted.length} staff member
              {staffNotSubmitted.length !== 1 ? "s" : ""} have not submitted yet
            </p>
          </div>

          <div className="space-y-3">
            {staffNotSubmitted.map((staff) => (
              <div
                key={`${staff.staff_id}-${staff.session_id}`}
                className={`rounded-lg border-2 p-4 flex justify-between items-center ${getUrgencyColor(staff.days_until_closure)}`}
              >
                <div className="flex-1">
                  <h3 className="font-semibold text-base">{staff.name}</h3>
                  <p className="text-sm opacity-75">{staff.email}</p>
                  <p className="text-xs opacity-75 mt-1">
                    Session:{" "}
                    <span className="font-medium">{staff.session_name}</span>
                  </p>
                </div>

                <div className="flex items-center gap-4">
                  <div className="text-right">
                    <p className="text-sm font-semibold">
                      {staff.days_until_closure === null ||
                      staff.days_until_closure === undefined
                        ? "Unknown close date"
                        : staff.days_until_closure <= 0
                        ? "Closed"
                        : `${staff.days_until_closure} day${staff.days_until_closure !== 1 ? "s" : ""} left`}
                    </p>
                    <p className="text-xs opacity-75">
                      {staff.final_closure_date || staff.closes_at
                        ? new Date(
                            staff.final_closure_date || staff.closes_at,
                          ).toLocaleDateString()
                        : "N/A"}
                    </p>
                  </div>

                  <button
                    onClick={() => openInviteModal(staff)}
                    className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium text-sm whitespace-nowrap"
                  >
                    Invite
                  </button>
                </div>
              </div>
            ))}
          </div>
        </>
      )}

      <Modal
        isOpen={isInviteModalOpen}
        onClose={() => setIsInviteModalOpen(false)}
      >
        {selectedStaff && (
          <div>
            <h3 className="text-lg font-semibold text-neutral-900 mb-4">
              Invite {selectedStaff.name} to Submit
            </h3>
            {selectedInviteIdea?.title && (
              <p className="text-xs text-primary-700 mb-3">
                Related idea: {selectedInviteIdea.title}
              </p>
            )}

            <div className="mb-4">
              <label className="block text-sm font-medium text-neutral-700 mb-2">
                Select Staff Member
              </label>
              <select
                value={selectedStaffOptionValue}
                onChange={(e) => handleSelectStaff(e.target.value)}
                disabled={staffInviteOptions.length === 0}
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none disabled:bg-neutral-100 disabled:text-neutral-500"
              >
                {staffInviteOptions.length === 0 ? (
                  <option value="">No staff available</option>
                ) : (
                  <>
                    <option value="">Choose staff...</option>
                    {staffInviteOptions.map((staff) => (
                      <option
                        key={`${staff.staff_id}-${staff.session_id}`}
                        value={`${staff.staff_id}:${staff.session_id}`}
                      >
                        {staff.name} ({staff.email || "No email"}){" "}
                        {Number(staff.has_submitted) === 1
                          ? "- submitted"
                          : "- not submitted"}
                      </option>
                    ))}
                  </>
                )}
              </select>
            </div>

            <div className="bg-neutral-50 p-4 rounded-lg mb-4 border border-neutral-200">
              <p className="text-sm">
                <strong>Email:</strong> {selectedStaff.email || "No email"}
              </p>
              <p className="text-sm mt-1">
                <strong>Session:</strong> {selectedStaff.session_name || "Unknown session"}
              </p>
              <p className="text-sm mt-1">
                <strong>Closes in:</strong>{" "}
                {selectedStaff.days_until_closure === null ||
                selectedStaff.days_until_closure === undefined
                  ? "N/A"
                  : `${selectedStaff.days_until_closure} day${Number(selectedStaff.days_until_closure) === 1 ? "" : "s"}`}
              </p>
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium text-neutral-700 mb-2">
                Message to Send
              </label>
              <textarea
                ref={inviteTextareaRef}
                value={inviteMessage}
                onChange={(e) => setInviteMessage(e.target.value)}
                placeholder="Write an encouraging message..."
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
                rows="4"
              />
            </div>

            <div className="flex gap-2">
              <button
                onClick={handleSendInvite}
                disabled={!canSendInvite}
                className="flex-1 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed transition font-medium"
              >
                {isSending ? "Sending..." : "Send Invitation"}
              </button>
              <button
                onClick={() => setIsInviteModalOpen(false)}
                className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
              >
                Cancel
              </button>
            </div>
            {!hasValidInviteTarget && (
              <p className="mt-2 text-xs text-danger-600">
                Cannot send yet. Select a valid staff member with an active session.
              </p>
            )}

            <div className="mt-6 pt-4 border-t border-neutral-200">
              <p className="text-xs text-neutral-600 font-semibold mb-2">
                QUICK TEMPLATES:
              </p>
              <div className="space-y-2">
                {[
                  "We would love to hear your ideas! Please share your thoughts and suggestions for improvement.",
                  "Hi! Just a friendly reminder that we are looking for your innovative ideas. The submission window closes soon!",
                  "Your input is valuable to us. Please take a moment to share your ideas for making our department even better.",
                ].map((template, idx) => (
                  <button
                    key={idx}
                    onClick={() => setInviteMessage(template)}
                    className="w-full text-left px-3 py-2 bg-neutral-100 hover:bg-neutral-200 rounded text-xs text-neutral-700 transition"
                  >
                    {template}
                  </button>
                ))}
              </div>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

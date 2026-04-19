import { useState, useEffect } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

export default function UserAccountManagement({ onError }) {
  const [contributors, setContributors] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isActionModalOpen, setIsActionModalOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState(null);
  const [actionType, setActionType] = useState("");
  const [actionReason, setActionReason] = useState("");
  const [filterStatus, setFilterStatus] = useState("");

  const fetchContributors = async () => {
    setIsLoading(true);
    try {
      const response = await axios.get(
        `${API_BASE}/qa_management.php?action=manage_contributor`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setContributors(response.data.data || []);
      onError("");
    } catch (error) {
      onError("Failed to fetch contributors");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchContributors();
  }, []);

  const openActionModal = (user, action) => {
    setSelectedUser(user);
    setActionType(action);
    setActionReason("");
    setIsActionModalOpen(true);
  };

  const handleAction = async () => {
    if (!selectedUser || !actionType) {
      onError("Missing required fields");
      return;
    }

    if (
      ["disable", "block", "hide_content", "disable_and_hide"].includes(actionType) &&
      !actionReason
    ) {
      onError("Please provide a reason");
      return;
    }

    try {
      await axios.put(
        `${API_BASE}/qa_management.php?action=manage_contributor`,
        {
          contributor_id: selectedUser.id,
          contributor_action: actionType,
          reason: actionReason,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      setIsActionModalOpen(false);
      fetchContributors();
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to perform action");
    }
  };

  const getStatusBadge = (status) => {
    const styles = {
      Active: "bg-success-100 text-success-700",
      Disabled: "bg-warning-100 text-warning-700",
      Blocked: "bg-danger-100 text-danger-700",
    };
    return styles[status] || "bg-neutral-100 text-neutral-700";
  };

  const filteredContributors = filterStatus
    ? contributors.filter((c) => c.account_status === filterStatus)
    : contributors;

  return (
    <div>
      <div className="mb-6">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          User Account Management
        </h2>

        <div className="flex gap-4">
          <div className="flex-1">
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Filter by Status
            </label>
            <select
              value={filterStatus}
              onChange={(e) => setFilterStatus(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">All Users ({contributors.length})</option>
              <option value="Active">
                Active (
                {
                  contributors.filter((c) => c.account_status === "Active")
                    .length
                }
                )
              </option>
              <option value="Disabled">
                Disabled (
                {
                  contributors.filter((c) => c.account_status === "Disabled")
                    .length
                }
                )
              </option>
              <option value="Blocked">
                Blocked (
                {
                  contributors.filter((c) => c.account_status === "Blocked")
                    .length
                }
                )
              </option>
            </select>
          </div>
        </div>
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading users...</p>
        </div>
      ) : filteredContributors.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No users found</p>
        </div>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 border-b border-neutral-200">
              <tr>
                <th className="px-4 py-3 text-left font-semibold">Name</th>
                <th className="px-4 py-3 text-left font-semibold">Email</th>
                <th className="px-4 py-3 text-left font-semibold">
                  Department
                </th>
                <th className="px-4 py-3 text-center font-semibold">Status</th>
                <th className="px-4 py-3 text-center font-semibold">Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredContributors.map((user, idx) => (
                <tr
                  key={user.id}
                  className={`border-b border-neutral-200 ${idx % 2 === 0 ? "bg-neutral-50" : ""}`}
                >
                  <td className="px-4 py-3">
                    <p className="font-medium text-neutral-900">
                      {user.name || "Anonymous"}
                    </p>
                  </td>
                  <td className="px-4 py-3 text-neutral-600">
                    {user.email || "N/A"}
                  </td>
                  <td className="px-4 py-3 text-neutral-600">
                    {user.department || "N/A"}
                  </td>
                  <td className="px-4 py-3 text-center">
                    <span
                      className={`px-3 py-1 rounded-full text-xs font-medium ${getStatusBadge(user.account_status)}`}
                    >
                      {user.account_status}
                    </span>
                    {Number(user.hidden_content_count || 0) > 0 && (
                      <p className="mt-1 text-xs text-danger-700">
                        Hidden items: {user.hidden_content_count}
                      </p>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex justify-center gap-2">
                      {user.account_status === "Active" && (
                        <>
                          <button
                            onClick={() => openActionModal(user, "disable")}
                            className="px-2 py-1 text-xs bg-warning-100 text-warning-700 rounded hover:bg-warning-200 transition font-medium"
                            title="Disable this user"
                          >
                            Disable
                          </button>
                          <button
                            onClick={() => openActionModal(user, "disable_and_hide")}
                            className="px-2 py-1 text-xs bg-danger-100 text-danger-700 rounded hover:bg-danger-200 transition font-medium"
                            title="Disable account and hide all content"
                          >
                            Disable + Hide
                          </button>
                          <button
                            onClick={() => openActionModal(user, "block")}
                            className="px-2 py-1 text-xs bg-danger-100 text-danger-700 rounded hover:bg-danger-200 transition font-medium"
                            title="Block this user"
                          >
                            Block
                          </button>
                        </>
                      )}

                      {(user.account_status === "Active" ||
                        user.account_status === "Disabled" ||
                        user.account_status === "Blocked") && (
                        <button
                          onClick={() => openActionModal(user, "hide_content")}
                          className="px-2 py-1 text-xs bg-neutral-200 text-neutral-800 rounded hover:bg-neutral-300 transition font-medium"
                          title="Hide all content from this user"
                        >
                          Hide Content
                        </button>
                      )}

                      {user.account_status === "Disabled" && (
                        <button
                          onClick={() => openActionModal(user, "enable")}
                          className="px-2 py-1 text-xs bg-success-100 text-success-700 rounded hover:bg-success-200 transition font-medium"
                          title="Re-enable this user"
                        >
                          Re-enable
                        </button>
                      )}

                      {user.account_status === "Blocked" && (
                        <button
                          onClick={() => openActionModal(user, "unblock")}
                          className="px-2 py-1 text-xs bg-success-100 text-success-700 rounded hover:bg-success-200 transition font-medium"
                          title="Unblock this user"
                        >
                          Unblock
                        </button>
                      )}

                      {Number(user.hidden_content_count || 0) > 0 && (
                        <button
                          onClick={() =>
                            openActionModal(user, "restore_hidden_content")
                          }
                          className="px-2 py-1 text-xs bg-primary-100 text-primary-700 rounded hover:bg-primary-200 transition font-medium"
                          title="Restore hidden content for this user"
                        >
                          Restore Content
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <Modal
        isOpen={isActionModalOpen}
        onClose={() => setIsActionModalOpen(false)}
      >
        {selectedUser && (
          <div>
            <h3 className="text-lg font-semibold text-neutral-900 mb-4">
              {actionType === "disable" && "Disable User Account"}
              {actionType === "disable_and_hide" && "Disable Account + Hide Content"}
              {actionType === "block" && "Block User Account"}
              {actionType === "enable" && "Re-enable User Account"}
              {actionType === "unblock" && "Unblock User Account"}
              {actionType === "hide_content" && "Hide All User Content"}
              {actionType === "restore_hidden_content" &&
                "Restore Hidden User Content"}
            </h3>

            <div className="bg-neutral-50 p-4 rounded-lg mb-4 border border-neutral-200">
              <p className="text-sm text-neutral-700">
                <strong>User:</strong> {selectedUser.name || "Anonymous"}
              </p>
              {selectedUser.email && (
                <p className="text-sm text-neutral-700 mt-1">
                  <strong>Email:</strong> {selectedUser.email}
                </p>
              )}
              <p className="text-sm text-neutral-700 mt-1">
                <strong>Status:</strong> {selectedUser.account_status}
              </p>
            </div>

            {["disable", "block", "hide_content", "disable_and_hide"].includes(actionType) && (
              <div className="mb-4">
                <label className="block text-sm font-medium text-neutral-700 mb-2">
                  Reason *
                </label>
                <select
                  value={actionReason}
                  onChange={(e) => setActionReason(e.target.value)}
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none mb-2"
                >
                  <option value="">Select reason...</option>
                  <option value="Inappropriate content">
                    Inappropriate content
                  </option>
                  <option value="Offensive language">Offensive language</option>
                  <option value="Harassment">Harassment</option>
                  <option value="Spam">Spam</option>
                  <option value="Privacy violation">Privacy violation</option>
                  <option value="Misinformation">Misinformation</option>
                  <option value="Repeated violations">
                    Repeated violations
                  </option>
                  <option value="Investigation required">
                    Investigation required
                  </option>
                  <option value="Other">Other</option>
                </select>
                <textarea
                  value={actionReason}
                  onChange={(e) => setActionReason(e.target.value)}
                  placeholder="Additional notes..."
                  className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
                  rows="3"
                />
              </div>
            )}

            {["enable", "unblock", "restore_hidden_content"].includes(
              actionType,
            ) && (
              <p className="text-sm text-neutral-700 mb-4">
                {actionType === "enable" &&
                  "Are you sure you want to re-enable this user?"}
                {actionType === "unblock" &&
                  "Are you sure you want to unblock this user?"}
                {actionType === "restore_hidden_content" &&
                  "Are you sure you want to restore this user's hidden content?"}
              </p>
            )}

            <div className="flex flex-col gap-2 sm:flex-row">
              <button
                onClick={handleAction}
                className={`flex-1 px-4 py-2 text-white rounded-lg transition font-medium ${
                  actionType === "disable" ||
                  actionType === "block" ||
                  actionType === "hide_content" ||
                  actionType === "disable_and_hide"
                    ? "bg-danger-600 hover:bg-danger-700"
                    : "bg-success-600 hover:bg-success-700"
                }`}
              >
                {actionType === "disable" && "Disable User"}
                {actionType === "disable_and_hide" && "Disable + Hide Content"}
                {actionType === "block" && "Block User"}
                {actionType === "enable" && "Re-enable User"}
                {actionType === "unblock" && "Unblock User"}
                {actionType === "hide_content" && "Hide User Content"}
                {actionType === "restore_hidden_content" &&
                  "Restore User Content"}
              </button>
              <button
                onClick={() => setIsActionModalOpen(false)}
                className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
              >
                Cancel
              </button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// src/components/QA/SessionManagement.jsx
import { useState, useEffect } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

export default function SessionManagement({ onError }) {
  const [sessions, setSessions] = useState([]);
  const [academicYears, setAcademicYears] = useState([]);
  const [categories, setCategories] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [activeTab, setActiveTab] = useState("sessions");
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false);
  const [createForm, setCreateForm] = useState({
    academic_year_id: "",
    category_id: "",
    session_name: "",
    description: "",
    opens_at: "",
    closes_at: "",
    final_closure_date: "",
    status: "Draft",
  });

  // Fetch sessions
  const fetchSessions = async () => {
    try {
      const response = await axios.get(`${API_BASE}/sessions.php`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setSessions(response.data.data || []);
    } catch (error) {
      onError("Failed to fetch sessions");
    }
  };

  // Fetch academic years
  const fetchAcademicYears = async () => {
    try {
      const response = await axios.get(`${API_BASE}/academic_years.php`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setAcademicYears(response.data.data || []);
    } catch (error) {
      onError("Failed to fetch academic years");
    }
  };

  const fetchCategories = async () => {
    try {
      const response = await axios.get(`${API_BASE}/QA_categories.php`, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setCategories(response.data.data || []);
    } catch (error) {
      onError("Failed to fetch categories");
    }
  };

  useEffect(() => {
    fetchSessions();
    fetchAcademicYears();
    fetchCategories();
  }, []);

  useEffect(() => {
    if (academicYears.length > 0 && !createForm.academic_year_id) {
      setCreateForm((prev) => ({ ...prev, academic_year_id: academicYears[0].id }));
    }
  }, [academicYears]);

  useEffect(() => {
    if (categories.length > 0 && !createForm.category_id) {
      setCreateForm((prev) => ({ ...prev, category_id: categories[0].id }));
    }
  }, [categories]);

  const openCreateModal = () => {
    setCreateForm({
      academic_year_id: academicYears[0]?.id || "",
      category_id: categories[0]?.id || "",
      session_name: "",
      description: "",
      opens_at: "",
      closes_at: "",
      final_closure_date: "",
      status: "Draft",
    });
    setIsCreateModalOpen(true);
  };

  const handleCreateSession = async (e) => {
    e.preventDefault();
    try {
      const payload = {
        ...createForm,
        final_closure_date: createForm.final_closure_date || createForm.closes_at,
      };
      await axios.post(`${API_BASE}/sessions.php`, payload, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setIsCreateModalOpen(false);
      fetchSessions();
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to create session");
    }
  };

  const getSessionStatus = (session) => {
    const now = new Date();
    const opens = new Date(session.opens_at);
    const closes = new Date(session.closes_at);

    if (now < opens)
      return {
        status: "Not Started",
        color: "bg-neutral-100 text-neutral-700",
      };
    if (now > closes)
      return { status: "Closed", color: "bg-danger-100 text-danger-700" };
    return { status: "Active", color: "bg-success-100 text-success-700" };
  };

  return (
    <div>
      <div className="flex flex-wrap items-center justify-between gap-3 mb-6">
        <h2 className="text-xl font-semibold text-neutral-900">
          Session & Academic Year Management
        </h2>
        <button
          onClick={openCreateModal}
          disabled={academicYears.length === 0 || categories.length === 0}
          className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:bg-neutral-400 transition font-medium"
        >
          + Add Session
        </button>
      </div>

      {/* Tabs */}
      <div className="flex gap-4 mb-6 border-b border-neutral-200">
        {[
          { id: "sessions", label: "📅 Sessions" },
          { id: "years", label: "🎓 Academic Years" },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`pb-4 px-1 text-sm font-medium transition-all border-b-2 ${
              activeTab === tab.id
                ? "border-primary-600 text-primary-600"
                : "border-transparent text-neutral-600 hover:text-neutral-900"
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Sessions Tab */}
      {activeTab === "sessions" && (
        <div>
          {sessions.length === 0 ? (
            <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
              <p className="text-neutral-600">No sessions found</p>
            </div>
          ) : (
            <div className="space-y-4">
              {sessions.map((session) => {
                const { status, color } = getSessionStatus(session);
                return (
                  <div
                    key={session.id}
                    className="bg-white rounded-lg border border-neutral-200 p-4"
                  >
                    <div className="flex justify-between items-start mb-3">
                      <div className="flex-1">
                        <h3 className="text-base font-semibold text-neutral-900">
                          {session.session_name}
                        </h3>
                        <p className="text-sm text-neutral-600">
                          {session.category_name}
                        </p>
                      </div>
                      <span
                        className={`px-3 py-1 rounded-full text-xs font-medium ${color}`}
                      >
                        {status}
                      </span>
                    </div>

                    <div className="grid grid-cols-3 gap-4 mb-4 text-sm">
                      <div className="bg-neutral-50 p-3 rounded border border-neutral-200">
                        <p className="text-xs text-neutral-600 uppercase mb-1">
                          Opens
                        </p>
                        <p className="font-medium text-neutral-900">
                          {new Date(session.opens_at).toLocaleString()}
                        </p>
                      </div>

                      <div className="bg-neutral-50 p-3 rounded border border-neutral-200">
                        <p className="text-xs text-neutral-600 uppercase mb-1">
                          Closes
                        </p>
                        <p className="font-medium text-neutral-900">
                          {new Date(session.closes_at).toLocaleString()}
                        </p>
                      </div>

                      <div className="bg-neutral-50 p-3 rounded border border-neutral-200">
                        <p className="text-xs text-neutral-600 uppercase mb-1">
                          Final Closure
                        </p>
                        <p className="font-medium text-neutral-900">
                          {session.final_closure_date
                            ? new Date(
                                session.final_closure_date,
                              ).toLocaleString()
                            : "N/A"}
                        </p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}

      {/* Academic Years Tab */}
      {activeTab === "years" && (
        <div>
          {academicYears.length === 0 ? (
            <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
              <p className="text-neutral-600">No academic years found</p>
            </div>
          ) : (
            <div className="space-y-4">
              {academicYears.map((year) => (
                <div
                  key={year.id}
                  className="bg-white rounded-lg border border-neutral-200 p-4"
                >
                  <div className="flex justify-between items-start mb-3">
                    <div>
                      <h3 className="text-base font-semibold text-neutral-900">
                        {year.year_label}
                      </h3>
                      {year.is_active && (
                        <span className="text-xs text-success-600 font-medium">
                          ✓ Active
                        </span>
                      )}
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4 mb-4 text-sm">
                    <div className="bg-neutral-50 p-3 rounded border border-neutral-200">
                      <p className="text-xs text-neutral-600 uppercase mb-1">
                        Start Date
                      </p>
                      <p className="font-medium text-neutral-900">
                        {new Date(year.start_date).toLocaleDateString()}
                      </p>
                    </div>

                    <div className="bg-neutral-50 p-3 rounded border border-neutral-200">
                      <p className="text-xs text-neutral-600 uppercase mb-1">
                        End Date
                      </p>
                      <p className="font-medium text-neutral-900">
                        {new Date(year.end_date).toLocaleDateString()}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {/* Create Modal */}
      <Modal isOpen={isCreateModalOpen} onClose={() => setIsCreateModalOpen(false)}>
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          Add Session
        </h3>

        <form onSubmit={handleCreateSession} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Session Name *
            </label>
            <input
              type="text"
              value={createForm.session_name}
              onChange={(e) =>
                setCreateForm({ ...createForm, session_name: e.target.value })
              }
              required
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Description
            </label>
            <textarea
              value={createForm.description}
              onChange={(e) =>
                setCreateForm({ ...createForm, description: e.target.value })
              }
              rows={3}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            />
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Academic Year *
              </label>
              <select
                value={createForm.academic_year_id}
                onChange={(e) =>
                  setCreateForm({
                    ...createForm,
                    academic_year_id: e.target.value,
                  })
                }
                required
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              >
                <option value="">Select academic year</option>
                {academicYears.map((year) => (
                  <option key={year.id} value={year.id}>
                    {year.year_label}
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Category *
              </label>
              <select
                value={createForm.category_id}
                onChange={(e) =>
                  setCreateForm({ ...createForm, category_id: e.target.value })
                }
                required
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              >
                <option value="">Select category</option>
                {categories.map((category) => (
                  <option key={category.id} value={category.id}>
                    {category.name}
                  </option>
                ))}
              </select>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Opening Date & Time *
              </label>
              <input
                type="datetime-local"
                value={createForm.opens_at}
                onChange={(e) =>
                  setCreateForm({ ...createForm, opens_at: e.target.value })
                }
                required
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Closing Date & Time *
              </label>
              <input
                type="datetime-local"
                value={createForm.closes_at}
                onChange={(e) =>
                  setCreateForm({ ...createForm, closes_at: e.target.value })
                }
                required
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              />
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Final Closure Date
              </label>
              <input
                type="datetime-local"
                value={createForm.final_closure_date}
                onChange={(e) =>
                  setCreateForm({
                    ...createForm,
                    final_closure_date: e.target.value,
                  })
                }
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-neutral-700 mb-1">
                Status
              </label>
              <select
                value={createForm.status}
                onChange={(e) =>
                  setCreateForm({ ...createForm, status: e.target.value })
                }
                className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              >
                <option value="Draft">Draft</option>
                <option value="Active">Active</option>
                <option value="Closed">Closed</option>
              </select>
            </div>
          </div>

          <div className="flex gap-2 mt-6">
            <button
              type="submit"
              className="flex-1 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition font-medium"
            >
              Create Session
            </button>
            <button
              type="button"
              onClick={() => setIsCreateModalOpen(false)}
              className="flex-1 px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 transition font-medium"
            >
              Cancel
            </button>
          </div>
        </form>
      </Modal>
    </div>
  );
}



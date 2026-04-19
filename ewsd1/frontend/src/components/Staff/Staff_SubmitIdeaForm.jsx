// src/components/Staff/Staff_SubmitIdeaForm.jsx
import { useState, useEffect } from "react";
import axios from "axios";
import TermsModal from "./Staff_TermsModal";

const API_BASE = "http://localhost/ewsd1/api";

export default function SubmitIdeaForm({ onSuccess, onError }) {
  const [isLoading, setIsLoading] = useState(false);
  const [sessions, setSessions] = useState([]);
  const [categories, setCategories] = useState([]);
  const [showTerms, setShowTerms] = useState(false);
  const [tcAccepted, setTcAccepted] = useState(false);
  const [tcVersion, setTcVersion] = useState(1);
  const [files, setFiles] = useState([]);

  const [form, setForm] = useState({
    title: "",
    description: "",
    session_id: "",
    category_ids: [],
    is_anonymous: false,
    agree_tc: false,
  });

  const authHeaders = {
    Authorization: `Bearer ${localStorage.getItem("authToken")}`,
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [sessionResponse, categoryResponse] = await Promise.all([
          axios.get(`${API_BASE}/staff_ideas.php?action=get_sessions`, {
            headers: authHeaders,
          }),
          axios.get(`${API_BASE}/staff_ideas.php?action=get_categories`, {
            headers: authHeaders,
          }),
        ]);

        const sessionData = sessionResponse.data.data || [];
        const submittableSessions = sessionData.filter(
          (session) => Number(session.can_submit) === 1,
        );
        const categoryData = categoryResponse.data.data || [];

        setSessions(submittableSessions);
        setCategories(categoryData);

        if (submittableSessions.length > 0) {
          setForm((prev) => ({
            ...prev,
            session_id: String(submittableSessions[0].id),
          }));
        }
      } catch (error) {
        onError("Failed to load sessions/categories");
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    const checkTc = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/staff_ideas.php?action=get_tc`,
          {
            headers: authHeaders,
          },
        );
        setTcAccepted(Boolean(response.data.data?.accepted));
        setTcVersion(Number(response.data.data?.version) || 1);
      } catch (error) {
        console.error("Error checking T&C:", error);
      }
    };

    checkTc();
  }, []);

  const handleCategoryToggle = (categoryId) => {
    setForm((prev) => ({
      ...prev,
      category_ids: prev.category_ids.includes(categoryId)
        ? prev.category_ids.filter((id) => id !== categoryId)
        : [...prev.category_ids, categoryId],
    }));
  };

  const handleFileSelect = (e) => {
    const selectedFiles = Array.from(e.target.files || []);
    const maxSize = 10 * 1024 * 1024;

    const validFiles = selectedFiles.filter((file) => {
      if (file.size > maxSize) {
        onError(`File ${file.name} is too large (max 10 MB)`);
        return false;
      }
      return true;
    });

    setFiles((prev) => [...prev, ...validFiles].slice(0, 5));
  };

  const removeFile = (index) => {
    setFiles((prev) => prev.filter((_, i) => i !== index));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!tcAccepted && !form.agree_tc) {
      setShowTerms(true);
      return;
    }

    if (!form.title.trim() || !form.description.trim() || !form.session_id) {
      onError("Title, description, and session are required");
      return;
    }

    setIsLoading(true);

    try {
      if (!tcAccepted && form.agree_tc) {
        await axios.post(
          `${API_BASE}/staff_ideas.php?action=accept_tc`,
          { tc_version: tcVersion },
          { headers: authHeaders },
        );
      }

      const response = await axios.post(
        `${API_BASE}/staff_ideas.php?action=submit_idea`,
        {
          title: form.title,
          description: form.description,
          session_id: parseInt(form.session_id, 10),
          category_ids: form.category_ids,
          is_anonymous: form.is_anonymous,
        },
        { headers: authHeaders },
      );

      if (files.length > 0) {
        const formData = new FormData();
        formData.append("idea_id", String(response.data.data.id));
        files.forEach((file) => formData.append("files[]", file));

        await axios.post(
          `${API_BASE}/staff_attachments.php?action=upload`,
          formData,
          {
            headers: {
              ...authHeaders,
              "Content-Type": "multipart/form-data",
            },
          },
        );
      }

      setForm({
        title: "",
        description: "",
        session_id: sessions.length > 0 ? String(sessions[0].id) : "",
        category_ids: [],
        is_anonymous: false,
        agree_tc: false,
      });
      setFiles([]);

      onSuccess();
    } catch (error) {
      onError(error.response?.data?.message || "Failed to submit idea");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <div className="max-w-2xl mx-auto bg-white rounded-lg border border-gray-200 shadow-sm">
        <form onSubmit={handleSubmit} className="p-6">
          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Session *
            </label>
            <select
              value={form.session_id}
              onChange={(e) => setForm({ ...form, session_id: e.target.value })}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
            >
              <option value="">Select a session</option>
              {sessions.map((session) => (
                <option key={session.id} value={session.id}>
                  {session.session_name} ({session.days_until_closure}d left)
                </option>
              ))}
            </select>
            {sessions.length === 0 && (
              <p className="text-xs text-red-600 mt-2">
                No session is currently open for idea submission.
              </p>
            )}
          </div>

          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Idea Title *
            </label>
            <input
              type="text"
              value={form.title}
              onChange={(e) => setForm({ ...form, title: e.target.value })}
              placeholder="Give your idea a clear title"
              maxLength={200}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
            />
            <p className="text-xs text-gray-500 mt-1">
              {form.title.length}/200
            </p>
          </div>

          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Description *
            </label>
            <textarea
              value={form.description}
              onChange={(e) =>
                setForm({ ...form, description: e.target.value })
              }
              placeholder="Explain your idea in detail"
              rows={5}
              maxLength={2000}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none"
            />
            <p className="text-xs text-gray-500 mt-1">
              {form.description.length}/2000
            </p>
          </div>

          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-3">
              Categories
            </label>
            {categories.length === 0 ? (
              <p className="text-sm text-gray-500">
                No active categories available.
              </p>
            ) : (
              <div className="flex flex-wrap gap-2">
                {categories.map((cat) => (
                  <button
                    key={cat.id}
                    type="button"
                    onClick={() => handleCategoryToggle(cat.id)}
                    className={`px-3 py-1 rounded-full text-sm font-medium transition ${
                      form.category_ids.includes(cat.id)
                        ? "bg-blue-600 text-white"
                        : "bg-gray-100 text-gray-700 hover:bg-gray-200"
                    }`}
                  >
                    {cat.name}
                  </button>
                ))}
              </div>
            )}
          </div>

          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-3">
              Attachments (optional, max 5 files, 10 MB each)
            </label>

            <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center cursor-pointer hover:bg-gray-50">
              <input
                type="file"
                multiple
                onChange={handleFileSelect}
                className="hidden"
                id="file-input"
                accept=".pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png,.gif"
              />
              <label htmlFor="file-input" className="cursor-pointer">
                <p className="text-blue-600 font-medium">
                  Click to upload files
                </p>
                <p className="text-xs text-gray-600 mt-1">
                  PDF, Word, Excel, Images
                </p>
              </label>
            </div>

            {files.length > 0 && (
              <div className="mt-4">
                <p className="text-sm font-medium text-gray-700 mb-2">
                  Attached files:
                </p>
                <ul className="space-y-2">
                  {files.map((file, idx) => (
                    <li
                      key={`${file.name}-${idx}`}
                      className="flex justify-between items-center p-2 bg-gray-50 rounded"
                    >
                      <span className="text-sm text-gray-700">{file.name}</span>
                      <button
                        type="button"
                        onClick={() => removeFile(idx)}
                        className="text-red-600 hover:text-red-700 text-sm"
                      >
                        Remove
                      </button>
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </div>

          <div className="mb-6 rounded-lg border border-slate-200 bg-slate-50/60 p-4">
            <label className="flex items-start gap-3 cursor-pointer">
              <input
                type="checkbox"
                checked={form.agree_tc}
                onChange={(e) =>
                  setForm({ ...form, agree_tc: e.target.checked })
                }
                className="mt-1 h-4 w-4 rounded border-gray-300"
              />
              <div>
                <span className="text-sm text-gray-700">
                  I agree to the{" "}
                  <button
                    type="button"
                    onClick={() => setShowTerms(true)}
                    className="font-medium text-blue-600 hover:text-blue-700 underline-offset-2 hover:underline"
                  >
                    Terms and Conditions
                  </button>
                </span>
                {tcAccepted && (
                  <p className="mt-1 text-xs text-slate-500">
                    Previously accepted.
                  </p>
                )}
              </div>
            </label>
          </div>

          <div className="mb-6 px-4">
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={form.is_anonymous}
                onChange={(e) =>
                  setForm({ ...form, is_anonymous: e.target.checked })
                }
                className="w-4 h-4 rounded border-gray-300"
              />
              <span className="text-sm text-gray-700">
                Submit anonymously
                <span className="block text-xs text-gray-500 mt-1">
                  Your name will be hidden publicly but kept in database for
                  moderation.
                </span>
              </span>
            </label>
          </div>

          <div className="flex gap-3">
            <button
              type="submit"
              disabled={isLoading || (!tcAccepted && !form.agree_tc)}
              className="flex-1 px-4 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 transition font-medium"
            >
              {isLoading ? "Submitting..." : "Submit Idea"}
            </button>
          </div>
          {!tcAccepted && !form.agree_tc && (
            <p className="mt-2 text-xs text-yellow-700">
              You must agree to the Terms and Conditions before submitting.
            </p>
          )}
        </form>
      </div>

      <TermsModal
        isOpen={showTerms}
        onClose={() => setShowTerms(false)}
        onAccept={() => {
          setTcAccepted(true);
          setForm((prev) => ({ ...prev, agree_tc: true }));
          setShowTerms(false);
        }}
      />
    </>
  );
}

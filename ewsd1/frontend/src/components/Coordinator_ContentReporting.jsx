import { useState, useEffect } from "react";
import axios from "axios";
import Modal from "./Modal";

const API_BASE = "http://localhost/ewsd1/api";

const SAMPLE_REPORTS = [
  {
    id: "sample-1",
    content_type: "Comment",
    status: "Under_Review",
    severity: "Medium",
    report_category: "Offensive",
    report_reason: "Uses insulting language toward another staff member.",
    description:
      "The comment contains personal attacks and is not constructive.",
    content_preview:
      "This idea is stupid and your team never delivers anything useful.",
    reported_at: "2026-03-18T09:40:00Z",
    escalated_to_admin: 0,
  },
  {
    id: "sample-2",
    content_type: "Idea",
    status: "Flagged",
    severity: "High",
    report_category: "Libel",
    report_reason:
      "Mentions a colleague by name with an unverified allegation.",
    description: "Could damage reputation if left visible.",
    content_preview:
      "John from Operations manipulated last quarter numbers and should be removed.",
    reported_at: "2026-03-16T14:15:00Z",
    escalated_to_admin: 1,
  },
  {
    id: "sample-3",
    content_type: "Comment",
    status: "Dismissed",
    severity: "Low",
    report_category: "Other",
    report_reason: "Reported as spam, but context appears relevant.",
    description: "Reviewed and kept visible after verification.",
    content_preview:
      "Please add a clearer deadline to this proposal so contributors can plan.",
    reported_at: "2026-03-12T07:25:00Z",
    escalated_to_admin: 0,
  },
];

export default function ContentReporting({ onError }) {
  const [myReports, setMyReports] = useState([]);
  const [reportStats, setReportStats] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isReportModalOpen, setIsReportModalOpen] = useState(false);
  const [filterStatus, setFilterStatus] = useState("");
  const [page, setPage] = useState(1);
  const [totalReports, setTotalReports] = useState(0);
  const perPage = 10;

  const [reportForm, setReportForm] = useState({
    content_type: "Comment",
    content_id: "",
    report_category: "Swearing",
    report_reason: "",
    description: "",
    severity: "Medium",
  });

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const response = await axios.get(
          `${API_BASE}/coordinator_reports.php?action=report_stats`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );
        setReportStats(response.data.data || {});
      } catch (error) {
        console.error("Failed to fetch stats");
      }
    };
    fetchStats();
  }, [myReports]);

  useEffect(() => {
    const fetchReports = async () => {
      setIsLoading(true);
      try {
        let url = `${API_BASE}/coordinator_reports.php?action=my_reports&page=${page}&per_page=${perPage}`;
        if (filterStatus) {
          url += `&status=${filterStatus}`;
        }

        const response = await axios.get(url, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        });

        setMyReports(response.data.data || []);
        setTotalReports(response.data.pagination?.total || 0);
        onError("");
      } catch (error) {
        onError("Failed to fetch reports");
      } finally {
        setIsLoading(false);
      }
    };

    fetchReports();
  }, [page, filterStatus]);

  const handleSubmitReport = async () => {
    if (!reportForm.content_id) {
      onError("Content ID is required");
      return;
    }

    try {
      await axios.post(
        `${API_BASE}/coordinator_reports.php?action=report_content`,
        reportForm,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      setIsReportModalOpen(false);
      setReportForm({
        content_type: "Comment",
        content_id: "",
        report_category: "Swearing",
        report_reason: "",
        description: "",
        severity: "Medium",
      });

      const response = await axios.get(
        `${API_BASE}/coordinator_reports.php?action=my_reports&page=1&per_page=${perPage}`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setMyReports(response.data.data || []);
      setPage(1);
    } catch (error) {
      onError(error.response?.data?.message || "Failed to submit report");
    }
  };

  const getStatusColor = (status) => {
    const colors = {
      Reported: "bg-warning-100 text-warning-700",
      Under_Review: "bg-primary-100 text-primary-700",
      Flagged: "bg-danger-100 text-danger-700",
      Dismissed: "bg-neutral-100 text-neutral-700",
    };
    return colors[status] || "bg-neutral-100 text-neutral-700";
  };

  const getSeverityColor = (severity) => {
    const colors = {
      Low: "bg-success-100 text-success-700",
      Medium: "bg-warning-100 text-warning-700",
      High: "bg-danger-100 text-danger-700",
      Critical: "bg-danger-200 text-danger-900",
    };
    return colors[severity] || "bg-neutral-100 text-neutral-700";
  };

  const usingSampleData = !isLoading && myReports.length === 0;
  const sampleFiltered = SAMPLE_REPORTS.filter(
    (report) => !filterStatus || report.status === filterStatus,
  );
  const visibleReports = usingSampleData ? sampleFiltered : myReports;

  const sampleStats = {
    total_reports: SAMPLE_REPORTS.length,
    escalated: SAMPLE_REPORTS.filter(
      (report) => Number(report.escalated_to_admin) === 1,
    ).length,
    by_severity: [
      {
        severity: "Low",
        count: SAMPLE_REPORTS.filter((report) => report.severity === "Low")
          .length,
      },
      {
        severity: "Medium",
        count: SAMPLE_REPORTS.filter((report) => report.severity === "Medium")
          .length,
      },
      {
        severity: "High",
        count: SAMPLE_REPORTS.filter((report) => report.severity === "High")
          .length,
      },
      {
        severity: "Critical",
        count: SAMPLE_REPORTS.filter((report) => report.severity === "Critical")
          .length,
      },
    ],
  };

  const summaryStats =
    reportStats &&
    (Number(reportStats.total_reports || 0) > 0 ||
      Number(reportStats.escalated || 0) > 0)
      ? reportStats
      : sampleStats;

  return (
    <div>
      <div className="mb-8">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-semibold text-neutral-900">
            Report Inappropriate Content
          </h2>
          <button
            onClick={() => setIsReportModalOpen(true)}
            className="px-4 py-2 bg-danger-600 text-white rounded-lg hover:bg-danger-700 transition font-medium"
          >
            + Report Content
          </button>
        </div>

        {summaryStats && (
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="bg-white rounded-lg border border-neutral-200 p-4">
              <p className="text-sm text-neutral-600 mb-1">
                Total Reports (30 days)
              </p>
              <p className="text-2xl font-bold text-neutral-900">
                {summaryStats.total_reports || 0}
              </p>
            </div>
            <div className="bg-white rounded-lg border border-neutral-200 p-4">
              <p className="text-sm text-neutral-600 mb-1">
                Escalated to Admin
              </p>
              <p className="text-2xl font-bold text-danger-600">
                {summaryStats.escalated || 0}
              </p>
            </div>
            {summaryStats.by_severity &&
              summaryStats.by_severity.length > 0 && (
                <div className="bg-white rounded-lg border border-neutral-200 p-4">
                  <p className="text-sm text-neutral-600 mb-1">High Severity</p>
                  <p className="text-2xl font-bold text-danger-600">
                    {(summaryStats.by_severity.find(
                      (s) => s.severity === "High",
                    )?.count || 0) +
                      (summaryStats.by_severity.find(
                        (s) => s.severity === "Critical",
                      )?.count || 0)}
                  </p>
                </div>
              )}
          </div>
        )}
      </div>

      <div className="bg-white rounded-lg border border-neutral-200 p-4 mb-6">
        <label className="block text-sm font-medium text-neutral-700 mb-2">
          Filter by Status
        </label>
        <select
          value={filterStatus}
          onChange={(e) => {
            setFilterStatus(e.target.value);
            setPage(1);
          }}
          className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
        >
          <option value="">All Reports</option>
          <option value="Reported">Reported</option>
          <option value="Under_Review">Under Review</option>
          <option value="Flagged">Flagged</option>
          <option value="Dismissed">Dismissed</option>
        </select>
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading reports...</p>
        </div>
      ) : visibleReports.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No reports match this filter yet</p>
        </div>
      ) : (
        <>
          {usingSampleData && (
            <div className="mb-3 rounded-lg border border-sky-200 bg-sky-50 px-3 py-2 text-xs font-medium text-sky-700">
              Showing sample moderation data while live reports are empty.
            </div>
          )}

          <div className="space-y-4">
            {visibleReports.map((report) => (
              <div
                key={report.id}
                className="bg-white rounded-lg border border-neutral-200 p-4"
              >
                <div className="flex justify-between items-start mb-3">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <span className="text-xs font-semibold px-2 py-1 bg-neutral-100 text-neutral-700 rounded">
                        {report.content_type}
                      </span>
                      <span
                        className={`text-xs font-semibold px-2 py-1 rounded ${getStatusColor(report.status)}`}
                      >
                        {report.status}
                      </span>
                      <span
                        className={`text-xs font-semibold px-2 py-1 rounded ${getSeverityColor(report.severity)}`}
                      >
                        {report.severity}
                      </span>
                    </div>
                    <h3 className="font-semibold text-neutral-900 mb-1">
                      {report.report_category}
                    </h3>
                  </div>
                </div>

                <div className="bg-neutral-50 rounded p-3 mb-3">
                  <p className="text-sm text-neutral-700">
                    <span className="font-medium">Reason:</span>{" "}
                    {report.report_reason}
                  </p>
                  {report.description && (
                    <p className="text-sm text-neutral-700 mt-2">
                      <span className="font-medium">Description:</span>{" "}
                      {report.description}
                    </p>
                  )}
                </div>

                {report.content_preview && (
                  <div className="bg-yellow-50 border border-yellow-200 rounded p-3 mb-3 text-sm">
                    <p className="text-yellow-900">
                      <span className="font-medium">Content:</span>{" "}
                      {report.content_preview.substring(0, 150)}...
                    </p>
                  </div>
                )}

                <div className="flex justify-between items-center text-xs text-neutral-600">
                  <span>
                    Reported on{" "}
                    {report.reported_at
                      ? new Date(report.reported_at).toLocaleDateString()
                      : "date unavailable"}
                  </span>
                  {report.escalated_to_admin ? (
                    <span className="text-danger-600 font-semibold">
                      Escalated to Admin
                    </span>
                  ) : null}
                </div>
              </div>
            ))}
          </div>

          {!usingSampleData && totalReports > perPage && (
            <div className="flex justify-center gap-2 mt-8">
              <button
                onClick={() => setPage(Math.max(1, page - 1))}
                disabled={page === 1}
                className="px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 disabled:opacity-50"
              >
                Previous
              </button>
              <span className="px-4 py-2 text-neutral-700">
                Page {page} of {Math.ceil(totalReports / perPage)}
              </span>
              <button
                onClick={() => setPage(page + 1)}
                disabled={page * perPage >= totalReports}
                className="px-4 py-2 border border-neutral-300 rounded-lg hover:bg-neutral-50 disabled:opacity-50"
              >
                Next
              </button>
            </div>
          )}
        </>
      )}

      <Modal
        isOpen={isReportModalOpen}
        onClose={() => setIsReportModalOpen(false)}
      >
        <h3 className="text-lg font-semibold text-neutral-900 mb-4">
          Report Inappropriate Content
        </h3>

        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Content Type *
            </label>
            <select
              value={reportForm.content_type}
              onChange={(e) =>
                setReportForm({ ...reportForm, content_type: e.target.value })
              }
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="Idea">Idea</option>
              <option value="Comment">Comment</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Content ID *
            </label>
            <input
              type="number"
              value={reportForm.content_id}
              onChange={(e) =>
                setReportForm({ ...reportForm, content_id: e.target.value })
              }
              placeholder="Enter the ID of the content to report"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Category *
            </label>
            <select
              value={reportForm.report_category}
              onChange={(e) =>
                setReportForm({
                  ...reportForm,
                  report_category: e.target.value,
                })
              }
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="Swearing">Swearing / Offensive Language</option>
              <option value="Libel">Libel / Defamation</option>
              <option value="Defamation">Defamation</option>
              <option value="Harassment">Harassment</option>
              <option value="Offensive">Offensive Content</option>
              <option value="Other">Other</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Reason *
            </label>
            <input
              type="text"
              value={reportForm.report_reason}
              onChange={(e) =>
                setReportForm({ ...reportForm, report_reason: e.target.value })
              }
              placeholder="Brief reason for reporting"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Description
            </label>
            <textarea
              value={reportForm.description}
              onChange={(e) =>
                setReportForm({ ...reportForm, description: e.target.value })
              }
              placeholder="Detailed description of the issue"
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
              rows="3"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-neutral-700 mb-1">
              Severity
            </label>
            <select
              value={reportForm.severity}
              onChange={(e) =>
                setReportForm({ ...reportForm, severity: e.target.value })
              }
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="Low">Low - Minor violation</option>
              <option value="Medium">Medium - Should be reviewed</option>
              <option value="High">High - Serious violation</option>
              <option value="Critical">
                Critical - Immediate action needed
              </option>
            </select>
          </div>

          <div className="flex gap-2 pt-4">
            <button
              onClick={handleSubmitReport}
              className="flex-1 px-4 py-2 bg-danger-600 text-white rounded-lg hover:bg-danger-700 transition font-medium"
            >
              Submit Report
            </button>
            <button
              onClick={() => setIsReportModalOpen(false)}
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

import { useState, useEffect } from "react";
import axios from "axios";
import {
  PieChart,
  Pie,
  Cell,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const API_BASE = "http://localhost/ewsd1/api";

export default function DepartmentStats({ onError }) {
  const [stats, setStats] = useState(null);
  const [sessions, setSessions] = useState([]);
  const [selectedSession, setSelectedSession] = useState("");
  const [isLoading, setIsLoading] = useState(false);

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
    const fetchStats = async () => {
      if (!selectedSession) return;

      setIsLoading(true);
      try {
        const response = await axios.get(
          `${API_BASE}/qa_coordinator.php?action=department_stats&session_id=${selectedSession}`,
          {
            headers: {
              Authorization: `Bearer ${localStorage.getItem("authToken")}`,
            },
          },
        );

        if (response.data.data && response.data.data.length > 0) {
          setStats(response.data.data[0]);
        } else {
          setStats(null);
        }
        onError("");
      } catch (error) {
        setStats(null);
        onError("Failed to fetch statistics");
      } finally {
        setIsLoading(false);
      }
    };

    if (selectedSession) {
      fetchStats();
    }
  }, [selectedSession]);

  const displayStats = (() => {
    if (!stats) return null;

    const totalStaff = Math.max(0, Number(stats.total_staff || 0));
    const staffSubmittedRaw = Math.max(0, Number(stats.staff_submitted || 0));
    const staffSubmitted = Math.min(totalStaff, staffSubmittedRaw);
    const staffNotSubmitted = Math.max(0, totalStaff - staffSubmitted);

    return {
      ...stats,
      total_staff: totalStaff,
      staff_submitted: staffSubmitted,
      staff_not_submitted: staffNotSubmitted,
      submission_rate:
        totalStaff > 0
          ? Number(((staffSubmitted / totalStaff) * 100).toFixed(2))
          : 0,
    };
  })();

  const prepareChartData = () => {
    if (!displayStats) return [];
    return [
      {
        name: "Submitted",
        value: displayStats.staff_submitted,
        fill: "#10B981",
      },
      {
        name: "Not Submitted",
        value: displayStats.staff_not_submitted,
        fill: "#EF4444",
      },
    ];
  };

  return (
    <div>
      <div className="mb-8">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">
          Department Statistics
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
                {session.session_name} ({session.days_until_closure}d remaining)
              </option>
            ))}
          </select>
        </div>
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading statistics...</p>
        </div>
      ) : !displayStats ? (
        <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
          <p className="text-neutral-600">No data available for this session</p>
        </div>
      ) : (
        <>
          <div className="grid grid-cols-2 md:grid-cols-6 gap-4 mb-8">
            <div className="bg-white rounded-lg border border-neutral-200 p-4">
              <p className="text-sm text-neutral-600 mb-1">Total Staff</p>
              <p className="text-3xl font-bold text-neutral-900">
                {displayStats.total_staff}
              </p>
            </div>
            <div className="bg-success-50 rounded-lg border border-success-200 p-4">
              <p className="text-sm text-success-700 mb-1">Submitted</p>
              <p className="text-3xl font-bold text-success-600">
                {displayStats.staff_submitted}
              </p>
              <p className="text-xs text-success-600 mt-1">
                {displayStats.total_staff > 0
                  ? (
                      (displayStats.staff_submitted /
                        displayStats.total_staff) *
                      100
                    ).toFixed(0)
                  : 0}
                %
              </p>
            </div>
            <div className="bg-danger-50 rounded-lg border border-danger-200 p-4">
              <p className="text-sm text-danger-700 mb-1">Not Submitted</p>
              <p className="text-3xl font-bold text-danger-600">
                {displayStats.staff_not_submitted}
              </p>
              <p className="text-xs text-danger-600 mt-1">
                {displayStats.total_staff > 0
                  ? (
                      (displayStats.staff_not_submitted /
                        displayStats.total_staff) *
                      100
                    ).toFixed(0)
                  : 0}
                %
              </p>
            </div>
            <div className="bg-primary-50 rounded-lg border border-primary-200 p-4">
              <p className="text-sm text-primary-700 mb-1">Total Ideas</p>
              <p className="text-3xl font-bold text-primary-600">
                {displayStats.total_ideas}
              </p>
              <p className="text-xs text-primary-600 mt-1">
                Avg:{" "}
                {displayStats.total_staff > 0
                  ? (
                      displayStats.total_ideas / displayStats.total_staff
                    ).toFixed(1)
                  : 0}{" "}
                per staff
              </p>
            </div>
            <div className="bg-neutral-50 rounded-lg border border-neutral-200 p-4">
              <p className="text-sm text-neutral-700 mb-1">Comments</p>
              <p className="text-3xl font-bold text-neutral-800">
                {displayStats.total_comments || 0}
              </p>
              <p className="text-xs text-neutral-600 mt-1">
                Engagement comments
              </p>
            </div>
            <div className="bg-neutral-50 rounded-lg border border-neutral-200 p-4">
              <p className="text-sm text-neutral-700 mb-1">Votes</p>
              <p className="text-3xl font-bold text-neutral-800">
                {displayStats.total_votes || 0}
              </p>
              <p className="text-xs text-neutral-600 mt-1">
                Upvotes + downvotes
              </p>
            </div>
          </div>

          <div className="bg-white rounded-lg border border-neutral-200 p-6 mb-8">
            <h3 className="text-lg font-semibold text-neutral-900 mb-4">
              Submission Rate
            </h3>
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie
                  data={prepareChartData()}
                  cx="50%"
                  cy="50%"
                  innerRadius={60}
                  outerRadius={120}
                  paddingAngle={5}
                  dataKey="value"
                >
                  {prepareChartData().map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.fill} />
                  ))}
                </Pie>
                <Tooltip />
                <Legend />
              </PieChart>
            </ResponsiveContainer>

            <div className="mt-6 grid grid-cols-2 gap-4">
              <div className="p-3 bg-success-50 rounded-lg border border-success-200">
                <p className="text-sm font-medium text-success-700">
                  Submitted
                </p>
                <p className="text-2xl font-bold text-success-600">
                  {displayStats.staff_submitted}/{displayStats.total_staff}
                </p>
              </div>
              <div className="p-3 bg-danger-50 rounded-lg border border-danger-200">
                <p className="text-sm font-medium text-danger-700">
                  Not Submitted
                </p>
                <p className="text-2xl font-bold text-danger-600">
                  {displayStats.staff_not_submitted}/{displayStats.total_staff}
                </p>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg border border-neutral-200 p-6">
            <h3 className="text-lg font-semibold text-neutral-900 mb-4">
              Ideas Summary
            </h3>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="p-4 bg-primary-50 rounded-lg border border-primary-200">
                <p className="text-sm text-primary-700 font-medium mb-1">
                  Total Ideas
                </p>
                <p className="text-3xl font-bold text-primary-600">
                  {displayStats.total_ideas}
                </p>
                <p className="text-xs text-primary-600 mt-2">
                  {displayStats.total_staff > 0
                    ? (
                        displayStats.total_ideas / displayStats.total_staff
                      ).toFixed(1)
                    : 0}{" "}
                  per staff member
                </p>
              </div>

              <div className="p-4 bg-warning-50 rounded-lg border border-warning-200">
                <p className="text-sm text-warning-700 font-medium mb-1">
                  Average Ideas per Submitter
                </p>
                <p className="text-3xl font-bold text-warning-600">
                  {displayStats.staff_submitted > 0
                    ? (
                        displayStats.total_ideas / displayStats.staff_submitted
                      ).toFixed(1)
                    : 0}
                </p>
                <p className="text-xs text-warning-600 mt-2">
                  From {displayStats.staff_submitted} contributors
                </p>
              </div>

              <div className="p-4 bg-success-50 rounded-lg border border-success-200">
                <p className="text-sm text-success-700 font-medium mb-1">
                  Submission Rate
                </p>
                <p className="text-3xl font-bold text-success-600">
                  {displayStats.total_staff > 0
                    ? (
                        (displayStats.staff_submitted /
                          displayStats.total_staff) *
                        100
                      ).toFixed(0)
                    : 0}
                  %
                </p>
                <p className="text-xs text-success-600 mt-2">
                  {displayStats.staff_submitted} of {displayStats.total_staff}{" "}
                  staff
                </p>
              </div>
            </div>
          </div>

          <div className="mt-8 bg-blue-50 rounded-lg border border-blue-200 p-4">
            <h4 className="font-semibold text-blue-900 mb-2">
              Recommendations
            </h4>
            <ul className="text-sm text-blue-800 space-y-1">
              {displayStats.staff_not_submitted > 0 && (
                <li>
                  Reach out to {displayStats.staff_not_submitted} staff member
                  {displayStats.staff_not_submitted !== 1 ? "s" : ""} who have
                  not submitted yet.
                </li>
              )}
              {displayStats.staff_submitted > 0 &&
                displayStats.total_ideas > 0 && (
                  <li>
                    {Math.round(
                      (displayStats.total_ideas /
                        displayStats.staff_submitted) *
                        100,
                    ) / 100}{" "}
                    ideas per contributor reflects healthy engagement.
                  </li>
                )}
              {displayStats.staff_not_submitted === 0 && (
                <li>Excellent: all staff have participated in this session.</li>
              )}
            </ul>
          </div>
        </>
      )}
    </div>
  );
}

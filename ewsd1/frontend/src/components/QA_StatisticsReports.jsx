// src/components/QA/StatisticsReports.jsx
import { useState, useEffect } from 'react';
import apiClient from '../services/api';
import { BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const COLORS = ['#0EA5E9', '#10B981', '#8B5CF6', '#F59E0B', '#EF4444', '#EC4899'];
const asNumber = (value) => {
  const n = Number(value);
  return Number.isFinite(n) ? n : 0;
};

const getFilenameFromDisposition = (disposition, fallbackName) => {
  if (!disposition) return fallbackName;
  const match = disposition.match(/filename\*?=(?:UTF-8''|")?([^\";]+)/i);
  if (!match?.[1]) return fallbackName;
  return decodeURIComponent(match[1].trim().replace(/"/g, ''));
};

const extractErrorMessage = async (error, fallback) => {
  const statusText = error?.response?.statusText;
  const data = error?.response?.data;
  if (!data) return statusText || fallback;

  if (data instanceof Blob) {
    try {
      const text = await data.text();
      const parsed = JSON.parse(text);
      return parsed?.message || fallback;
    } catch {
      return fallback;
    }
  }

  if (typeof data === 'string') {
    try {
      const parsed = JSON.parse(data);
      return parsed?.message || fallback;
    } catch {
      return fallback;
    }
  }

  return data?.message || statusText || fallback;
};

export default function StatisticsReports({ onError }) {
  const [sessions, setSessions] = useState([]);
  const [selectedSession, setSelectedSession] = useState('');
  const [ideasByDept, setIdeasByDept] = useState([]);
  const [deptPercentage, setDeptPercentage] = useState([]);
  const [contributors, setContributors] = useState([]);
  const [statusSummary, setStatusSummary] = useState([]);
  const [inappropriateStats, setInappropriateStats] = useState(null);
  const [ideasNoCommentsSummary, setIdeasNoCommentsSummary] = useState([]);
  const [ideasNoCommentsList, setIdeasNoCommentsList] = useState([]);
  const [anonymousSummary, setAnonymousSummary] = useState(null);
  const [anonymousByDept, setAnonymousByDept] = useState([]);
  const [anonymousIdeasList, setAnonymousIdeasList] = useState([]);
  const [anonymousCommentsList, setAnonymousCommentsList] = useState([]);
  const [checkedAnonymousIdeas, setCheckedAnonymousIdeas] = useState({});
  const [checkedAnonymousComments, setCheckedAnonymousComments] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [activeReport, setActiveReport] = useState('ideas_by_dept');

  const selectedSessionMeta = sessions.find((s) => String(s.id) === String(selectedSession));
  const exportReadyAt = selectedSessionMeta
    ? (selectedSessionMeta.final_closure_date || selectedSessionMeta.closes_at)
    : null;
  const exportAllowedByDate = exportReadyAt ? new Date(exportReadyAt).getTime() <= Date.now() : true;

  // Fetch sessions
  useEffect(() => {
    const fetchSessions = async () => {
      try {
        const response = await apiClient.get('/sessions.php');
        setSessions(response.data.data || []);
        if (response.data.data?.length > 0) {
          setSelectedSession(response.data.data[0].id);
        }
      } catch (error) {
        console.error('Failed to fetch sessions');
      }
    };
    fetchSessions();
  }, []);

  // Fetch reports
  const fetchReports = async () => {
    setIsLoading(true);
    try {
      const params = selectedSession ? `&session_id=${selectedSession}` : '';
      
      const [
        ideaDept,
        deptPct,
        contrib,
        status,
        inappropriate,
        noCommentSummary,
        noCommentList,
        anonSummary,
        anonByDept,
        anonIdeaList,
        anonCommentList,
      ] = await Promise.all([
        apiClient.get(`/QA_reports.php?action=ideas_by_department${params}`),
        apiClient.get(`/QA_reports.php?action=department_percentage${params}`),
        apiClient.get(`/QA_reports.php?action=contributors_by_department${params}`),
        apiClient.get(`/QA_reports.php?action=ideas_status_summary${params}`),
        apiClient.get('/QA_reports.php?action=inappropriate_stats'),
        apiClient.get(`/QA_reports.php?action=ideas_without_comments_summary${params}`),
        apiClient.get(`/QA_reports.php?action=ideas_without_comments_list${params}`),
        apiClient.get(`/QA_reports.php?action=anonymous_activity_summary${params}`),
        apiClient.get(`/QA_reports.php?action=anonymous_activity_by_department${params}`),
        apiClient.get(`/QA_reports.php?action=anonymous_ideas_list${params}`),
        apiClient.get(`/QA_reports.php?action=anonymous_comments_list${params}`),
      ]);

      setIdeasByDept(ideaDept.data.data || []);
      setDeptPercentage(deptPct.data.data || []);
      setContributors(contrib.data.data || []);
      setStatusSummary(status.data.data || []);
      setInappropriateStats(inappropriate.data.data || {});
      setIdeasNoCommentsSummary(noCommentSummary.data.data || []);
      setIdeasNoCommentsList(noCommentList.data.data || []);
      setAnonymousSummary(anonSummary.data.data || {});
      setAnonymousByDept(anonByDept.data.data || []);
      setAnonymousIdeasList(anonIdeaList.data.data || []);
      setAnonymousCommentsList(anonCommentList.data.data || []);
      onError('');
    } catch (error) {
      onError('Failed to fetch reports');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    if (selectedSession !== null) {
      fetchReports();
    }
  }, [selectedSession, activeReport]);

  const handleExportCSV = async () => {
    if (!exportAllowedByDate && exportReadyAt) {
      onError(`Export is available after ${new Date(exportReadyAt).toLocaleString()}`);
      return;
    }

    try {
      const response = await apiClient.get(
        `/QA_reports.php?action=export_csv${selectedSession ? `&session_id=${selectedSession}` : ''}`,
        { responseType: 'blob' }
      );

      if ((response.headers?.['content-type'] || '').includes('application/json')) {
        const message = await extractErrorMessage({ response }, 'Failed to export CSV');
        onError(message);
        return;
      }

      const blob = new Blob([response.data], { type: response.headers?.['content-type'] || 'text/csv' });
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = getFilenameFromDisposition(
        response.headers?.['content-disposition'],
        `ideas_export_${new Date().toISOString().split('T')[0]}.csv`
      );
      link.click();
      onError('');
    } catch (error) {
      const message = await extractErrorMessage(error, 'Failed to export CSV');
      onError(message);
    }
  };

  const handleExportZIP = async () => {
    if (!exportAllowedByDate && exportReadyAt) {
      onError(`Export is available after ${new Date(exportReadyAt).toLocaleString()}`);
      return;
    }

    try {
      const response = await apiClient.get(
        `/QA_reports.php?action=export_zip${selectedSession ? `&session_id=${selectedSession}` : ''}`,
        { responseType: 'blob' }
      );

      if ((response.headers?.['content-type'] || '').includes('application/json')) {
        const message = await extractErrorMessage({ response }, 'Failed to export attachments');
        onError(message);
        return;
      }

      const blob = new Blob([response.data], { type: response.headers?.['content-type'] || 'application/zip' });
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = getFilenameFromDisposition(
        response.headers?.['content-disposition'],
        `attachments_${new Date().toISOString().split('T')[0]}.zip`
      );
      link.click();
      onError('');
    } catch (error) {
      const message = await extractErrorMessage(error, 'Failed to export attachments');
      onError(message);
    }
  };

  const toggleChecked = (type, id) => {
    if (type === 'idea') {
      setCheckedAnonymousIdeas((prev) => ({ ...prev, [id]: !prev[id] }));
    } else {
      setCheckedAnonymousComments((prev) => ({ ...prev, [id]: !prev[id] }));
    }
  };

  return (
    <div className="space-y-6">
      <div className="mb-8">
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">Statistical Analysis & Reports</h2>
        
        {/* Session Selector */}
        <div className="mb-6 flex flex-col gap-4 lg:flex-row lg:items-end">
          <div className="w-full lg:flex-1">
            <label className="block text-sm font-medium text-neutral-700 mb-2">Select Session</label>
            <select
              value={selectedSession}
              onChange={(e) => setSelectedSession(e.target.value)}
              className="w-full px-3 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 outline-none"
            >
              <option value="">All Sessions</option>
              {sessions.map((s) => (
                <option key={s.id} value={s.id}>{s.session_name}</option>
              ))}
            </select>
          </div>

          {/* Export Buttons */}
          <div className="grid w-full grid-cols-1 gap-2 sm:grid-cols-2 lg:w-auto">
            <button
              onClick={handleExportCSV}
              disabled={!exportAllowedByDate}
              className="w-full rounded-lg bg-primary-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-primary-700 disabled:cursor-not-allowed disabled:bg-neutral-400 disabled:hover:bg-neutral-400"
            >
              Export CSV
            </button>
            <button
              onClick={handleExportZIP}
              disabled={!exportAllowedByDate}
              className="w-full rounded-lg bg-primary-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-primary-700 disabled:cursor-not-allowed disabled:bg-neutral-400 disabled:hover:bg-neutral-400"
            >
              Export ZIP
            </button>
          </div>
        </div>
        {!exportAllowedByDate && exportReadyAt && (
          <p className="text-sm text-amber-700">
            Export will be available after {new Date(exportReadyAt).toLocaleString()}.
          </p>
        )}
      </div>

      {/* Report Tabs */}
      <div className="mb-6 flex gap-2 overflow-x-auto pb-2">
        {[
          { id: 'ideas_by_dept', label: 'Ideas by Department' },
          { id: 'dept_percentage', label: 'Department %' },
          { id: 'contributors', label: 'Contributors' },
          { id: 'status', label: 'Status Summary' },
          { id: 'ideas_no_comments', label: 'Ideas Without Comments' },
          { id: 'anonymous_activity', label: 'Anonymous Activity' },
          { id: 'anonymous_lists', label: 'Anonymous Checklists' },
          { id: 'inappropriate', label: 'Inappropriate Content' },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveReport(tab.id)}
            className={`px-4 py-2 rounded-lg font-medium text-sm whitespace-nowrap transition ${
              activeReport === tab.id
                ? 'bg-primary-600 text-white'
                : 'bg-neutral-200 text-neutral-700 hover:bg-neutral-300'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Reports */}
      {isLoading ? (
        <div className="text-center py-12">
          <p className="text-neutral-600">Loading reports...</p>
        </div>
      ) : (
        <>
          {/* Ideas by Department */}
          {activeReport === 'ideas_by_dept' && ideasByDept.length > 0 && (
            <div className="bg-white rounded-lg border border-neutral-200 p-6">
              <h3 className="text-lg font-semibold text-neutral-900 mb-6">Number of Ideas by Department</h3>
              
              <ResponsiveContainer width="100%" height={400}>
                <BarChart data={ideasByDept}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="department" />
                  <YAxis />
                  <Tooltip />
                  <Legend />
                  <Bar dataKey="total_ideas" fill="#0EA5E9" name="Total Ideas" />
                  <Bar dataKey="approved" fill="#10B981" name="Approved" />
                  <Bar dataKey="pending" fill="#F59E0B" name="Pending" />
                  <Bar dataKey="flagged" fill="#EF4444" name="Flagged" />
                </BarChart>
              </ResponsiveContainer>

              {/* Table */}
              <div className="mt-8 overflow-x-auto">
                <table className="min-w-[720px] w-full text-sm">
                  <thead className="bg-neutral-100">
                    <tr>
                      <th className="px-4 py-2 text-left">Department</th>
                      <th className="px-4 py-2 text-center">Total</th>
                      <th className="px-4 py-2 text-center">Approved</th>
                      <th className="px-4 py-2 text-center">Pending</th>
                      <th className="px-4 py-2 text-center">Flagged</th>
                      <th className="px-4 py-2 text-center">Avg Likes</th>
                    </tr>
                  </thead>
                  <tbody>
                    {ideasByDept.map((row, idx) => (
                      <tr key={idx} className={idx % 2 === 0 ? 'bg-neutral-50' : ''}>
                        <td className="px-4 py-2">{row.department}</td>
                        <td className="px-4 py-2 text-center font-semibold">{row.total_ideas}</td>
                        <td className="px-4 py-2 text-center text-success-600">{row.approved}</td>
                        <td className="px-4 py-2 text-center text-warning-600">{row.pending}</td>
                        <td className="px-4 py-2 text-center text-danger-600">{row.flagged}</td>
                        <td className="px-4 py-2 text-center">{asNumber(row.avg_likes).toFixed(1)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Department Percentage */}
          {activeReport === 'dept_percentage' && deptPercentage.length > 0 && (
            <div className="bg-white rounded-lg border border-neutral-200 p-6">
              <h3 className="text-lg font-semibold text-neutral-900 mb-6">Percentage of Ideas by Department</h3>
              
              <ResponsiveContainer width="100%" height={400}>
                <PieChart>
                  <Pie
                    data={deptPercentage}
                    dataKey="percentage"
                    nameKey="department"
                    cx="50%"
                    cy="50%"
                    outerRadius={150}
                    label
                  >
                    {deptPercentage.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                    ))}
                  </Pie>
                  <Tooltip formatter={(value) => `${asNumber(value).toFixed(2)}%`} />
                </PieChart>
              </ResponsiveContainer>

              {/* Legend Table */}
              <div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3">
                {deptPercentage.map((row, idx) => (
                  <div key={idx} className="p-3 bg-neutral-50 rounded-lg border border-neutral-200">
                    <p className="text-sm font-medium text-neutral-900">{row.department}</p>
                    <p className="text-lg font-semibold text-primary-600">{row.percentage}%</p>
                    <p className="text-xs text-neutral-600">{row.count} ideas</p>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Contributors by Department */}
          {activeReport === 'contributors' && contributors.length > 0 && (
            <div className="bg-white rounded-lg border border-neutral-200 p-6">
              <h3 className="text-lg font-semibold text-neutral-900 mb-6">Number of Contributors by Department</h3>
              
              <ResponsiveContainer width="100%" height={400}>
                <BarChart data={contributors} layout="vertical">
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis type="number" />
                  <YAxis dataKey="department" type="category" width={150} />
                  <Tooltip />
                  <Legend />
                  <Bar dataKey="contributor_count" fill="#8B5CF6" name="Contributors" />
                  <Bar dataKey="total_ideas" fill="#0EA5E9" name="Ideas" />
                </BarChart>
              </ResponsiveContainer>

              {/* Table */}
              <div className="mt-8 overflow-x-auto">
                <table className="min-w-[720px] w-full text-sm">
                  <thead className="bg-neutral-100">
                    <tr>
                      <th className="px-4 py-2 text-left">Department</th>
                      <th className="px-4 py-2 text-center">Contributors</th>
                      <th className="px-4 py-2 text-center">Total Ideas</th>
                      <th className="px-4 py-2 text-center">Avg Engagement</th>
                    </tr>
                  </thead>
                  <tbody>
                    {contributors.map((row, idx) => (
                      <tr key={idx} className={idx % 2 === 0 ? 'bg-neutral-50' : ''}>
                        <td className="px-4 py-2">{row.department}</td>
                        <td className="px-4 py-2 text-center font-semibold">{row.contributor_count}</td>
                        <td className="px-4 py-2 text-center">{row.total_ideas}</td>
                        <td className="px-4 py-2 text-center">{asNumber(row.avg_engagement).toFixed(2)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* Status Summary */}
          {activeReport === 'status' && statusSummary.length > 0 && (
            <div className="bg-white rounded-lg border border-neutral-200 p-6">
              <h3 className="text-lg font-semibold text-neutral-900 mb-6">Ideas Status Summary</h3>
              
              <div className="mb-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
                {statusSummary.map((row, idx) => (
                  <div key={idx} className="p-4 bg-neutral-50 rounded-lg border border-neutral-200 text-center">
                    <p className="text-sm text-neutral-600 mb-1">{row.status}</p>
                    <p className="text-2xl font-bold text-primary-600">{row.count}</p>
                  </div>
                ))}
              </div>

              <ResponsiveContainer width="100%" height={300}>
                <BarChart data={statusSummary}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="status" />
                  <YAxis />
                  <Tooltip />
                  <Bar dataKey="count" fill="#0EA5E9" />
                </BarChart>
              </ResponsiveContainer>
            </div>
          )}

          {/* Inappropriate Content Stats */}
          {activeReport === 'inappropriate' && inappropriateStats && (
            <div className="bg-white rounded-lg border border-neutral-200 p-6">
              <h3 className="text-lg font-semibold text-neutral-900 mb-6">Inappropriate Content Summary</h3>
              
              <div className="mb-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
                <div className="p-4 bg-danger-50 rounded-lg border border-danger-200">
                  <p className="text-sm text-danger-700 mb-1">Flagged Ideas</p>
                  <p className="text-3xl font-bold text-danger-600">{inappropriateStats.total_flagged_ideas || 0}</p>
                </div>
                <div className="p-4 bg-danger-50 rounded-lg border border-danger-200">
                  <p className="text-sm text-danger-700 mb-1">Flagged Comments</p>
                  <p className="text-3xl font-bold text-danger-600">{inappropriateStats.total_flagged_comments || 0}</p>
                </div>
                <div className="p-4 bg-warning-50 rounded-lg border border-warning-200">
                  <p className="text-sm text-warning-700 mb-1">Disabled Users</p>
                  <p className="text-3xl font-bold text-warning-600">{inappropriateStats.disabled_users || 0}</p>
                </div>
                <div className="p-4 bg-danger-50 rounded-lg border border-danger-200">
                  <p className="text-sm text-danger-700 mb-1">Blocked Users</p>
                  <p className="text-3xl font-bold text-danger-600">{inappropriateStats.blocked_users || 0}</p>
                </div>
              </div>

              {inappropriateStats.recent_flags && inappropriateStats.recent_flags.length > 0 && (
                <div className="mt-6">
                  <h4 className="text-sm font-semibold text-neutral-900 mb-3">Recent Flagging Activity (Last 30 days)</h4>
                  <div className="space-y-2">
                    {inappropriateStats.recent_flags.map((flag, idx) => (
                      <div key={idx} className="flex flex-col gap-2 rounded border border-neutral-200 bg-neutral-50 p-3 sm:flex-row sm:items-center sm:justify-between">
                        <div>
                          <p className="text-sm font-medium text-neutral-900">{flag.action}</p>
                          <p className="text-xs text-neutral-600">{new Date(flag.last_action).toLocaleDateString()}</p>
                        </div>
                        <p className="text-lg font-bold text-primary-600">{flag.count}</p>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          )}

          {/* Ideas Without Comments */}
          {activeReport === 'ideas_no_comments' && (
            <div className="space-y-6">
              <div className="bg-white rounded-lg border border-neutral-200 p-6">
                <h3 className="text-lg font-semibold text-neutral-900 mb-6">Ideas Without Comments</h3>

                {ideasNoCommentsSummary.length > 0 ? (
                  <ResponsiveContainer width="100%" height={360}>
                    <BarChart data={ideasNoCommentsSummary}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="department" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="no_comment_ideas" fill="#0EA5E9" name="No Comment Ideas" />
                      <Bar dataKey="approved" fill="#10B981" name="Approved" />
                      <Bar dataKey="pending" fill="#F59E0B" name="Pending" />
                      <Bar dataKey="flagged" fill="#EF4444" name="Flagged" />
                    </BarChart>
                  </ResponsiveContainer>
                ) : (
                  <p className="text-sm text-neutral-600">No ideas without comments for the selected scope.</p>
                )}
              </div>

              <div className="bg-white rounded-lg border border-neutral-200 p-6">
                <h4 className="text-sm font-semibold text-neutral-900 mb-3">Checklist: Ideas Without Comments</h4>
                <div className="overflow-x-auto">
                  <table className="min-w-[720px] w-full text-sm">
                    <thead className="bg-neutral-100">
                      <tr>
                        <th className="px-4 py-2 text-left">Check</th>
                        <th className="px-4 py-2 text-left">Idea</th>
                        <th className="px-4 py-2 text-left">Department</th>
                        <th className="px-4 py-2 text-center">Status</th>
                        <th className="px-4 py-2 text-center">Anonymous</th>
                        <th className="px-4 py-2 text-center">Submitted</th>
                      </tr>
                    </thead>
                    <tbody>
                      {ideasNoCommentsList.length > 0 ? (
                        ideasNoCommentsList.map((row) => (
                          <tr key={row.id} className="odd:bg-neutral-50">
                            <td className="px-4 py-2">
                              <input
                                type="checkbox"
                                checked={!!checkedAnonymousIdeas[`no_comment_${row.id}`]}
                                onChange={() => toggleChecked('idea', `no_comment_${row.id}`)}
                              />
                            </td>
                            <td className="px-4 py-2 font-medium text-neutral-900">{row.title}</td>
                            <td className="px-4 py-2">{row.department}</td>
                            <td className="px-4 py-2 text-center">{row.approval_status}</td>
                            <td className="px-4 py-2 text-center">{row.is_anonymous ? 'Yes' : 'No'}</td>
                            <td className="px-4 py-2 text-center">
                              {row.submitted_at ? new Date(row.submitted_at).toLocaleDateString() : '-'}
                            </td>
                          </tr>
                        ))
                      ) : (
                        <tr>
                          <td className="px-4 py-6 text-center text-neutral-500" colSpan={6}>
                            No ideas without comments found.
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {/* Anonymous Activity */}
          {activeReport === 'anonymous_activity' && (
            <div className="space-y-6">
              <div className="bg-white rounded-lg border border-neutral-200 p-6">
                <h3 className="text-lg font-semibold text-neutral-900 mb-6">Anonymous Activity Overview</h3>

                <div className="mb-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
                  <div className="p-4 bg-neutral-50 rounded-lg border border-neutral-200">
                    <p className="text-sm text-neutral-600 mb-1">Anonymous Ideas</p>
                    <p className="text-2xl font-bold text-primary-600">{anonymousSummary?.anonymous_ideas || 0}</p>
                    <p className="text-xs text-neutral-500">{anonymousSummary?.anonymous_idea_pct || 0}% of ideas</p>
                  </div>
                  <div className="p-4 bg-neutral-50 rounded-lg border border-neutral-200">
                    <p className="text-sm text-neutral-600 mb-1">Anonymous Comments</p>
                    <p className="text-2xl font-bold text-primary-600">{anonymousSummary?.anonymous_comments || 0}</p>
                    <p className="text-xs text-neutral-500">{anonymousSummary?.anonymous_comment_pct || 0}% of comments</p>
                  </div>
                  <div className="p-4 bg-neutral-50 rounded-lg border border-neutral-200">
                    <p className="text-sm text-neutral-600 mb-1">Total Ideas</p>
                    <p className="text-2xl font-bold text-neutral-700">{anonymousSummary?.total_ideas || 0}</p>
                  </div>
                  <div className="p-4 bg-neutral-50 rounded-lg border border-neutral-200">
                    <p className="text-sm text-neutral-600 mb-1">Total Comments</p>
                    <p className="text-2xl font-bold text-neutral-700">{anonymousSummary?.total_comments || 0}</p>
                  </div>
                </div>

                {anonymousByDept.length > 0 ? (
                  <ResponsiveContainer width="100%" height={380}>
                    <BarChart data={anonymousByDept}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="department" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="anonymous_ideas" fill="#0EA5E9" name="Anonymous Ideas" />
                      <Bar dataKey="anonymous_comments" fill="#10B981" name="Anonymous Comments" />
                    </BarChart>
                  </ResponsiveContainer>
                ) : (
                  <p className="text-sm text-neutral-600">No anonymous activity for the selected scope.</p>
                )}
              </div>
            </div>
          )}

          {/* Anonymous Checklists */}
          {activeReport === 'anonymous_lists' && (
            <div className="space-y-6">
              <div className="bg-white rounded-lg border border-neutral-200 p-6">
                <h3 className="text-lg font-semibold text-neutral-900 mb-4">Anonymous Ideas Checklist</h3>
                <div className="overflow-x-auto">
                  <table className="min-w-[720px] w-full text-sm">
                    <thead className="bg-neutral-100">
                      <tr>
                        <th className="px-4 py-2 text-left">Check</th>
                        <th className="px-4 py-2 text-left">Idea</th>
                        <th className="px-4 py-2 text-left">Department</th>
                        <th className="px-4 py-2 text-center">Status</th>
                        <th className="px-4 py-2 text-center">Comments</th>
                        <th className="px-4 py-2 text-center">Submitted</th>
                      </tr>
                    </thead>
                    <tbody>
                      {anonymousIdeasList.length > 0 ? (
                        anonymousIdeasList.map((row) => (
                          <tr key={row.id} className="odd:bg-neutral-50">
                            <td className="px-4 py-2">
                              <input
                                type="checkbox"
                                checked={!!checkedAnonymousIdeas[row.id]}
                                onChange={() => toggleChecked('idea', row.id)}
                              />
                            </td>
                            <td className="px-4 py-2 font-medium text-neutral-900">{row.title}</td>
                            <td className="px-4 py-2">{row.department}</td>
                            <td className="px-4 py-2 text-center">{row.approval_status}</td>
                            <td className="px-4 py-2 text-center">{row.comment_count}</td>
                            <td className="px-4 py-2 text-center">
                              {row.submitted_at ? new Date(row.submitted_at).toLocaleDateString() : '-'}
                            </td>
                          </tr>
                        ))
                      ) : (
                        <tr>
                          <td className="px-4 py-6 text-center text-neutral-500" colSpan={6}>
                            No anonymous ideas found.
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>

              <div className="bg-white rounded-lg border border-neutral-200 p-6">
                <h3 className="text-lg font-semibold text-neutral-900 mb-4">Anonymous Comments Checklist</h3>
                <div className="overflow-x-auto">
                  <table className="min-w-[720px] w-full text-sm">
                    <thead className="bg-neutral-100">
                      <tr>
                        <th className="px-4 py-2 text-left">Check</th>
                        <th className="px-4 py-2 text-left">Comment</th>
                        <th className="px-4 py-2 text-left">Idea</th>
                        <th className="px-4 py-2 text-left">Department</th>
                        <th className="px-4 py-2 text-center">Created</th>
                      </tr>
                    </thead>
                    <tbody>
                      {anonymousCommentsList.length > 0 ? (
                        anonymousCommentsList.map((row) => (
                          <tr key={row.id} className="odd:bg-neutral-50">
                            <td className="px-4 py-2">
                              <input
                                type="checkbox"
                                checked={!!checkedAnonymousComments[row.id]}
                                onChange={() => toggleChecked('comment', row.id)}
                              />
                            </td>
                            <td className="px-4 py-2">{row.content}</td>
                            <td className="px-4 py-2 font-medium text-neutral-900">{row.idea_title}</td>
                            <td className="px-4 py-2">{row.department}</td>
                            <td className="px-4 py-2 text-center">
                              {row.created_at ? new Date(row.created_at).toLocaleDateString() : '-'}
                            </td>
                          </tr>
                        ))
                      ) : (
                        <tr>
                          <td className="px-4 py-6 text-center text-neutral-500" colSpan={5}>
                            No anonymous comments found.
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
}



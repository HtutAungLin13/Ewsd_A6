import { useEffect, useState } from 'react';
import apiClient from '../services/api';

export default function QAMonitoringSecurity({ onError }) {
  const [isLoading, setIsLoading] = useState(false);
  const [engagement, setEngagement] = useState({});
  const [monitoring, setMonitoring] = useState({});
  const [security, setSecurity] = useState({});
  const [coordinators, setCoordinators] = useState({});

  const fetchAll = async () => {
    setIsLoading(true);
    try {
      const [engagementRes, monitoringRes, securityRes, coordinatorRes] = await Promise.all([
        apiClient.get('/QA_reports.php?action=engagement_overview'),
        apiClient.get('/QA_reports.php?action=monitoring_overview'),
        apiClient.get('/QA_reports.php?action=security_audit'),
        apiClient.get('/QA_reports.php?action=coordinator_overview')
      ]);

      setEngagement(engagementRes.data.data || {});
      setMonitoring(monitoringRes.data.data || {});
      setSecurity(securityRes.data.data || {});
      setCoordinators(coordinatorRes.data.data || {});
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load monitoring/security data');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchAll();
  }, []);

  if (isLoading) {
    return <p className="text-neutral-600">Loading monitoring data...</p>;
  }

  const popularIdeas = engagement.most_popular_ideas || [];
  const viewedIdeas = engagement.most_viewed_ideas || [];
  const latestIdeas = engagement.latest_ideas || [];
  const latestComments = engagement.latest_comments || [];
  const activeUsers = monitoring.most_active_users || [];
  const browserUsage = monitoring.browser_usage || [];
  const viewedPages = monitoring.most_viewed_pages || [];
  const loginActivity = security.login_activity || [];
  const suspicious = security.suspicious_activity || [];
  const coordinatorList = coordinators.coordinators || [];

  return (
    <div className="space-y-8">
      <div>
        <h2 className="text-xl font-semibold text-neutral-900 mb-4">Monitoring, Security, and Coordination</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-white rounded-lg border border-neutral-200 p-4">
            <p className="text-sm text-neutral-600">Storage Files</p>
            <p className="text-2xl font-semibold text-neutral-900">{Number(monitoring.storage_usage?.total_files || 0)}</p>
          </div>
          <div className="bg-white rounded-lg border border-neutral-200 p-4">
            <p className="text-sm text-neutral-600">Audit Entries (7 days)</p>
            <p className="text-2xl font-semibold text-neutral-900">{Number(security.audit_summary?.last_7_days || 0)}</p>
          </div>
          <div className="bg-white rounded-lg border border-neutral-200 p-4">
            <p className="text-sm text-neutral-600">Suspicious Accounts</p>
            <p className="text-2xl font-semibold text-danger-600">{suspicious.length}</p>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Most Popular Ideas</h3>
          <div className="space-y-2">
            {popularIdeas.slice(0, 5).map((idea) => (
              <div key={idea.id} className="text-sm flex justify-between gap-3">
                <span className="text-neutral-700 truncate">{idea.title}</span>
                <span className="font-medium text-neutral-900">Score {idea.popularity_score}</span>
              </div>
            ))}
            {popularIdeas.length === 0 && <p className="text-sm text-neutral-500">No popular ideas available yet.</p>}
          </div>
        </section>

        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Most Viewed Ideas</h3>
          <div className="space-y-2">
            {viewedIdeas.slice(0, 5).map((idea) => (
              <div key={idea.id} className="text-sm flex justify-between gap-3">
                <span className="text-neutral-700 truncate">{idea.title}</span>
                <span className="font-medium text-neutral-900">{idea.view_count} views</span>
              </div>
            ))}
            {viewedIdeas.length === 0 && <p className="text-sm text-neutral-500">No view metrics available yet.</p>}
          </div>
        </section>

        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Latest Ideas</h3>
          <div className="space-y-2">
            {latestIdeas.slice(0, 5).map((idea) => (
              <div key={idea.id} className="text-sm">
                <p className="text-neutral-900 truncate">{idea.title || 'Untitled idea'}</p>
                <p className="text-neutral-500">{idea.submitted_at ? new Date(idea.submitted_at).toLocaleString() : 'Time not available'}</p>
              </div>
            ))}
            {latestIdeas.length === 0 && <p className="text-sm text-neutral-500">No recent ideas yet.</p>}
          </div>
        </section>

        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Latest Comments</h3>
          <div className="space-y-2">
            {latestComments.slice(0, 5).map((comment) => (
              <div key={comment.id} className="text-sm">
                <p className="text-neutral-600 truncate">
                  {(comment.is_anonymous ? 'Anonymous' : (comment.contributor_name || 'Unknown user'))} on {comment.idea_title || 'Untitled idea'}
                </p>
                <p className="text-neutral-900">{comment.content || 'No comment content available'}</p>
              </div>
            ))}
            {latestComments.length === 0 && <p className="text-sm text-neutral-500">No recent comments yet.</p>}
          </div>
        </section>
      </div>

      <section className="bg-white rounded-lg border border-neutral-200 p-4">
        <h3 className="font-semibold text-neutral-900 mb-3">Most Active Users</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100">
              <tr>
                <th className="px-3 py-2 text-left">User</th>
                <th className="px-3 py-2 text-left">Department</th>
                <th className="px-3 py-2 text-right">Ideas</th>
                <th className="px-3 py-2 text-right">Comments</th>
                <th className="px-3 py-2 text-right">Score</th>
              </tr>
            </thead>
            <tbody>
              {activeUsers.slice(0, 10).map((user) => (
                <tr key={user.contributor_id} className="border-b border-neutral-200">
                  <td className="px-3 py-2">{user.name || 'Anonymous'}</td>
                  <td className="px-3 py-2">{user.department || 'Department not set'}</td>
                  <td className="px-3 py-2 text-right">{user.ideas_submitted}</td>
                  <td className="px-3 py-2 text-right">{user.comments_posted}</td>
                  <td className="px-3 py-2 text-right font-semibold">{user.activity_score}</td>
                </tr>
              ))}
              {activeUsers.length === 0 && (
                <tr>
                  <td className="px-3 py-3 text-neutral-500" colSpan={5}>No active user data available yet.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Browser Usage</h3>
          <div className="space-y-2">
            {browserUsage.map((row) => (
              <div key={row.browser_name} className="text-sm flex justify-between">
                <span>{row.browser_name || 'Unknown browser'}</span>
                <span className="font-medium">{row.session_count}</span>
              </div>
            ))}
            {browserUsage.length === 0 && <p className="text-sm text-neutral-500">No session data.</p>}
          </div>
        </section>

        <section className="bg-white rounded-lg border border-neutral-200 p-4">
          <h3 className="font-semibold text-neutral-900 mb-3">Most Viewed Pages</h3>
          <div className="space-y-2">
            {viewedPages.map((page) => (
              <div key={page.page_path} className="text-sm flex justify-between gap-3">
                <span className="truncate">{page.page_title || page.page_path || 'Untitled page'}</span>
                <span className="font-medium">{page.view_count}</span>
              </div>
            ))}
            {viewedPages.length === 0 && <p className="text-sm text-neutral-500">No page view data.</p>}
          </div>
        </section>
      </div>

      <section className="bg-white rounded-lg border border-neutral-200 p-4">
        <h3 className="font-semibold text-neutral-900 mb-3">Login Activity (30 days)</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100">
              <tr>
                <th className="px-3 py-2 text-left">User</th>
                <th className="px-3 py-2 text-left">Role</th>
                <th className="px-3 py-2 text-right">Logins</th>
                <th className="px-3 py-2 text-right">Distinct IP</th>
                <th className="px-3 py-2 text-left">Last Login</th>
              </tr>
            </thead>
            <tbody>
              {loginActivity.slice(0, 20).map((row) => (
                <tr key={row.admin_id} className="border-b border-neutral-200">
                  <td className="px-3 py-2">{row.full_name || 'Unknown user'}</td>
                  <td className="px-3 py-2">{row.role || 'N/A'}</td>
                  <td className="px-3 py-2 text-right">{row.login_count_30d}</td>
                  <td className="px-3 py-2 text-right">{row.distinct_ip_30d}</td>
                  <td className="px-3 py-2">{row.last_login_at ? new Date(row.last_login_at).toLocaleString() : 'Never'}</td>
                </tr>
              ))}
              {loginActivity.length === 0 && (
                <tr>
                  <td className="px-3 py-3 text-neutral-500" colSpan={5}>No login activity captured yet.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>

      <section className="bg-white rounded-lg border border-neutral-200 p-4">
        <h3 className="font-semibold text-neutral-900 mb-3">QA Coordinator Oversight</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100">
              <tr>
                <th className="px-3 py-2 text-left">Department</th>
                <th className="px-3 py-2 text-left">Coordinator</th>
                <th className="px-3 py-2 text-left">Email</th>
                <th className="px-3 py-2 text-right">Ideas</th>
                <th className="px-3 py-2 text-right">Contributors</th>
              </tr>
            </thead>
            <tbody>
              {coordinatorList.map((row, idx) => (
                <tr key={`${row.department}-${idx}`} className="border-b border-neutral-200">
                  <td className="px-3 py-2">{row.department || 'Department not set'}</td>
                  <td className="px-3 py-2">{row.coordinator_name || 'Not assigned yet'}</td>
                  <td className="px-3 py-2">{row.coordinator_email || 'No email available'}</td>
                  <td className="px-3 py-2 text-right">{row.ideas_in_department || 0}</td>
                  <td className="px-3 py-2 text-right">{row.contributors_in_department || 0}</td>
                </tr>
              ))}
              {coordinatorList.length === 0 && (
                <tr>
                  <td className="px-3 py-3 text-neutral-500" colSpan={5}>No coordinator coverage data available yet.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}

import { useEffect, useState } from 'react';
import { adminManagementAPI } from '../services/api';

function formatBytes(bytes) {
  const value = Number(bytes || 0);
  if (value < 1024) return `${value} B`;
  if (value < 1024 * 1024) return `${(value / 1024).toFixed(2)} KB`;
  if (value < 1024 * 1024 * 1024) return `${(value / (1024 * 1024)).toFixed(2)} MB`;
  return `${(value / (1024 * 1024 * 1024)).toFixed(2)} GB`;
}

export default function AdminMonitoringTab({ onError }) {
  const [activityLogs, setActivityLogs] = useState([]);
  const [loginHistory, setLoginHistory] = useState([]);
  const [storageUsage, setStorageUsage] = useState(null);
  const [suspicious, setSuspicious] = useState(null);
  const [systemReport, setSystemReport] = useState(null);

  const fetchData = async () => {
    try {
      const [logsRes, loginRes, storageRes, suspiciousRes, reportRes] = await Promise.all([
        adminManagementAPI.getActivityLogs({ page: 1, per_page: 20 }),
        adminManagementAPI.getLoginHistory({ page: 1, per_page: 20 }),
        adminManagementAPI.getStorageUsage(),
        adminManagementAPI.getSuspiciousActivities(),
        adminManagementAPI.getSystemReport(),
      ]);
      setActivityLogs(logsRes.data.data || []);
      setLoginHistory(loginRes.data.data || []);
      setStorageUsage(storageRes.data.data || null);
      setSuspicious(suspiciousRes.data.data || null);
      setSystemReport(reportRes.data.data || null);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load monitoring data');
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div className="space-y-6">
      <h2 className="text-xl font-semibold text-neutral-900">Monitoring, Reports & Security Audit</h2>

      {systemReport && (
        <section className="rounded border border-neutral-200 bg-white p-4">
          <h3 className="mb-3 text-base font-semibold text-neutral-900">System Report Summary</h3>
          <div className="grid grid-cols-2 gap-3 md:grid-cols-3 xl:grid-cols-6">
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Total Users</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.total_users || 0}</p>
            </div>
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Active Users</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.active_users || 0}</p>
            </div>
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Active Sessions</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.active_sessions || 0}</p>
            </div>
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Total Ideas</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.total_ideas || 0}</p>
            </div>
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Total Comments</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.total_comments || 0}</p>
            </div>
            <div className="rounded bg-neutral-50 p-3 text-center">
              <p className="text-xs text-neutral-600">Total Documents</p>
              <p className="text-xl font-bold text-neutral-900">{systemReport.totals?.total_documents || 0}</p>
            </div>
          </div>
        </section>
      )}

      {storageUsage && (
        <section className="rounded border border-neutral-200 bg-white p-4">
          <h3 className="mb-3 text-base font-semibold text-neutral-900">Storage Usage</h3>
          <p className="text-sm text-neutral-700">
            Files: {storageUsage.summary?.total_files || 0} | Size: {formatBytes(storageUsage.summary?.total_bytes)} | Flagged:{' '}
            {storageUsage.summary?.flagged_files || 0}
          </p>
          <div className="mt-2 flex flex-wrap gap-2">
            {(storageUsage.by_type || []).map((row) => (
              <span key={row.file_type} className="rounded bg-neutral-100 px-2 py-1 text-xs text-neutral-700">
                {row.file_type || 'unknown'}: {row.file_count} ({formatBytes(row.bytes)})
              </span>
            ))}
          </div>
        </section>
      )}

      {suspicious && (
        <section className="rounded border border-neutral-200 bg-white p-4">
          <h3 className="mb-3 text-base font-semibold text-neutral-900">Suspicious Activity Detection</h3>
          <p className="mb-2 text-sm text-neutral-700">Active user sessions now: {suspicious.active_user_count || 0}</p>
          <div className="space-y-2">
            {(suspicious.multi_ip_logins || []).map((item) => (
              <div key={item.admin_id} className="rounded border border-warning-200 bg-warning-50 px-3 py-2 text-sm text-warning-800">
                {item.user_name || 'Unknown user'} ({item.email || 'No email'}) used {item.ip_count || 0} IPs over {item.session_count || 0} sessions in last 7 days.
              </div>
            ))}
            {(suspicious.high_severity_reports || []).map((item) => (
              <div key={`report-${item.id}`} className="rounded border border-danger-200 bg-danger-50 px-3 py-2 text-sm text-danger-800">
                {item.severity} unresolved report for {item.content_type} #{item.content_id} ({item.report_category})
              </div>
            ))}
            {(!suspicious.multi_ip_logins?.length && !suspicious.high_severity_reports?.length) && (
              <p className="text-sm text-neutral-600">No suspicious signals detected.</p>
            )}
          </div>
        </section>
      )}

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Recent Audit Logs</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 text-neutral-700">
              <tr>
                <th className="px-3 py-2 text-left">Time</th>
                <th className="px-3 py-2 text-left">Admin</th>
                <th className="px-3 py-2 text-left">Action</th>
                <th className="px-3 py-2 text-left">Table</th>
                <th className="px-3 py-2 text-left">IP</th>
              </tr>
            </thead>
            <tbody>
              {activityLogs.map((log) => (
                <tr key={log.id} className="border-t border-neutral-100">
                  <td className="px-3 py-2">{log.created_at ? new Date(log.created_at).toLocaleString() : 'Time not available'}</td>
                  <td className="px-3 py-2">{log.admin_name || 'System Admin'}</td>
                  <td className="px-3 py-2">{log.action || 'No action label'}</td>
                  <td className="px-3 py-2">{log.table_name || 'N/A'}</td>
                  <td className="px-3 py-2">{log.ip_address || 'IP unavailable'}</td>
                </tr>
              ))}
              {activityLogs.length === 0 && (
                <tr>
                  <td className="px-3 py-3 text-neutral-500" colSpan={5}>No audit entries recorded yet.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Login History</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 text-neutral-700">
              <tr>
                <th className="px-3 py-2 text-left">Time</th>
                <th className="px-3 py-2 text-left">User</th>
                <th className="px-3 py-2 text-left">Role</th>
                <th className="px-3 py-2 text-left">IP</th>
                <th className="px-3 py-2 text-left">Expires</th>
              </tr>
            </thead>
            <tbody>
              {loginHistory.map((entry) => (
                <tr key={entry.id} className="border-t border-neutral-100">
                  <td className="px-3 py-2">{entry.created_at ? new Date(entry.created_at).toLocaleString() : 'Time not available'}</td>
                  <td className="px-3 py-2">{entry.user_name || 'Unknown user'}</td>
                  <td className="px-3 py-2">{entry.role || 'N/A'}</td>
                  <td className="px-3 py-2">{entry.ip_address || 'IP unavailable'}</td>
                  <td className="px-3 py-2">{entry.expires_at ? new Date(entry.expires_at).toLocaleString() : 'No expiry set'}</td>
                </tr>
              ))}
              {loginHistory.length === 0 && (
                <tr>
                  <td className="px-3 py-3 text-neutral-500" colSpan={5}>No login history available yet.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}

import { useEffect, useState } from 'react';
import { adminManagementAPI } from '../services/api';

export default function AdminModerationTab({ onError }) {
  const [reportedContent, setReportedContent] = useState([]);

  const fetchData = async () => {
    try {
      const response = await adminManagementAPI.getReportedContent();
      setReportedContent(response.data.data || []);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load reported content');
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const moderate = async (item, action) => {
    try {
      await adminManagementAPI.moderateContent({
        content_type: item.content_type,
        content_id: item.content_id,
        moderation_action: action,
        reason: action === 'disable' ? 'Disabled by admin moderation' : 'Re-enabled by admin moderation',
      });
      await fetchData();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed moderation action');
    }
  };

  const revealAuthor = async (item) => {
    try {
      const response = await adminManagementAPI.revealAuthor(item.content_type, item.content_id);
      const author = response.data.data;
      window.alert(`Author: ${author.name}\nEmail: ${author.email}\nDepartment: ${author.department || 'N/A'}\nAnonymous: ${author.is_anonymous ? 'Yes' : 'No'}`);
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to reveal author');
    }
  };

  return (
    <div className="space-y-4">
      <h2 className="text-xl font-semibold text-neutral-900">Content Moderation Support</h2>
      {reportedContent.length === 0 ? (
        <div className="rounded border border-neutral-200 bg-white p-5 text-sm text-neutral-600">No reported content.</div>
      ) : (
        <div className="space-y-3">
          {reportedContent.map((item) => (
            <div key={item.id} className="rounded border border-neutral-200 bg-white p-4">
              <div className="mb-2 flex flex-wrap items-center justify-between gap-2">
                <div>
                  <p className="text-sm font-semibold text-neutral-900">
                    {item.content_type} #{item.content_id} - {item.report_category}
                  </p>
                  <p className="text-xs text-neutral-600">
                    Severity: {item.severity} | Status: {item.status} | Reported: {new Date(item.reported_at).toLocaleString()}
                  </p>
                </div>
                <div className="flex gap-2">
                  <button type="button" onClick={() => moderate(item, 'disable')} className="rounded bg-danger-50 px-2 py-1 text-xs font-semibold text-danger-700">
                    Disable
                  </button>
                  <button type="button" onClick={() => moderate(item, 'enable')} className="rounded bg-emerald-50 px-2 py-1 text-xs font-semibold text-emerald-700">
                    Re-enable
                  </button>
                  <button type="button" onClick={() => revealAuthor(item)} className="rounded bg-warning-50 px-2 py-1 text-xs font-semibold text-warning-700">
                    Reveal Author
                  </button>
                </div>
              </div>
              <p className="text-sm text-neutral-700">{item.content_preview || item.reason}</p>
              {item.description && <p className="mt-1 text-xs text-neutral-600">{item.description}</p>}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

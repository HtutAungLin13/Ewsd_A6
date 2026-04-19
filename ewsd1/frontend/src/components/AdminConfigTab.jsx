import { useEffect, useState } from 'react';
import { adminManagementAPI } from '../services/api';

const defaultPasswordPolicy = {
  min_length: 8,
  require_uppercase: true,
  require_number: true,
  require_symbol: false,
};

const defaultSmtp = {
  host: '',
  port: 587,
  username: '',
  password: '',
  encryption: 'tls',
  from_email: '',
  from_name: 'Ideas System',
};

export default function AdminConfigTab({ onError }) {
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [terms, setTerms] = useState('');
  const [settings, setSettings] = useState({
    idea_submissions_enabled: true,
    commenting_enabled: true,
    default_ideas_per_page: 5,
    max_upload_size_mb: 10,
    allowed_file_types: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'jpeg', 'png', 'gif'],
    session_timeout_minutes: 1440,
    password_policy: defaultPasswordPolicy,
    smtp_settings: defaultSmtp,
  });
  const [templates, setTemplates] = useState([]);
  const [notificationSettings, setNotificationSettings] = useState([]);
  const [testEmail, setTestEmail] = useState('');

  const fetchAll = async () => {
    setLoading(true);
    try {
      const [termsRes, settingsRes, templatesRes, notifRes] = await Promise.all([
        adminManagementAPI.getTerms(),
        adminManagementAPI.getSystemSettings(),
        adminManagementAPI.listNotificationTemplates(),
        adminManagementAPI.listNotificationSettings(),
      ]);
      setTerms(termsRes.data.data?.content || '');
      setSettings((prev) => ({
        ...prev,
        ...(settingsRes.data.data || {}),
        password_policy: settingsRes.data.data?.password_policy || defaultPasswordPolicy,
        smtp_settings: settingsRes.data.data?.smtp_settings || defaultSmtp,
      }));
      setTemplates(templatesRes.data.data || []);
      setNotificationSettings(notifRes.data.data || []);
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to load configuration');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchAll();
  }, []);

  const saveCoreSettings = async () => {
    setSaving(true);
    try {
      await adminManagementAPI.updateSystemSettings(settings);
      await adminManagementAPI.updateTerms({ content: terms });
      onError('');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save settings');
    } finally {
      setSaving(false);
    }
  };

  const saveTemplate = async (template) => {
    try {
      await adminManagementAPI.saveNotificationTemplate(template);
      await fetchAll();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to save template');
    }
  };

  const toggleNotification = async (notificationKey, nextValue) => {
    try {
      await adminManagementAPI.updateNotificationSetting({
        notification_key: notificationKey,
        is_enabled: nextValue ? 1 : 0,
      });
      await fetchAll();
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to update notification');
    }
  };

  const sendTest = async () => {
    if (!testEmail) {
      onError('Enter an email address for test notification');
      return;
    }
    try {
      await adminManagementAPI.testEmail({ recipient_email: testEmail, template_key: 'idea_submitted' });
      onError('');
      window.alert('Test email sent successfully.');
    } catch (error) {
      onError(error.response?.data?.message || 'Failed to send test notification');
    }
  };

  if (loading) {
    return <div className="rounded border border-neutral-200 bg-white p-5 text-sm text-neutral-600">Loading system configuration...</div>;
  }

  return (
    <div className="space-y-6">
      <h2 className="text-xl font-semibold text-neutral-900">System Configuration & Security</h2>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Academic Timeline Controls</h3>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
          <label className="flex items-center gap-2 text-sm text-neutral-700">
            <input
              type="checkbox"
              checked={Boolean(settings.idea_submissions_enabled)}
              onChange={(e) => setSettings({ ...settings, idea_submissions_enabled: e.target.checked })}
            />
            Enable idea submissions
          </label>
          <label className="flex items-center gap-2 text-sm text-neutral-700">
            <input
              type="checkbox"
              checked={Boolean(settings.commenting_enabled)}
              onChange={(e) => setSettings({ ...settings, commenting_enabled: e.target.checked })}
            />
            Enable commenting
          </label>
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Uploads & Pagination</h3>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-3">
          <label className="text-sm text-neutral-700">
            Max upload size (MB)
            <input
              type="number"
              min="1"
              value={settings.max_upload_size_mb}
              onChange={(e) => setSettings({ ...settings, max_upload_size_mb: Number(e.target.value || 1) })}
              className="mt-1 w-full rounded border border-neutral-300 px-3 py-2"
            />
          </label>
          <label className="text-sm text-neutral-700">
            Ideas per page
            <input
              type="number"
              min="1"
              value={settings.default_ideas_per_page}
              onChange={(e) => setSettings({ ...settings, default_ideas_per_page: Number(e.target.value || 1) })}
              className="mt-1 w-full rounded border border-neutral-300 px-3 py-2"
            />
          </label>
          <label className="text-sm text-neutral-700">
            Allowed file types (comma separated)
            <input
              type="text"
              value={(settings.allowed_file_types || []).join(',')}
              onChange={(e) =>
                setSettings({
                  ...settings,
                  allowed_file_types: e.target.value
                    .split(',')
                    .map((item) => item.trim().toLowerCase())
                    .filter(Boolean),
                })
              }
              className="mt-1 w-full rounded border border-neutral-300 px-3 py-2"
            />
          </label>
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Security Settings</h3>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
          <label className="text-sm text-neutral-700">
            Session timeout (minutes)
            <input
              type="number"
              min="5"
              value={settings.session_timeout_minutes}
              onChange={(e) => setSettings({ ...settings, session_timeout_minutes: Number(e.target.value || 5) })}
              className="mt-1 w-full rounded border border-neutral-300 px-3 py-2"
            />
          </label>
          <label className="text-sm text-neutral-700">
            Minimum password length
            <input
              type="number"
              min="6"
              value={settings.password_policy?.min_length || 8}
              onChange={(e) =>
                setSettings({
                  ...settings,
                  password_policy: {
                    ...(settings.password_policy || defaultPasswordPolicy),
                    min_length: Number(e.target.value || 8),
                  },
                })
              }
              className="mt-1 w-full rounded border border-neutral-300 px-3 py-2"
            />
          </label>
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">SMTP Settings</h3>
        <div className="grid grid-cols-1 gap-3 md:grid-cols-2">
          <input
            type="text"
            placeholder="SMTP host"
            value={settings.smtp_settings?.host || ''}
            onChange={(e) => setSettings({ ...settings, smtp_settings: { ...(settings.smtp_settings || defaultSmtp), host: e.target.value } })}
            className="rounded border border-neutral-300 px-3 py-2"
          />
          <input
            type="number"
            placeholder="Port"
            value={settings.smtp_settings?.port || 587}
            onChange={(e) => setSettings({ ...settings, smtp_settings: { ...(settings.smtp_settings || defaultSmtp), port: Number(e.target.value || 587) } })}
            className="rounded border border-neutral-300 px-3 py-2"
          />
          <input
            type="text"
            placeholder="Username"
            value={settings.smtp_settings?.username || ''}
            onChange={(e) => setSettings({ ...settings, smtp_settings: { ...(settings.smtp_settings || defaultSmtp), username: e.target.value } })}
            className="rounded border border-neutral-300 px-3 py-2"
          />
          <input
            type="password"
            placeholder="Password"
            value={settings.smtp_settings?.password || ''}
            onChange={(e) => setSettings({ ...settings, smtp_settings: { ...(settings.smtp_settings || defaultSmtp), password: e.target.value } })}
            className="rounded border border-neutral-300 px-3 py-2"
          />
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Terms & Conditions</h3>
        <textarea
          rows={8}
          value={terms}
          onChange={(e) => setTerms(e.target.value)}
          className="w-full rounded border border-neutral-300 px-3 py-2"
        />
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Notification Templates</h3>
        <div className="space-y-3">
          {templates.map((tpl) => (
            <div key={tpl.id} className="rounded border border-neutral-200 p-3">
              <input
                type="text"
                value={tpl.subject}
                onChange={(e) => setTemplates((prev) => prev.map((item) => (item.id === tpl.id ? { ...item, subject: e.target.value } : item)))}
                className="mb-2 w-full rounded border border-neutral-300 px-3 py-2"
              />
              <textarea
                rows={3}
                value={tpl.body}
                onChange={(e) => setTemplates((prev) => prev.map((item) => (item.id === tpl.id ? { ...item, body: e.target.value } : item)))}
                className="w-full rounded border border-neutral-300 px-3 py-2"
              />
              <div className="mt-2 flex justify-end">
                <button type="button" onClick={() => saveTemplate(tpl)} className="rounded bg-primary-600 px-3 py-1.5 text-xs font-semibold text-white">
                  Save Template
                </button>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">Notification Toggles & Test</h3>
        <div className="space-y-2">
          {notificationSettings.map((item) => (
            <label key={item.id} className="flex items-center gap-2 text-sm text-neutral-700">
              <input
                type="checkbox"
                checked={Boolean(item.is_enabled)}
                onChange={(e) => toggleNotification(item.notification_key, e.target.checked)}
              />
              {item.notification_key}
            </label>
          ))}
        </div>
        <div className="mt-3 flex gap-2">
          <input
            type="email"
            placeholder="test@example.com"
            value={testEmail}
            onChange={(e) => setTestEmail(e.target.value)}
            className="flex-1 rounded border border-neutral-300 px-3 py-2 text-sm"
          />
          <button type="button" onClick={sendTest} className="rounded bg-primary-600 px-3 py-2 text-sm font-semibold text-white">
            Send Test
          </button>
        </div>
      </section>

      <div className="flex justify-end">
        <button
          type="button"
          onClick={saveCoreSettings}
          disabled={saving}
          className="rounded-lg bg-primary-600 px-5 py-2 text-sm font-semibold text-white disabled:bg-neutral-400"
        >
          {saving ? 'Saving...' : 'Save Core Settings'}
        </button>
      </div>
    </div>
  );
}

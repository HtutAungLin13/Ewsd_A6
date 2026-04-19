import { useEffect, useState } from "react";
import axios from "axios";

const API_BASE = "http://localhost/ewsd1/api";

export default function CoordinatorSecurityCompliance({ onError }) {
  const [loginData, setLoginData] = useState(null);
  const [complianceData, setComplianceData] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const loadData = async () => {
    setIsLoading(true);
    try {
      const [loginRes, complianceRes] = await Promise.all([
        axios.get(`${API_BASE}/qa_coordinator.php?action=login_tracking`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        }),
        axios.get(`${API_BASE}/qa_coordinator.php?action=tc_compliance`, {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        }),
      ]);
      setLoginData(loginRes.data.data || {});
      setComplianceData(complianceRes.data.data || {});
      onError("");
    } catch (error) {
      onError(
        error.response?.data?.message ||
          "Failed to load security/compliance data",
      );
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    loadData();
  }, []);

  if (isLoading) {
    return (
      <div className="text-center py-10 text-neutral-600">
        Loading security/compliance data...
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <h2 className="text-xl font-semibold text-neutral-900">
        Security and Compliance Awareness
      </h2>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white border border-neutral-200 rounded-lg p-4">
          <p className="text-sm text-neutral-600">Last Login</p>
          <p className="text-base font-semibold text-neutral-900 mt-1">
            {loginData?.last_login
              ? new Date(loginData.last_login).toLocaleString()
              : "No login record"}
          </p>
        </div>
        <div className="bg-white border border-neutral-200 rounded-lg p-4">
          <p className="text-sm text-neutral-600">T&C Version</p>
          <p className="text-2xl font-bold text-neutral-900 mt-1">
            {complianceData?.tc_version || "N/A"}
          </p>
        </div>
        <div className="bg-white border border-neutral-200 rounded-lg p-4">
          <p className="text-sm text-neutral-600">Department Acceptance Rate</p>
          <p className="text-2xl font-bold text-primary-700 mt-1">
            {complianceData?.acceptance_rate ?? 0}%
          </p>
        </div>
      </div>

      <section className="bg-white border border-neutral-200 rounded-lg p-4">
        <h3 className="font-semibold text-neutral-900 mb-2">
          Compliance Snapshot
        </h3>
        <p className="text-sm text-neutral-700">
          Staff accepted current terms:{" "}
          <strong>{complianceData?.accepted_count ?? 0}</strong> /{" "}
          <strong>{complianceData?.total_staff ?? 0}</strong>
        </p>
      </section>

      <section className="bg-white border border-neutral-200 rounded-lg p-4">
        <h3 className="font-semibold text-neutral-900 mb-3">Recent Sessions</h3>
        {(loginData?.recent_sessions || []).length === 0 ? (
          <p className="text-sm text-neutral-600">No session history.</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-neutral-100">
                <tr>
                  <th className="px-3 py-2 text-left">Login Time</th>
                  <th className="px-3 py-2 text-left">IP</th>
                  <th className="px-3 py-2 text-left">Expires</th>
                </tr>
              </thead>
              <tbody>
                {loginData.recent_sessions.map((row) => (
                  <tr key={row.id} className="border-b border-neutral-200">
                    <td className="px-3 py-2">
                      {new Date(row.created_at).toLocaleString()}
                    </td>
                    <td className="px-3 py-2">{row.ip_address || "N/A"}</td>
                    <td className="px-3 py-2">
                      {row.expires_at
                        ? new Date(row.expires_at).toLocaleString()
                        : "N/A"}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </div>
  );
}

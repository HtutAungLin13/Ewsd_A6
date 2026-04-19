import { useEffect, useState } from "react";
import { adminManagementAPI } from "../services/api";

const API_BASE = "http://localhost/ewsd1/api/admin_management.php";

export default function AdminBackupTab({ onError }) {
  const [categoryBackups, setCategoryBackups] = useState([]);
  const [systemBackups, setSystemBackups] = useState([]);
  const [backupName, setBackupName] = useState("");

  const fetchData = async () => {
    try {
      const [catRes, sysRes] = await Promise.all([
        adminManagementAPI.listCategoryBackups(),
        adminManagementAPI.listSystemBackups(),
      ]);
      setCategoryBackups(catRes.data.data || []);
      setSystemBackups(sysRes.data.data || []);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to load backups");
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const createCategoryBackup = async () => {
    try {
      await adminManagementAPI.createCategoryBackup({
        backup_name: backupName || undefined,
      });
      setBackupName("");
      await fetchData();
    } catch (error) {
      onError(
        error.response?.data?.message || "Failed to create category backup",
      );
    }
  };

  const restoreCategoryBackup = async (backupId) => {
    if (!window.confirm("Restore this category backup?")) return;
    try {
      await adminManagementAPI.restoreCategoryBackup(backupId);
      await fetchData();
    } catch (error) {
      onError(
        error.response?.data?.message || "Failed to restore category backup",
      );
    }
  };

  const createSystemBackup = async () => {
    try {
      await adminManagementAPI.createSystemBackup({
        backup_name: backupName || undefined,
        scope: [
          "users",
          "departments",
          "settings",
          "categories",
          "notifications",
          "security",
        ],
      });
      setBackupName("");
      await fetchData();
    } catch (error) {
      onError(
        error.response?.data?.message || "Failed to create system backup",
      );
    }
  };

  const restoreSystemBackup = async (backupId) => {
    if (
      !window.confirm(
        "Restore this system backup? This will overwrite restorable admin tables.",
      )
    )
      return;
    try {
      await adminManagementAPI.restoreSystemBackup(backupId);
      await fetchData();
    } catch (error) {
      onError(
        error.response?.data?.message || "Failed to restore system backup",
      );
    }
  };

  return (
    <div className="space-y-6">
      <h2 className="text-xl font-semibold text-neutral-900">
        Data Export & Backup
      </h2>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">
          Create Backup
        </h3>
        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Optional backup name"
            value={backupName}
            onChange={(e) => setBackupName(e.target.value)}
            className="flex-1 rounded border border-neutral-300 px-3 py-2 text-sm"
          />
          <button
            type="button"
            onClick={createCategoryBackup}
            className="rounded bg-primary-600 px-3 py-2 text-sm font-semibold text-white"
          >
            Category Backup
          </button>
          <button
            type="button"
            onClick={createSystemBackup}
            className="rounded bg-emerald-600 px-3 py-2 text-sm font-semibold text-white"
          >
            System Backup
          </button>
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">
          Category Backups
        </h3>
        <div className="space-y-2">
          {categoryBackups.length === 0 ? (
            <p className="text-sm text-neutral-600">
              No category backups found.
            </p>
          ) : (
            categoryBackups.map((backup) => (
              <div
                key={backup.id}
                className="flex items-center justify-between rounded border border-neutral-200 px-3 py-2"
              >
                <div>
                  <p className="text-sm font-medium text-neutral-900">
                    {backup.backup_name}
                  </p>
                  <p className="text-xs text-neutral-600">
                    {new Date(backup.created_at).toLocaleString()} by{" "}
                    {backup.created_by}
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => restoreCategoryBackup(backup.id)}
                  className="rounded bg-primary-50 px-3 py-1.5 text-xs font-semibold text-primary-700"
                >
                  Restore
                </button>
              </div>
            ))
          )}
        </div>
      </section>

      <section className="rounded border border-neutral-200 bg-white p-4">
        <h3 className="mb-3 text-base font-semibold text-neutral-900">
          System Backups
        </h3>
        <div className="space-y-2">
          {systemBackups.length === 0 ? (
            <p className="text-sm text-neutral-600">No system backups found.</p>
          ) : (
            systemBackups.map((backup) => (
              <div
                key={backup.id}
                className="flex items-center justify-between rounded border border-neutral-200 px-3 py-2"
              >
                <div>
                  <p className="text-sm font-medium text-neutral-900">
                    {backup.backup_name}
                  </p>
                  <p className="text-xs text-neutral-600">
                    Scope: {backup.backup_scope} |{" "}
                    {new Date(backup.created_at).toLocaleString()} by{" "}
                    {backup.created_by}
                  </p>
                </div>
                <button
                  type="button"
                  onClick={() => restoreSystemBackup(backup.id)}
                  className="rounded bg-emerald-50 px-3 py-1.5 text-xs font-semibold text-emerald-700"
                >
                  Restore
                </button>
              </div>
            ))
          )}
        </div>
      </section>
    </div>
  );
}

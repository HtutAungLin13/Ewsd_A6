import { useEffect, useState } from "react";
import { adminManagementAPI } from "../services/api";

const DOWNLOAD_BASE =
  "http://localhost/ewsd1/api/admin_management.php?action=download_document&document_id=";

function formatBytes(bytes) {
  const value = Number(bytes || 0);
  if (value < 1024) return `${value} B`;
  if (value < 1024 * 1024) return `${(value / 1024).toFixed(1)} KB`;
  return `${(value / (1024 * 1024)).toFixed(2)} MB`;
}

export default function AdminDocumentsTab({ onError, searchTerm = "" }) {
  const [documents, setDocuments] = useState([]);
  const [storageSummary, setStorageSummary] = useState(null);

  const fetchData = async () => {
    try {
      const [docsRes, storageRes] = await Promise.all([
        adminManagementAPI.getDocuments({
          page: 1,
          per_page: 500,
          search: searchTerm || undefined,
        }),
        adminManagementAPI.getStorageUsage(),
      ]);
      setDocuments(docsRes.data.data || []);
      setStorageSummary(storageRes.data.data?.summary || null);
      onError("");
    } catch (error) {
      onError(error.response?.data?.message || "Failed to load documents");
    }
  };

  useEffect(() => {
    fetchData();
  }, [searchTerm]);

  const deleteDocument = async (documentId) => {
    if (!window.confirm("Delete this document?")) return;
    try {
      await adminManagementAPI.deleteDocument(documentId);
      await fetchData();
    } catch (error) {
      onError(error.response?.data?.message || "Failed to delete document");
    }
  };

  return (
    <div className="space-y-4">
      <h2 className="text-xl font-semibold text-neutral-900">
        Document Storage Management
      </h2>

      {storageSummary && (
        <div className="rounded border border-neutral-200 bg-white p-4 text-sm text-neutral-700">
          Files: {storageSummary.total_files || 0} | Total size:{" "}
          {formatBytes(storageSummary.total_bytes)} | Flagged files:{" "}
          {storageSummary.flagged_files || 0}
        </div>
      )}

      {documents.length === 0 ? (
        <div className="rounded border border-neutral-200 bg-white p-5 text-sm text-neutral-600">
          No documents uploaded yet.
        </div>
      ) : (
        <div className="overflow-x-auto rounded border border-neutral-200 bg-white">
          <table className="w-full text-sm">
            <thead className="bg-neutral-100 text-neutral-700">
              <tr>
                <th className="px-3 py-2 text-left">File</th>
                <th className="px-3 py-2 text-left">Idea</th>
                <th className="px-3 py-2 text-left">Uploader</th>
                <th className="px-3 py-2 text-left">Size</th>
                <th className="px-3 py-2 text-left">Actions</th>
              </tr>
            </thead>
            <tbody>
              {documents.map((doc) => (
                <tr key={doc.id} className="border-t border-neutral-100">
                  <td className="px-3 py-2">
                    {doc.file_name}
                    {doc.is_flagged ? (
                      <span className="ml-2 rounded bg-danger-50 px-2 py-0.5 text-xs text-danger-700">
                        Flagged
                      </span>
                    ) : null}
                  </td>
                  <td className="px-3 py-2">
                    {doc.idea_title || "Untitled idea"}
                  </td>
                  <td className="px-3 py-2">
                    {doc.uploader_name || "System upload"}
                  </td>
                  <td className="px-3 py-2">{formatBytes(doc.file_size)}</td>
                  <td className="px-3 py-2">
                    <div className="flex gap-2">
                      <a
                        href={`${DOWNLOAD_BASE}${doc.id}`}
                        className="rounded bg-primary-50 px-2 py-1 text-xs font-semibold text-primary-700"
                      >
                        Download
                      </a>
                      <button
                        type="button"
                        onClick={() => deleteDocument(doc.id)}
                        className="rounded bg-danger-50 px-2 py-1 text-xs font-semibold text-danger-700"
                      >
                        Delete
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

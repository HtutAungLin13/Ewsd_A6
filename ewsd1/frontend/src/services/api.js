// src/services/api.js
import axios from "axios";

const API_BASE_URL = "http://localhost/ewsd1/api";

// Create axios instance
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    "Content-Type": "application/json",
  },
  withCredentials: true,
});

// Request interceptor - add token to headers
apiClient.interceptors.request.use((config) => {
  const isLoginRequest = config.url?.includes("/login.php");
  const token = localStorage.getItem("authToken");
  if (token && !isLoginRequest) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor - handle auth errors
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid
      localStorage.removeItem("authToken");
      localStorage.removeItem("user");
      window.location.href = "/login";
    }
    return Promise.reject(error);
  },
);

// Auth API calls
export const authAPI = {
  login: (username, password) =>
    apiClient.post("/login.php", { username, password }),

  logout: () => {
    localStorage.removeItem("authToken");
    localStorage.removeItem("user");
  },
};

// Staff API calls
export const staffAPI = {
  getAll: (page = 1, perPage = 10) =>
    apiClient.get("/staff.php", { params: { page, per_page: perPage } }),

  getById: (id) => apiClient.get(`/staff.php?id=${id}`),

  create: (data) => apiClient.post("/staff.php", data),

  update: (id, data) => apiClient.put(`/staff.php?id=${id}`, data),

  delete: (id) => apiClient.delete(`/staff.php?id=${id}`),
};

// Staff Ideas API calls
export const staffIdeasAPI = {
  getSessions: () =>
    apiClient.get("/staff_ideas.php", { params: { action: "get_sessions" } }),

  getCategories: () =>
    apiClient.get("/staff_ideas.php", { params: { action: "get_categories" } }),

  getTerms: () =>
    apiClient.get("/staff_ideas.php", { params: { action: "get_tc" } }),

  acceptTerms: (tcVersion = 1) =>
    apiClient.post("/staff_ideas.php?action=accept_tc", {
      tc_version: tcVersion,
    }),

  submitIdea: (payload) =>
    apiClient.post("/staff_ideas.php?action=submit_idea", payload),

  getIdeas: ({ filter = "latest", sessionId, page = 1, perPage = 5 } = {}) =>
    apiClient.get("/staff_ideas.php", {
      params: {
        action: "get_ideas",
        filter,
        session_id: sessionId,
        page,
        per_page: perPage,
      },
    }),

  getIdea: (ideaId) =>
    apiClient.get("/staff_ideas.php", {
      params: { action: "get_idea", idea_id: ideaId },
    }),

  voteIdea: ({ ideaId, voteType }) =>
    apiClient.post("/staff_ideas.php?action=vote_idea", {
      idea_id: ideaId,
      vote_type: voteType,
    }),

  latestComments: (limit = 10) =>
    apiClient.get("/staff_ideas.php", {
      params: { action: "latest_comments", limit },
    }),
};

export const staffAttachmentsAPI = {
  upload: (formData) =>
    apiClient.post("/staff_attachments.php?action=upload", formData, {
      headers: { "Content-Type": "multipart/form-data" },
    }),
};

// Staff Comments API calls
export const staffCommentsAPI = {
  getComments: (ideaId) =>
    apiClient.get("/staff_comments.php", {
      params: { action: "get_comments", idea_id: ideaId },
    }),

  postComment: ({ ideaId, content, isAnonymous }) =>
    apiClient.post("/staff_comments.php?action=comment", {
      idea_id: ideaId,
      content,
      is_anonymous: isAnonymous,
    }),

  reply: ({
    parentCommentId,
    ideaId,
    content,
    mentionedStaffId,
    isAnonymous,
  }) =>
    apiClient.post("/staff_comments.php?action=reply", {
      parent_comment_id: parentCommentId,
      idea_id: ideaId,
      content,
      mentioned_staff_id: mentionedStaffId,
      is_anonymous: isAnonymous,
    }),

  reportContent: ({
    contentType,
    contentId,
    reportCategory,
    reason,
    description,
    severity,
  }) =>
    apiClient.post("/staff_comments.php?action=report_content", {
      content_type: contentType,
      content_id: contentId,
      report_category: reportCategory,
      reason,
      description,
      severity,
    }),

  deleteComment: (commentId) =>
    apiClient.delete("/staff_comments.php?action=delete_comment", {
      data: { comment_id: commentId },
    }),
};

// Sessions API calls
export const sessionsAPI = {
  getAll: (page = 1, perPage = 10, filters = {}) =>
    apiClient.get("/sessions.php", {
      params: { page, per_page: perPage, ...filters },
    }),

  getById: (id) => apiClient.get(`/sessions.php?id=${id}`),

  create: (data) => apiClient.post("/sessions.php", data),

  update: (id, data) => apiClient.put(`/sessions.php?id=${id}`, data),

  delete: (id) => apiClient.delete(`/sessions.php?id=${id}`),
};

// Academic Years API calls
export const academicYearsAPI = {
  getAll: (page = 1, perPage = 10) =>
    apiClient.get("/academic_years.php", {
      params: { page, per_page: perPage },
    }),

  getById: (id) => apiClient.get(`/academic_years.php?id=${id}`),

  create: (data) => apiClient.post("/academic_years.php", data),

  update: (id, data) => apiClient.put(`/academic_years.php?id=${id}`, data),

  delete: (id) => apiClient.delete(`/academic_years.php?id=${id}`),
};

// Admin Management API calls
export const adminManagementAPI = {
  listUsers: (params = {}) =>
    apiClient.get("/admin_management.php", {
      params: { action: "users", ...params },
    }),

  createUser: (data) =>
    apiClient.post("/admin_management.php?action=users", data),

  updateUser: (data) =>
    apiClient.put("/admin_management.php?action=users", data),

  deleteUser: (data) =>
    apiClient.delete("/admin_management.php?action=users", { data }),

  resetPassword: (data) =>
    apiClient.post("/admin_management.php?action=reset_password", data),

  listDepartments: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "departments" },
    }),

  createDepartment: (data) =>
    apiClient.post("/admin_management.php?action=departments", data),

  updateDepartment: (data) =>
    apiClient.put("/admin_management.php?action=departments", data),

  deleteDepartment: (departmentId) =>
    apiClient.delete("/admin_management.php?action=departments", {
      data: { department_id: departmentId },
    }),

  getTerms: () =>
    apiClient.get("/admin_management.php", { params: { action: "terms" } }),

  updateTerms: (data) =>
    apiClient.put("/admin_management.php?action=terms", data),

  getSystemSettings: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "system_settings" },
    }),

  updateSystemSettings: (settings) =>
    apiClient.put("/admin_management.php?action=system_settings", { settings }),

  listNotificationTemplates: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "notification_templates" },
    }),

  saveNotificationTemplate: (data) =>
    apiClient.post("/admin_management.php?action=notification_templates", data),

  listNotificationSettings: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "notification_settings" },
    }),

  updateNotificationSetting: (data) =>
    apiClient.put("/admin_management.php?action=notification_settings", data),

  testEmail: (data) =>
    apiClient.post("/admin_management.php?action=test_email", data),

  listCategories: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "categories" },
    }),

  createCategoryBackup: (data = {}) =>
    apiClient.post("/admin_management.php?action=category_backup_create", data),

  listCategoryBackups: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "category_backups" },
    }),

  restoreCategoryBackup: (backupId) =>
    apiClient.post("/admin_management.php?action=category_restore", {
      backup_id: backupId,
    }),

  createSystemBackup: (data) =>
    apiClient.post("/admin_management.php?action=create_backup", data),

  listSystemBackups: () =>
    apiClient.get("/admin_management.php", { params: { action: "backups" } }),

  restoreSystemBackup: (backupId) =>
    apiClient.post("/admin_management.php?action=restore_backup", {
      backup_id: backupId,
    }),

  getActivityLogs: (params = {}) =>
    apiClient.get("/admin_management.php", {
      params: { action: "activity_logs", ...params },
    }),

  getLoginHistory: (params = {}) =>
    apiClient.get("/admin_management.php", {
      params: { action: "login_history", ...params },
    }),

  getStorageUsage: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "storage_usage" },
    }),

  getSuspiciousActivities: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "suspicious_activities" },
    }),

  getReportedContent: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "reported_content" },
    }),

  moderateContent: (data) =>
    apiClient.post("/admin_management.php?action=moderate_content", data),

  revealAuthor: (contentType, contentId) =>
    apiClient.get("/admin_management.php", {
      params: {
        action: "reveal_author",
        content_type: contentType,
        content_id: contentId,
      },
    }),

  getDocuments: (params = {}) =>
    apiClient.get("/admin_management.php", {
      params: { action: "documents", ...params },
    }),

  deleteDocument: (documentId) =>
    apiClient.delete("/admin_management.php?action=documents", {
      data: { document_id: documentId },
    }),

  getSystemReport: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "system_report" },
    }),

  getRolePermissions: () =>
    apiClient.get("/admin_management.php", {
      params: { action: "role_permissions" },
    }),

  updateRolePermissions: (roleKey, permissions) =>
    apiClient.put("/admin_management.php?action=role_permissions", {
      role_key: roleKey,
      permissions,
    }),
};

export default apiClient;

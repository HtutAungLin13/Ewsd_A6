// src/components/Staff/CommentsSection.jsx
import { useState, useEffect } from "react";
import axios from "axios";

const API_BASE = "http://localhost/ewsd1/api";

export default function CommentsSection({ ideaId, onError }) {
  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [isAnonymous, setIsAnonymous] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [expandedReplies, setExpandedReplies] = useState({});
  const [replyingTo, setReplyingTo] = useState(null);
  const [replyText, setReplyText] = useState("");
  const [replyAnonymous, setReplyAnonymous] = useState(false);

  const loadComments = async () => {
    setIsLoading(true);
    try {
      const response = await axios.get(
        `${API_BASE}/staff_comments.php?action=get_comments&idea_id=${ideaId}`,
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );
      setComments(response.data.data || []);
    } catch (error) {
      console.error("Failed to fetch comments");
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    if (ideaId) {
      loadComments();
    }
  }, [ideaId]);

  const handlePostComment = async (e) => {
    e.preventDefault();

    if (!newComment.trim()) {
      onError?.("Comment cannot be empty");
      return;
    }

    setIsSubmitting(true);
    try {
      await axios.post(
        `${API_BASE}/staff_comments.php?action=comment`,
        {
          idea_id: ideaId,
          content: newComment,
          is_anonymous: isAnonymous,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      await loadComments();
      setNewComment("");
    } catch (error) {
      onError?.(error.response?.data?.message || "Failed to post comment");
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleReply = async (commentId) => {
    if (!replyText.trim()) {
      onError?.("Reply cannot be empty");
      return;
    }

    setIsSubmitting(true);
    try {
      await axios.post(
        `${API_BASE}/staff_comments.php?action=reply`,
        {
          parent_comment_id: commentId,
          idea_id: ideaId,
          content: replyText,
          mentioned_staff_id: null,
          is_anonymous: replyAnonymous,
        },
        {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        },
      );

      await loadComments();
      setReplyText("");
      setReplyingTo(null);
      setReplyAnonymous(false);
    } catch (error) {
      onError?.(error.response?.data?.message || "Failed to post reply");
    } finally {
      setIsSubmitting(false);
    }
  };

  const toggleReplies = (commentId) => {
    setExpandedReplies((prev) => ({
      ...prev,
      [commentId]: !prev[commentId],
    }));
  };

  return (
    <div className="space-y-6">
      <h3 className="text-lg font-semibold text-gray-900">
        Comments ({comments.length})
      </h3>

      <form onSubmit={handlePostComment} className="bg-gray-50 rounded-lg p-4">
        <textarea
          value={newComment}
          onChange={(e) => setNewComment(e.target.value)}
          placeholder="Share your thoughts..."
          rows={3}
          maxLength={1000}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none mb-2"
        />
        <p className="text-xs text-gray-500 mb-3">{newComment.length}/1000</p>

        <div className="flex items-center gap-4 mb-3">
          <label className="flex items-center gap-2 text-sm">
            <input
              type="checkbox"
              checked={isAnonymous}
              onChange={(e) => setIsAnonymous(e.target.checked)}
              className="w-4 h-4 rounded border-gray-300"
            />
            <span className="text-gray-700">Post anonymously</span>
          </label>
        </div>

        <button
          type="submit"
          disabled={isSubmitting || !newComment.trim()}
          className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 transition font-medium"
        >
          {isSubmitting ? "Posting..." : "Post Comment"}
        </button>
      </form>

      {isLoading ? (
        <p className="text-gray-600">Loading comments...</p>
      ) : comments.length === 0 ? (
        <p className="text-gray-600 text-center py-8">
          No comments yet. Be the first to comment!
        </p>
      ) : (
        <div className="space-y-4">
          {comments.map((comment) => (
            <div
              key={comment.id}
              className="border border-gray-200 rounded-lg p-4"
            >
              <div className="flex justify-between items-start mb-2">
                <div>
                  <p className="font-semibold text-gray-900">
                    {comment.contributor_name}
                  </p>
                  <p className="text-xs text-gray-500">
                    {new Date(comment.created_at).toLocaleDateString()} at{" "}
                    {new Date(comment.created_at).toLocaleTimeString()}
                  </p>
                </div>
              </div>

              <p className="text-gray-700 mb-3 whitespace-pre-wrap">
                {comment.content}
              </p>

              <div className="flex items-center gap-3 text-sm">
                <button
                  type="button"
                  onClick={() =>
                    setReplyingTo(replyingTo === comment.id ? null : comment.id)
                  }
                  className="text-blue-600 hover:text-blue-700 font-medium"
                >
                  Reply
                </button>
                {comment.replies && comment.replies.length > 0 && (
                  <button
                    type="button"
                    onClick={() => toggleReplies(comment.id)}
                    className="text-blue-600 hover:text-blue-700 font-medium"
                  >
                    {expandedReplies[comment.id]
                      ? "Hide replies"
                      : `View replies (${comment.replies.length})`}
                  </button>
                )}
              </div>

              {replyingTo === comment.id && (
                <div className="mt-3 bg-gray-50 border border-gray-200 rounded p-3">
                  <textarea
                    value={replyText}
                    onChange={(e) => setReplyText(e.target.value)}
                    placeholder="Write a reply..."
                    rows={3}
                    className="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 outline-none"
                  />
                  <div className="flex items-center justify-between mt-2">
                    <label className="flex items-center gap-2 text-xs text-gray-600">
                      <input
                        type="checkbox"
                        checked={replyAnonymous}
                        onChange={(e) => setReplyAnonymous(e.target.checked)}
                        className="w-3 h-3 rounded border-gray-300"
                      />
                      Reply anonymously
                    </label>
                    <button
                      type="button"
                      onClick={() => handleReply(comment.id)}
                      disabled={isSubmitting || !replyText.trim()}
                      className="px-3 py-1.5 text-sm bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
                    >
                      {isSubmitting ? "Posting..." : "Post Reply"}
                    </button>
                  </div>
                </div>
              )}

              {expandedReplies[comment.id] && comment.replies && (
                <div className="mt-4 ml-4 space-y-3 border-l-2 border-gray-300 pl-4">
                  {comment.replies.map((reply) => (
                    <div key={reply.id} className="bg-gray-50 rounded p-3">
                      <div className="flex justify-between items-start mb-1">
                        <p className="font-semibold text-gray-900 text-sm">
                          {reply.contributor_name}
                          {reply.mentioned_staff_name && (
                            <span className="text-gray-600 font-normal">
                              {" "}
                              to @{reply.mentioned_staff_name}
                            </span>
                          )}
                        </p>
                      </div>
                      <p className="text-gray-700 text-sm">{reply.content}</p>
                      <p className="text-xs text-gray-500 mt-1">
                        {new Date(reply.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

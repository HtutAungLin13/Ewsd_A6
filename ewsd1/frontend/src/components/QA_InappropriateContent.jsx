// src/components/QA/InappropriateContent.jsx
import { useState, useEffect } from 'react';
import apiClient from '../services/api';

export default function InappropriateContent({ onError }) {
  const [activeTab, setActiveTab] = useState('flagged');
  const [flaggedContent, setFlaggedContent] = useState([]);
  const [anonymousContent, setAnonymousContent] = useState({ ideas: [], comments: [] });
  const [unrespondedIdeas, setUnrespondedIdeas] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  // Fetch flagged content
  const fetchFlaggedContent = async () => {
    setIsLoading(true);
    try {
      const response = await apiClient.get('/QA_management.php?action=inappropriate_content');
      setFlaggedContent(response.data.data || []);
      onError('');
    } catch (error) {
      onError('Failed to fetch flagged content');
    } finally {
      setIsLoading(false);
    }
  };

  // Fetch anonymous content
  const fetchAnonymousContent = async (withLoading = true) => {
    if (withLoading) setIsLoading(true);
    try {
      const response = await apiClient.get('/QA_management.php?action=anonymous_content');
      const payload = response.data.data || {};
      setAnonymousContent({
        ideas: payload.ideas || payload.anonymous_ideas || [],
        comments: payload.comments || payload.anonymous_comments || []
      });
      onError('');
    } catch (error) {
      onError('Failed to fetch anonymous content');
    } finally {
      if (withLoading) setIsLoading(false);
    }
  };

  // Fetch unresponded ideas
  const fetchUnrespondedIdeas = async (withLoading = true) => {
    if (withLoading) setIsLoading(true);
    try {
      const response = await apiClient.get('/QA_management.php?action=unresponded_ideas');
      setUnrespondedIdeas(response.data.data || []);
      onError('');
    } catch (error) {
      onError('Failed to fetch unresponded ideas');
    } finally {
      if (withLoading) setIsLoading(false);
    }
  };

  useEffect(() => {
    if (activeTab === 'flagged') {
      fetchFlaggedContent();
    } else if (activeTab === 'anonymous') {
      fetchAnonymousContent();
    } else if (activeTab === 'unresponded') {
      fetchUnrespondedIdeas();
    }
  }, [activeTab]);

  useEffect(() => {
    fetchAnonymousContent(false);
    fetchUnrespondedIdeas(false);
  }, []);

  return (
    <div>
      <h2 className="text-xl font-semibold text-neutral-900 mb-6">Inappropriate Content Management</h2>

      {/* Tabs */}
      <div className="flex gap-4 mb-6 border-b border-neutral-200">
        {[
          { id: 'flagged', label: '⚠️ Flagged Content', count: flaggedContent.length },
          { id: 'anonymous', label: '🕵️ Anonymous Submissions', count: (anonymousContent.ideas?.length || 0) + (anonymousContent.comments?.length || 0) },
          { id: 'unresponded', label: '💬 No Comments', count: unrespondedIdeas.length },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`pb-4 px-1 text-sm font-medium transition-all border-b-2 ${
              activeTab === tab.id
                ? 'border-danger-600 text-danger-600'
                : 'border-transparent text-neutral-600 hover:text-neutral-900'
            }`}
          >
            {tab.label} <span className="ml-1 font-bold">({tab.count})</span>
          </button>
        ))}
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p className="text-neutral-600">Loading...</p>
        </div>
      ) : (
        <>
          {/* Flagged Content Tab */}
          {activeTab === 'flagged' && (
            <div>
              {flaggedContent.length === 0 ? (
                <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
                  <p className="text-neutral-600">No flagged content</p>
                </div>
              ) : (
                <div className="space-y-4">
                  {flaggedContent.map((item, idx) => (
                    <div key={idx} className="bg-white rounded-lg border border-danger-200 p-4">
                      <div className="flex justify-between items-start mb-2">
                        <div>
                          <p className="text-xs text-danger-600 uppercase font-semibold mb-1">
                            {item.type}
                          </p>
                          <h4 className="text-base font-semibold text-neutral-900">{item.title}</h4>
                        </div>
                        <span className="px-2 py-1 bg-danger-100 text-danger-700 text-xs font-medium rounded">
                          Flagged
                        </span>
                      </div>

                      {item.idea_title && (
                        <p className="text-sm text-neutral-600 mb-2">
                          <strong>Idea:</strong> {item.idea_title}
                        </p>
                      )}

                      <p className="text-sm text-neutral-700 mb-3">{item.inappropriate_reason}</p>

                      <p className="text-xs text-neutral-600">
                        Flagged on {new Date(item.flagged_at).toLocaleDateString()}
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* Anonymous Content Tab */}
          {activeTab === 'anonymous' && (
            <div>
              {anonymousContent.ideas?.length === 0 && anonymousContent.comments?.length === 0 ? (
                <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
                  <p className="text-neutral-600">No anonymous submissions</p>
                </div>
              ) : (
                <div className="space-y-6">
                  {/* Anonymous Ideas */}
                  {anonymousContent.ideas && anonymousContent.ideas.length > 0 && (
                    <div>
                      <h3 className="text-lg font-semibold text-neutral-900 mb-3">Anonymous Ideas</h3>
                      <div className="space-y-3">
                        {anonymousContent.ideas.map((idea, idx) => (
                          <div key={idx} className="bg-white rounded-lg border border-neutral-200 p-4">
                            <div className="flex justify-between items-start mb-2">
                              <h4 className="text-base font-semibold text-neutral-900">{idea.title}</h4>
                              <span className="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded">
                                Idea
                              </span>
                            </div>
                            <p className="text-sm text-neutral-600 mb-2">{idea.department}</p>
                            <p className="text-xs text-neutral-600">
                              Submitted: {new Date(idea.created_at).toLocaleDateString()}
                            </p>
                            <p className="text-sm text-neutral-700 mt-2">
                              <strong>Comments:</strong> {idea.comment_count || 0}
                            </p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* Anonymous Comments */}
                  {anonymousContent.comments && anonymousContent.comments.length > 0 && (
                    <div>
                      <h3 className="text-lg font-semibold text-neutral-900 mb-3">Anonymous Comments</h3>
                      <div className="space-y-3">
                        {anonymousContent.comments.map((comment, idx) => (
                          <div key={idx} className="bg-white rounded-lg border border-neutral-200 p-4">
                            <div className="flex justify-between items-start mb-2">
                              <p className="text-sm text-neutral-700">{comment.title}</p>
                              <span className="px-2 py-1 bg-warning-100 text-warning-700 text-xs font-medium rounded">
                                Comment
                              </span>
                            </div>
                            {comment.idea_title && (
                              <p className="text-sm text-neutral-600 mb-2">
                                <strong>On idea:</strong> {comment.idea_title}
                              </p>
                            )}
                            <p className="text-xs text-neutral-600">
                              Posted: {new Date(comment.created_at).toLocaleDateString()}
                            </p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* Unresponded Ideas Tab */}
          {activeTab === 'unresponded' && (
            <div>
              {unrespondedIdeas.length === 0 ? (
                <div className="text-center py-12 bg-white rounded-lg border border-neutral-200">
                  <p className="text-neutral-600">All ideas have comments!</p>
                </div>
              ) : (
                <div className="space-y-3">
                  <p className="text-sm text-neutral-700 mb-4">
                    These ideas have no comments yet. Consider encouraging engagement.
                  </p>
                  {unrespondedIdeas.map((idea, idx) => (
                    <div key={idx} className="bg-white rounded-lg border border-neutral-200 p-4">
                      <h4 className="text-base font-semibold text-neutral-900 mb-2">{idea.title}</h4>
                      <div className="flex gap-4 text-sm text-neutral-600 mb-2">
                        <span>📁 {idea.category_name}</span>
                        <span>🏢 {idea.department}</span>
                        <span>👤 {idea.contributor_name}</span>
                      </div>
                      <p className="text-xs text-neutral-600">
                        Submitted: {new Date(idea.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </>
      )}
    </div>
  );
}

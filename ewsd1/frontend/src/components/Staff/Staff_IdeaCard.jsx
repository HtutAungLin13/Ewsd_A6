// src/components/Staff/Staff_IdeaCard.jsx
function formatRelativeDate(dateInput) {
  const date = new Date(dateInput);
  if (Number.isNaN(date.getTime())) return 'recently';

  const diffMs = Date.now() - date.getTime();
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
  const diffDays = Math.floor(diffHours / 24);

  if (diffHours < 1) return 'just now';
  if (diffHours < 24) return `${diffHours}h ago`;
  if (diffDays < 30) return `${diffDays}d ago`;
  return date.toLocaleDateString();
}

export default function IdeaCard({ idea, onClick }) {
  const upvotes = idea.upvote_count || 0;
  const downvotes = idea.downvote_count || 0;
  const score = upvotes - downvotes;

  return (
    <button
      type="button"
      onClick={onClick}
      className="w-full text-left bg-white border border-slate-300 rounded-md overflow-hidden hover:border-slate-400 transition"
    >
      <div className="flex">
        <div className="w-14 bg-slate-100 border-r border-slate-200 flex flex-col items-center py-3 text-sm">
          <span className="text-slate-500">▲</span>
          <span className={`font-semibold ${score > 0 ? 'text-orange-600' : score < 0 ? 'text-blue-600' : 'text-slate-700'}`}>
            {score}
          </span>
          <span className="text-slate-500">▼</span>
        </div>

        <div className="flex-1 p-4">
          <div className="text-xs text-slate-500 mb-2">
            {idea.is_anonymous ? 'posted by u/anonymous' : `posted by u/${(idea.contributor_name || 'staff').toLowerCase().replace(/\s+/g, '-')}`}
            {' '}
            |
            {' '}
            {formatRelativeDate(idea.submitted_at)}
            {' '}
            |
            {' '}
            r/{(idea.department || 'department').toLowerCase().replace(/\s+/g, '-')}
          </div>

          <h3 className="text-base sm:text-lg font-semibold text-slate-900 mb-2 hover:text-orange-600 transition">
            {idea.title}
          </h3>

          <p className="text-sm text-slate-700 mb-3 line-clamp-2">
            {idea.description}
          </p>

          <div className="flex flex-wrap items-center gap-4 text-xs text-slate-600">
            <span>{idea.comment_count || 0} comments</span>
            <span>{idea.view_count || 0} views</span>
            <span>{upvotes} upvotes</span>
            {idea.session_name && <span>Session: {idea.session_name}</span>}
          </div>

          {idea.tags && idea.tags.length > 0 && (
            <div className="mt-3 flex flex-wrap gap-2">
              {idea.tags.map((tag) => (
                <span key={tag.id} className="px-2 py-0.5 bg-slate-100 text-slate-700 text-xs rounded-full">
                  #{tag.name}
                </span>
              ))}
            </div>
          )}
        </div>
      </div>
    </button>
  );
}

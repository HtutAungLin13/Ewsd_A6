// src/components/Staff/Staff_FilterTabs.jsx
export default function FilterTabs({ activeFilter, onFilterChange }) {
  const filters = [
    { id: 'latest', label: 'New' },
    { id: 'popular', label: 'Top' },
    { id: 'viewed', label: 'Most Viewed' },
  ];

  return (
    <div className="bg-white border border-slate-300 rounded-md p-2">
      <div className="flex flex-wrap gap-2">
        {filters.map((filter) => (
          <button
            key={filter.id}
            type="button"
            onClick={() => onFilterChange(filter.id)}
            className={`px-4 py-2 rounded-full text-sm font-medium transition ${
              activeFilter === filter.id
                ? 'bg-orange-500 text-white'
                : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
            }`}
          >
            {filter.label}
          </button>
        ))}
      </div>
    </div>
  );
}

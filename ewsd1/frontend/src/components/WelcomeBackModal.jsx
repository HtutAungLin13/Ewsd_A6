import Modal from "./Modal";

const formatDateTime = (value) => {
  if (!value) return "-";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return "-";
  return date.toLocaleString();
};

const getGreeting = (loginAt) => {
  const base = loginAt ? new Date(loginAt) : new Date();
  const hour = base.getHours();
  if (hour >= 5 && hour < 12) return "Good morning";
  if (hour >= 12 && hour < 18) return "Good afternoon";
  return "Good evening";
};

export default function WelcomeBackModal({
  isOpen,
  onClose,
  displayName,
  lastLoginAt,
  loginAt,
}) {
  const greeting = getGreeting(loginAt);
  const formattedLastLogin = formatDateTime(lastLoginAt);
  const formattedCurrentLogin = formatDateTime(loginAt);

  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <div>
        <h3 className="text-lg font-semibold text-neutral-900 mb-2">
          {greeting}, {displayName || "there"}!
        </h3>
        <p className="text-sm text-neutral-700 mb-4">
          Welcome back to the system.
        </p>

        <div className="space-y-2 text-sm text-neutral-700">
          {formattedLastLogin !== "-" && (
            <p>
              <span className="font-medium text-neutral-900">Last login:</span>{" "}
              {formattedLastLogin}
            </p>
          )}
          <p>
            <span className="font-medium text-neutral-900">Login time:</span>{" "}
            {formattedCurrentLogin}
          </p>
        </div>

        <button
          type="button"
          onClick={onClose}
          className="mt-5 w-full rounded-lg bg-primary-600 px-4 py-2 text-sm font-medium text-white hover:bg-primary-700 transition"
        >
          Continue
        </button>
      </div>
    </Modal>
  );
}

// src/components/Coordinator/EncouragementTools.jsx
import StaffEngagement from './Coordinator_StaffEngagement';

export default function EncouragementTools({ onError }) {
  return (
    <div>
      <div className="mb-6 bg-primary-50 border border-primary-200 rounded-lg p-4">
        <h2 className="text-xl font-semibold text-neutral-900 mb-2">Encourage Staff to Contribute</h2>
        <p className="text-sm text-neutral-700">
          Use this section to invite staff members who haven't submitted ideas yet and encourage them to share their feedback.
        </p>
      </div>
      <StaffEngagement onError={onError} />
    </div>
  );
}

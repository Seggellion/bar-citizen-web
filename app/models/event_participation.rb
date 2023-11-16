class EventParticipation < ApplicationRecord
    belongs_to :user
    belongs_to :event

    validates :user_id, uniqueness: { scope: :event_id, message: "can only join an event once" }

end

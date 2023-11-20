class User < ApplicationRecord
      # Relationship with EventParticipations
  has_many :event_participations, dependent: :destroy
    # Validations
    validates :username, presence: true, uniqueness: true
    validates :discord_id, presence: true, uniqueness: true
    has_many :replies, dependent: :destroy
    has_many :posts, dependent: :destroy
  # Relationship with Events through EventParticipations
  has_many :events, through: :event_participations
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :post_categories

  def event_participation_id_for(event)
    event_participations.find_by(event_id: event.id)&.id
  end

  def total_events
    Event.where(creator_id: self.id).count
  end

  def total_posts
    Post.where(user_id: self.id).count
  end

    def participating_in?(event)
        EventParticipation.exists?(user_id: id, event_id: event.id)
      end
end

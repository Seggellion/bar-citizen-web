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
  has_many :discords

  has_many :event_manager_entries, class_name: 'EventManager'
  has_many :managed_events, through: :event_manager_entries, source: :event

  USER_ADMIN = 0
  USER_REGULAR = 42
  ESTABLISHED_ORGANIZER = 20
  EVENT_ORGANIZER = 30
  TRASH = 69

  def event_participation_id_for(event)
    event_participations.find_by(event_id: event.id)&.id
  end

  def total_events
    Event.where(creator_id: self.id).count
  end

  def total_posts
    Post.where(user_id: self.id).count
  end

  def user_level
    case user_type
    when USER_ADMIN
      'Admin'
    when USER_REGULAR
      'Regular User'
    when ESTABLISHED_ORGANIZER
      'Established Organizer'
    when EVENT_ORGANIZER
      'Event Organizer'
    when TRASH
      'Trash'
    else
      'Unknown'
    end
  end

    def participating_in?(event)
        EventParticipation.exists?(user_id: id, event_id: event.id)
      end
end

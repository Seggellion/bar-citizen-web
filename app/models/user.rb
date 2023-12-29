class User < ApplicationRecord
      # Relationship with EventParticipations
  has_many :event_participations, dependent: :destroy
    # Validations
    validates :username, presence: true, uniqueness: true
    validates :discord_id, presence: true, uniqueness: true
    has_many :replies, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :activities
    has_many :user_badges
    has_many :badges, through: :user_badges
  # Relationship with Events through EventParticipations
  has_many :events, through: :event_participations
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :post_categories
  has_many :discords
  has_many :pages
  has_many :photos
  has_one :region
  has_many :photo_comments
  # Association for messages sent by the user
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  # Association for messages received by the user
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'

  has_many :event_manager_entries, class_name: 'EventManager'
  has_many :managed_events, through: :event_manager_entries, source: :event

  USER_ADMIN = 0
  USER_REGULAR = 42
  REGIONAL_MANAGER = 10
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

  def is_manager(event)
    return true if EventManager.find_by(event_id: event, user_id: self.id)
  end

  
  def is_admin?
    return true if self.user_type == 0
  end


  def user_level
    case user_type
    when USER_ADMIN
      'Admin'
    when USER_REGULAR
      'Regular User'
    when ESTABLISHED_ORGANIZER
      'Established Organizer'
    when REGIONAL_MANAGER
      'Regional Manager'
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

class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

    has_many :photos  # Assuming each photo is a record that includes an image and other data
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
    belongs_to :region
    # belongs_to :discord
    has_one :discord, as: :discordable
    has_many :event_manager_entries, class_name: 'EventManager'
    has_many :event_managers, through: :event_manager_entries, source: :user
    has_many :event_messages, dependent: :destroy
    has_many :event_participations, dependent: :destroy
    has_many :giveaways, dependent: :destroy
    geocoded_by :address
    validates :title, presence: true
    #validates :address, presence: true
    validates :start_datetime, presence: true
    before_save :geocode_address, if: ->(obj){ obj.address.present? and obj.address_changed? }
    has_one_attached :banner

    def attendees
      EventParticipation.where(event_id: id).includes(:user).map(&:user)
    end

    def event_passed
      if start_datetime.past?
        "Registration closed"
      else
        "Registration Open"
      end
    end

    def is_virtual
      return true if self.event_type == "virtual"
    end

    def activities
      Activity.all.select do |activity| 
        activity.associated_with?(id, 'event') ||
        activity.associated_with?(id, 'giveaway') ||
        activity.associated_with?(id, 'photo')
      end
    
    end

    private

    def geocode_address        
      # The geocode method is provided by the geocoder gem
      geocode
    end  

end

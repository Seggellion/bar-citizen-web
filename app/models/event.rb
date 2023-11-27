class Event < ApplicationRecord

    has_many :photos  # Assuming each photo is a record that includes an image and other data
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
    belongs_to :region
    belongs_to :discord

    has_many :event_manager_entries, class_name: 'EventManager'
    has_many :event_managers, through: :event_manager_entries, source: :user

    geocoded_by :address
    before_save :geocode_address, if: ->(obj){ obj.address.present? and obj.address_changed? }


    private

    def geocode_address        
      # The geocode method is provided by the geocoder gem
      geocode
    end  

end

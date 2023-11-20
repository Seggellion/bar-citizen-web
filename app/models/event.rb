class Event < ApplicationRecord

    has_many :photos  # Assuming each photo is a record that includes an image and other data
    belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

end

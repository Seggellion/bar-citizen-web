# app/models/reply.rb
class Reply < ApplicationRecord
  include Actionable

    belongs_to :user
    belongs_to :post
  
    # Validations (optional, based on your requirements)
    validates :content, presence: true

    def action_user

      activity = Activity.find_by(description: "reply-id_#{self.id}")
      # Now get the username from the associated user
      # This assumes that your User model has a 'name' attribute
      if activity && activity.user
        return activity.user
      end
    
    end


  end
  
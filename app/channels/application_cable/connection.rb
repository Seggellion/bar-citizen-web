module ApplicationCable
  class Connection < ActionCable::Connection::Base
    
    identified_by :current_user

    def connect
      
      self.current_user = find_verified_user
      
      logger.add_tags 'ActionCable', current_user.id
    end

    private

    def find_verified_user
      # Access cookies directly (make sure they are not HttpOnly cookies)
      user_id = cookies.encrypted[:user_id] # or `cookies.signed[:user_id]` if signed
      return unless user_id

      User.find_by(id: user_id)
    end

  end
end

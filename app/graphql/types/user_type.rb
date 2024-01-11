module Types
    class UserType < BaseObject
      field :id, ID, null: false # Make sure this line exists
      field :username, String, null: true
      field :profile_image, String, null: true
  
    
    end
  end
  
module Types
    class UserType < BaseObject
      field :id, ID, null: false # Make sure this line exists
      field :username, String, null: true
      field :bio, String, null: true
      field :location, String, null: true
      field :title, String, null: true
      field :profile_image, String, null: true
  
    
    end
  end
  
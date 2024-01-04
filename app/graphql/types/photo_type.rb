module Types
    class PhotoType < Types::BaseObject
      field :id, ID, null: false
      field :event_id, Integer, null: true
      field :user_id, Integer, null: true
      field :image_url, String, null: true
      field :favorites_count, Integer, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :tags, String, null: true
      field :published, Boolean, null: true
      field :title, String, null: true
      field :trashed, Boolean, null: true
      field :action_id, Integer, null: true
      field :views, Integer, null: true
      field :description, String, null: true
      field :region_id, Integer, null: true

      field :user, UserType, null: true  # Add this line

      field :upvotes, Integer, null: false
      field :photo_comments, [Types::PhotoCommentType], null: true

      def upvotes
        # Assuming object is an instance of the PhotoComment model
        object.upvotes
      end

      def image_url
        # Assuming `object` is the instance of the Photo model
        # and it has_one_attached :image via ActiveStorage
        Rails.application.routes.url_helpers.url_for(object.image) if object.image.attached?
      end
    end
  end
  
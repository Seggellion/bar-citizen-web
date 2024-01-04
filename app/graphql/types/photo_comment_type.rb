module Types
    class PhotoCommentType < BaseObject
      field :content, String, null: true
      field :user, Types::UserType, null: true

      field :upvotes, Integer, null: false

      def upvotes
        # Assuming object is an instance of the PhotoComment model
        object.upvotes
      end
    end
  end
  
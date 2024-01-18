module Types
    class EventType < Types::BaseObject
      field :title, String, null: false
      field :id, Integer, null: false
      field :latitude, Float, null: false
      field :longitude, Float, null: false
      field :description, String, null: true
      field :start_datetime, GraphQL::Types::ISO8601DateTime, null: true
      field :end_datetime, GraphQL::Types::ISO8601DateTime, null: true

      field :discordLink, String, null: true

      def discordLink
        # Return the discord URL if it exists, otherwise return nil
        object.discord&.server_url
      end

      field :attendees, [Types::UserType], null: true

      def attendees
        object.attendees
      end

      field :bannerImageUrl, String, null: true

      def bannerImageUrl

        # Assuming you have a method to get the URL or you're using Active Storage
        Rails.application.routes.url_helpers.url_for(object.banner) if object.banner.attached?
      end

    end
  end
  
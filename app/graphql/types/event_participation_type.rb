module Types
    class EventParticipationType < Types::BaseObject
      field :id, Integer, null: false
      field :user_id, Integer, null: false
      field :event_id, Integer, null: false
      field :description, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true


      field :event, [Types::EventType], null: true

      def event
        object.event
      end

 
      field :user, [Types::UserType], null: true

      def user
        object.user
      end
    end
  end
  
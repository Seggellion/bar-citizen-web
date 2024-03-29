# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :all_photos, [PhotoType], null: false
    def all_photos
      # Fetch all photos or apply some scope, depending on your needs
      Photo.where(published: true)  # For example, only return published photos
    end

    field :all_events, [EventType], null: false

    def all_events
      Event.where(published: true) 
    end

    field :all_event_participations, [EventParticipationType], null: false

    def all_event_participations
      EventParticipation.all
    end

    field :all_regions, [RegionType], null: false

    def all_regions
      Region.all
    end

    field :is_user_attending, Boolean, null: false do
      argument :user_id, Integer, required: true
      argument :event_id, Integer, required: true
    end

    def is_user_attending(user_id:, event_id:)
      
      EventParticipation.exists?(user_id: user_id, event_id: event_id)
    end

    field :user, Types::UserType, null: true do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

   # Update the event field to accept eventId as an Integer
   field :event, Types::EventType, null: true do
    argument :id, Integer, required: true
  end

  def event(id:)
    Event.find(id)
  end


    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end

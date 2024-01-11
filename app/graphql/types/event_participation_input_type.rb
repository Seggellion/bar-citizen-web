# app/graphql/types/event_participation_input_type.rb
module Types
    class EventParticipationInputType < Types::BaseInputObject
      argument :user_id, Integer, required: true
      argument :event_id, Integer, required: true
    end
  end

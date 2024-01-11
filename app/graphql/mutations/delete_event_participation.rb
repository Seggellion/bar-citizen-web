# app/graphql/mutations/delete_event_participation.rb
module Mutations
    class DeleteEventParticipation < BaseMutation
      argument :input, Types::EventParticipationDeleteInputType, required: true
  
      field :success, Boolean, null: false
      field :errors, [String], null: false
  
      def resolve(input:)        
        event_participation = EventParticipation.find_by(input.to_h)
        Activity.create(name: "Left event", description: "event-id_#{event_participation.event_id}", user_id: event_participation.user_id)
        if event_participation&.destroy

          { success: true, errors: [] }
        else
          { success: false, errors: event_participation&.errors&.full_messages || ["Not found"] }
        end
      end
    end
  end
  
# app/graphql/mutations/create_event_participation.rb
module Mutations
    class CreateEventParticipation < BaseMutation

      argument :input, Types::EventParticipationInputType, required: true

      #argument :user_id, Integer, required: true
      #argument :event_id, Integer, required: true

      field :event_participation, Types::EventParticipationType, null: false
      field :errors, [String], null: false

      
      def resolve(input:)
        Rails.logger.info "CreateEventParticipation#resolve called with input: #{input.inspect}"

        event_participation = EventParticipation.new(user_id: input[:user_id], event_id: input[:event_id])

        if event_participation.save

          Activity.create(name: "User joined", description: "event-id_#{event_participation.event_id}", user_id: event_participation.user_id)
          # Successful creation
          {
            event_participation: event_participation,
            errors: []
          }
        else
          # Failed to create event_participation
          {
            event_participation: nil,
            errors: event_participation.errors.full_messages
          }
        end
      end
    end
  end
  
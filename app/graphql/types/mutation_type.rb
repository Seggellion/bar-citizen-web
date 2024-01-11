module Types
  class MutationType < Types::BaseObject

    field :create_event_participation, mutation: Mutations::CreateEventParticipation
    field :delete_event_participation, mutation: Mutations::DeleteEventParticipation

  end
end

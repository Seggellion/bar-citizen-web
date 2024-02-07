module Types
  class MutationType < Types::BaseObject

    field :create_event_participation, mutation: Mutations::CreateEventParticipation
    field :delete_event_participation, mutation: Mutations::DeleteEventParticipation
    field :update_user, mutation: Mutations::UpdateUser

  end
end

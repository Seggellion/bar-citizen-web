module Types
    class EventType < Types::BaseObject
      field :title, String, null: false
      field :description, String, null: true
      field :start_datetime, GraphQL::Types::ISO8601DateTime, null: true
      field :end_datetime, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
  
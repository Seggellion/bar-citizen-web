module Types
    class RegionType < Types::BaseObject
      field :name, String, null: false
      field :description, String, null: true
      field :city, String, null: true
    end
  end
  
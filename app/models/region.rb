# app/models/region.rb
class Region < ApplicationRecord
    belongs_to :user
    has_many :discords
    has_many :events
    has_and_belongs_to_many :regional_managers, class_name: 'User'
  end
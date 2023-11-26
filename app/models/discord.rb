# app/models/discord.rb
class Discord < ApplicationRecord
    belongs_to :region
    belongs_to :user
  end
# app/models/discord.rb
class Discord < ApplicationRecord
    belongs_to :discordable, polymorphic: true
    belongs_to :user
    has_many :events
  end
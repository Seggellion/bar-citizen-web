class AddDiscordToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :discord, null: true, foreign_key: true
  end
end

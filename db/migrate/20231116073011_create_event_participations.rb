class CreateEventParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :event_participations do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
    add_index :event_participations, [:user_id, :event_id], unique: true

  end
end

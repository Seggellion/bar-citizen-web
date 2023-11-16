class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_datetime
      t.string :location
      t.string :region
      t.text :social_media_links
      t.string :discord_link
      t.integer :creator_id

      t.timestamps
    end
  end
end

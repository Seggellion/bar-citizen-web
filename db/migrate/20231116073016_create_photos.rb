class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :image_url
      t.integer :upvotes
      t.integer :downvotes
      t.integer :favorites_count

      t.timestamps
    end
  end
end

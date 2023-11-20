class PostTitle < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :title, :string
    add_column :users, :rsi_account, :string
    add_column :post_categories, :region, :string

    create_table :photo_comments do |t|
      t.text :content
      t.integer :upvote
      t.integer :downvote
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end

    create_table :event_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end

  end
end

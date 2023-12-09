class Giveaways < ActiveRecord::Migration[7.1]
  def change


    create_table :giveaways do |t|
      t.string :title
      t.string :description
      t.integer :winner_id

      t.references :creator, foreign_key: { to_table: :users }
      t.references :event, foreign_key: true
      t.timestamps
    end

    create_table :event_messages do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :message, null: false
      t.timestamps
    end

    

    create_table :giveaway_users do |t|
      t.references :user, foreign_key: true
      t.references :giveaway, foreign_key: true

      t.timestamps
    end

    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :votable, polymorphic: true, null: false
      t.boolean :upvote, default: false, null: false

      t.timestamps
    end

    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true, name: 'index_votes_on_user_and_votable'

    add_index :giveaway_users, [:user_id, :giveaway_id], unique: true
    add_column :events, :end_datetime, :datetime
    add_column :events, :cost, :float
    add_column :events, :location_name, :string
    add_column :events, :status, :string

    add_column :photos, :views, :integer
    add_column :photos, :description, :string
    remove_column :photos, :categories, :integer
    add_column :photos, :region_id, :integer
    remove_column :photos, :upvotes, :integer
    remove_column :photos, :downvotes, :integer
    remove_column :photo_comments, :upvote, :integer
    remove_column :photo_comments, :downvote, :integer



  end
end

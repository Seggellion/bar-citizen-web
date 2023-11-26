class RegionActivitiesDiscordsNewsletter < ActiveRecord::Migration[7.1]
  def change

    create_table :regions do |t|
      t.string :name
      t.string :description
      t.string :profile_image
      t.references :user, foreign_key: true # User who created the region

      t.timestamps
    end

    # Create a join table for Regions and regional managers (Users)
    create_join_table :regions, :users do |t|
      t.index :region_id
      t.index :user_id
    end

    # Create AppActivities (Activities) table
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.references :user, foreign_key: true # Activity belongs to a user

      t.timestamps
    end

    # Create Region Discord Servers (Discords) table
    create_table :discords do |t|
      t.string :server_name
      t.string :server_url
      t.string :server_icon
      t.string :server_description
      t.references :user, foreign_key: true # User who created the region
      t.references :region, foreign_key: true # Discord belongs to a region

      t.timestamps
    end

    create_table :event_managers do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_column :users, :newsletter, :boolean, default: false, null: false
    add_column :events, :profile_image, :string
    remove_column :events, :region, :string
    remove_column :events, :discord_link, :string
    remove_column :post_categories, :region, :string
    add_column :post_categories, :region_id, :integer
    add_column :events, :discord_id, :integer
    add_column :events, :region_id, :integer
    add_column :events, :city, :string
    add_column :events, :latlong, :string
    add_column :events, :featured, :boolean, default: false, null: false

  end
end

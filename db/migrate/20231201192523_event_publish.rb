class EventPublish < ActiveRecord::Migration[7.1]
  def change

    add_column :events, :published, :boolean
    add_column :events, :trashed, :boolean
    add_column :events, :action_id, :integer
    remove_column :events, :discord_id, :integer

    add_column :photo_comments, :published, :boolean
    add_column :photo_comments, :trashed, :boolean
    add_column :photo_comments, :action_id, :integer

    add_column :posts, :trashed, :boolean
    add_column :posts, :action_id, :integer

    add_column :discords, :trashed, :boolean
    add_column :discords, :action_id, :integer

    add_column :discords, :discord_type, :integer
    remove_column :discords, :type, :string
    remove_column :discords, :region_id, :integer
    add_reference :discords, :discordable, polymorphic: true, null: true

    add_column :post_categories, :trashed, :boolean
    add_column :post_categories, :action_id, :integer
    rename_column :post_categories, :desription, :description
    rename_column :post_categories, :type, :category_type

    add_column :regions, :trashed, :boolean
    add_column :regions, :action_id, :integer

    add_column :photos, :trashed, :boolean
    add_column :photos, :action_id, :integer

    add_column :users, :trashed, :boolean
    add_column :users, :action_id, :integer

    add_column :replies, :trashed, :boolean
    add_column :replies, :action_id, :integer

    change_column_default :users, :karma, from: nil, to: 0
    change_column_default :users, :fame, from: nil, to: 0
  end
end

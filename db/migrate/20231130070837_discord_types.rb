class DiscordTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :discords, :type, :string
    add_column :post_categories, :desription, :string
    add_column :post_categories, :type, :string
    add_column :posts, :views, :integer
    add_column :discords, :published, :boolean
    add_column :regions, :published, :boolean
    add_column :users, :published, :boolean
    add_column :post_categories, :published, :boolean
    add_column :replies, :published, :boolean
  end
end

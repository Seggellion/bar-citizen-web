class CreatePostsAndPostCategories < ActiveRecord::Migration[7.1]
  def change

    add_column :users, :profile_image, :string
    add_column :users, :twitch_id, :string
    add_column :users, :twitch_channel, :string
    add_column :users, :discord_channel, :string

    create_table :post_categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :post_category, foreign_key: true

      t.timestamps
    end

  end
end

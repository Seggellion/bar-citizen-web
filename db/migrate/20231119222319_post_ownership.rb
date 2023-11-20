class PostOwnership < ActiveRecord::Migration[7.1]
  def change

    add_column :users, :location, :string
    add_column :photos, :tags, :string
    add_column :photos, :categories, :string
    add_column :posts, :user_id, :integer
    add_column :post_categories, :user_id, :integer
    add_column :posts, :published, :boolean
    add_column :photos, :published, :boolean
    
    create_table :replies do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

  end
end

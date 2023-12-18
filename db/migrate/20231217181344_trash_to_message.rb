class TrashToMessage < ActiveRecord::Migration[7.1]
  def change
    # Adding non-nullable slug to regions
    add_column :regions, :slug, :string
    Region.find_each do |region|
      # Using FriendlyID to generate the slug
      region.slug = region.name.parameterize
      region.save(validate: false)
    end
    change_column :regions, :slug, :string, null: false
    add_index :regions, :slug, unique: true

    # Adding non-nullable slug to post_categories
    add_column :post_categories, :slug, :string
    PostCategory.find_each do |post_category|
      # Using FriendlyID to generate the slug
      post_category.slug = post_category.name.parameterize
      post_category.save(validate: false)
    end
    change_column :post_categories, :slug, :string, null: false
    add_index :post_categories, :slug, unique: true

    # Other changes
    add_column :messages, :trashed, :boolean
  end
end

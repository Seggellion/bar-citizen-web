class CreateSectionsAndRelatedModels < ActiveRecord::Migration[7.1]
  def change

    


    # Create video_sections table
    create_table :video_sections do |t|
      t.string :title
      t.string :youtube_link
      t.text :description
      t.timestamps
    end

    # Create 2x2_grid_sections table
    create_table :two_by_two_grid_sections do |t|
      t.string :title
      t.timestamps
    end

    # Create 3_grid_sections table
    create_table :three_grid_sections do |t|
      t.string :title
      t.timestamps
    end

    create_table :content_sections do |t|
      t.string :title
      t.timestamps
    end

    create_table :hero_sections do |t|
      t.string :title
      t.timestamps
    end

    create_table :pages do |t|
      t.string :title, null: false
      t.string :category
      t.string :slug, null: false  
      t.string :meta_description
      t.string :meta_image
      t.string :description
      t.references :user, foreign_key: true
      t.timestamps
    end

    # Add an index to the title column with a uniqueness constraint
    add_index :pages, :title, unique: true

    # Add an index to the slug column with a uniqueness constraint
    add_index :pages, :slug, unique: true

    create_table :sections do |t|
      t.references :sectionable, polymorphic: true, index: true
      t.integer :section_order
      t.references :page, foreign_key: true
      t.timestamps
    end
    # Create blocks table
    create_table :blocks do |t|
      t.references :blockable, polymorphic: true, index: true
      t.string :title
      t.string :description
      t.integer :section_order, default: 0
      t.string :link_url
      t.references :section, foreign_key: true
      t.timestamps
    end

    create_table :translations do |t|
      t.references :block, null: false, foreign_key: true
      t.string :language, null: false
      t.string :title
      t.string :description
      t.string :link_url
      t.timestamps
    end

  end
end

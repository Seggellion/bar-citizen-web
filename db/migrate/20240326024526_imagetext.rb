class Imagetext < ActiveRecord::Migration[7.1]
  def change
    create_table :image_text_sections do |t|
      t.string :title
      t.timestamps
    end
  end
end

class CreateWallComments < ActiveRecord::Migration[7.1]
  def change
    create_table :wall_comments do |t|
      t.integer :owner_id
      t.integer :commenter_id
      t.text :content

      t.timestamps
    end
  end
end

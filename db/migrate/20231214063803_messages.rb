class Messages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.string :subject
      t.text :description

      t.timestamps
    end
    add_column :events, :event_type, :string
    add_column :events, :slug, :string, null: false 
    add_index :events, :slug, unique: true
  end
end

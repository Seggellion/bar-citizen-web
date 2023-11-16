class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :user_type
      t.string :discord_id
      t.string :bio
      t.integer :karma
      t.integer :fame
      t.timestamps
    end
  end
end

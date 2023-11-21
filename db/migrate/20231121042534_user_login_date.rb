class UserLoginDate < ActiveRecord::Migration[7.1]
  def change

    add_column :users, :last_login, :datetime
    add_column :users, :title, :string

    create_table :badges do |t|
      t.string :name
      t.text :description
      t.string :icon # URL or path to the badge's icon/image

      t.timestamps
    end

    create_table :user_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true
      t.datetime :earned_at # The date and time when the badge was earned

      t.timestamps
    end

    add_index :user_badges, [:user_id, :badge_id], unique: true


  end
end

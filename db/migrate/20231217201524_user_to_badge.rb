class UserToBadge < ActiveRecord::Migration[7.1]
  def change
    add_column :badges, :user_id, :integer
    add_column :badges, :trashed, :boolean
    add_column :badges, :published, :boolean
  end
end

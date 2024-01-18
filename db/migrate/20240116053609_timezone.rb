class Timezone < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :timezone, :string
    add_column :regions, :timezone, :string
    add_column :discords, :timezone, :string
    add_column :users, :timezone, :string

  end
end

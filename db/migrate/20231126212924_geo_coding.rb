class GeoCoding < ActiveRecord::Migration[7.1]
  def change

    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :events, :facebook, :string
    add_column :events, :twitter, :string
    add_column :events, :tiktok, :string
    add_column :events, :instagram, :string
    add_column :discords, :latitude, :float
    add_column :discords, :longitude, :float
    add_column :discords, :city, :string
    add_column :regions, :city, :string
    add_column :regions, :latitude, :float
    add_column :regions, :longitude, :float
    remove_column :events, :latlong
    remove_column :events, :social_media_links
    rename_column :events, :location, :address
    
  end
end

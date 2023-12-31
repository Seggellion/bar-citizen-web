# app/models/region.rb
class Region < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
    belongs_to :user
    # has_many :discords
    has_many :events
    has_and_belongs_to_many :regional_managers, class_name: 'User'
    has_one_attached :logo_image
    has_one_attached :banner
    has_one_attached :image_01
    has_one_attached :image_02
    has_many :discords, as: :discordable
    has_one :post_category

    validates :name, presence: true
    validates :city, presence: true

    geocoded_by :city
    before_save :geocode_city, if: ->(obj){ obj.city.present? and obj.city_changed? }


    private

    def geocode_city      
      # The geocode method is provided by the geocoder gem
      geocode
    end  
  end
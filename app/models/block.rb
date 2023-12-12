class Block < ApplicationRecord
    belongs_to :section
    has_many :translations, dependent: :destroy
    accepts_nested_attributes_for :translations, allow_destroy: true

    has_one_attached :image
  end
  
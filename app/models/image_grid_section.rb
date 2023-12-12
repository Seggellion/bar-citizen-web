class ImageGridSection < ApplicationRecord
    has_many :images, dependent: :destroy
    has_one :section, as: :sectionable
  end
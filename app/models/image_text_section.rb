class ImageTextSection < ApplicationRecord
    has_many :blocks, as: :blockable
    has_one :section, as: :sectionable
  end
  
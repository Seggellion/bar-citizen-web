class VideoSection < ApplicationRecord
    has_one :section, as: :sectionable
  end
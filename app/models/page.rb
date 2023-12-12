class Page < ApplicationRecord
    has_many :sections
    belongs_to :user
    validates :title, presence: true
    before_validation :generate_slug

    private
  
    def generate_slug
      self.slug = title.parameterize unless slug.present?
      # Additional logic to ensure slug uniqueness, if needed
    end
  end
  
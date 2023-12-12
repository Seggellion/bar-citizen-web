class Section < ApplicationRecord
    belongs_to :sectionable, polymorphic: true
    belongs_to :page
    has_many :blocks
    scope :ordered, -> { order(section_order: :asc) }

    def sectionable_title
        sectionable.try(:title)
      end
  end
class Photo < ApplicationRecord
    # Associations
    belongs_to :user
    belongs_to :event
    has_many :comments
    has_many :tags  # Assuming you have a Tag model for user tagging
    # For upvotes and downvotes, you can either use a counter cache or a separate model
  
    # Active Storage association for the image
    has_one_attached :image
    validates :image, presence: true

    # Additional fields
    attribute :published, :boolean, default: false
    attribute :upvotes, :integer, default: 0
    attribute :downvotes, :integer, default: 0
    attribute :category, :string  # Assuming category is a simple string; use belongs_to for a separate Category model
    attribute :region, :string    # Assuming region is a string
  
    # Validations and other logic as needed
  end
  
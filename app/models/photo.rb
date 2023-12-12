class Photo < ApplicationRecord
    # Associations
    belongs_to :user
    belongs_to :event
    belongs_to :region
    has_many :photo_comments
    has_many :tags  # Assuming you have a Tag model for user tagging
    # For upvotes and downvotes, you can either use a counter cache or a separate model
    has_many :votes, as: :votable, dependent: :destroy

    # Active Storage association for the image
    has_one_attached :image
    validates :image, presence: true

    # Additional fields
    attribute :published, :boolean, default: false
    attribute :category, :string  # Assuming category is a simple string; use belongs_to for a separate Category model    # Assuming region is a string
  
   

    def upvoted_by?(user)
      votes.exists?(user: user, upvote: true)
    end
  
    def downvoted_by?(user)
      votes.exists?(user: user, upvote: false)
    end
    # Validations and other logic as needed
  end
  
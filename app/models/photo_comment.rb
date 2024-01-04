class PhotoComment < ApplicationRecord
    belongs_to :user
    belongs_to :photo
    has_many :votes, as: :votable, dependent: :destroy

    def upvotes
      votes.where(upvote:true).count
     end
  

    def upvoted_by?(user)
        votes.exists?(user: user, upvote: true)
      end
    
      def downvoted_by?(user)
        votes.exists?(user: user, upvote: false)
      end

end

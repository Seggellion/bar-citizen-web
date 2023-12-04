class PostCategory < ApplicationRecord
    has_many :posts
    validates :name, presence: true
    validates :user_id, presence: true

    def total_replies
      # This will sum up all replies for posts in this category.
      posts.joins(:replies).count
    end


      # Method to get the date_time of the last reply
  def last_reply_time
    last_reply = posts.joins(:replies).select('replies.created_at').order('replies.created_at DESC').first
    return unless last_reply

    last_reply.created_at.strftime('%a %b %d, %Y %l:%M %p')
  end

    # Method to get the user_id of the last reply
    def last_reply_user
      last_reply = posts.joins(:replies).select('replies.user_id').order('replies.created_at DESC').first
      last_reply&.user
    end
  end
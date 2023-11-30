# app/models/post.rb
class Post < ApplicationRecord
    belongs_to :post_category
    has_many :replies, dependent: :destroy
    belongs_to :user


    def last_reply
      replies.order(created_at: :desc).limit(1).last
    end
  end
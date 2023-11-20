# app/models/post.rb
class Post < ApplicationRecord
    belongs_to :post_category
    has_many :replies, dependent: :destroy
    belongs_to :user
  end
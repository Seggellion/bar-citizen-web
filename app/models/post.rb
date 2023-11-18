# app/models/post.rb
class Post < ApplicationRecord
    belongs_to :post_category
  end
# app/models/post.rb
class Giveaway < ApplicationRecord
    belongs_to :event
    has_one_attached :image
    belongs_to :creator, class_name: 'User' # Change this line
    belongs_to :winner, class_name: 'User', optional: true # Add this line
  


  end
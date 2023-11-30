# app/models/reply.rb
class Reply < ApplicationRecord
    belongs_to :user
    belongs_to :post
  
    # Validations (optional, based on your requirements)
    validates :content, presence: true
    
  end
  
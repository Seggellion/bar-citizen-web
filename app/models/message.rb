# app/models/message.rb
class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
    has_one_attached :image

    def user
      self.sender
    end
  end
  
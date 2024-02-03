class WallComment < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    belongs_to :commenter, class_name: 'User'
  end
  
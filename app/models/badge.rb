class Badge < ApplicationRecord
belongs_to :user
has_many :user_badges
end
  
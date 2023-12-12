class Translation < ApplicationRecord
    belongs_to :block
  
    # Validations
    validates :language, presence: true

  end
  
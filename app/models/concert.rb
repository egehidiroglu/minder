class Concert < ApplicationRecord
  acts_as_favoritable

  belongs_to :creator
end

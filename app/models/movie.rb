class Movie < ApplicationRecord
  acts_as_favoritable
  
  belongs_to :creator
end

class FollowedCreator < ApplicationRecord
  belongs_to :creator
  belongs_to :user
end

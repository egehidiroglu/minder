class Creator < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :concerts, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_many :followed_creators, dependent: :destroy
end

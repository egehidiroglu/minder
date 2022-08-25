class User < ApplicationRecord
  has_many :followed_creators, dependent: :destroy
  has_many :creators, through: :followed_creators
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true, format: { with: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/ }
end

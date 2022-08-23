class User < ApplicationRecord
  has_many :followed_creators, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true, format: { with: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/ }
end

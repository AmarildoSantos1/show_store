class User < ApplicationRecord
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true

  has_many :user_items
  has_many :items, through: :user_items

  has_many :orders

  has_secure_password
end
class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :quantity, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :user_items
  has_many :users, through: :user_items

  has_many :order_items
  has_many :orders, through: :order_items


  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end
end
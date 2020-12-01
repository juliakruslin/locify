class Product < ApplicationRecord
  belongs_to :user
  # belongs_to :cart_item
  #has_many :delivery_options
  # has_many :carts, through: :cart_item
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end

class Product < ApplicationRecord
  belongs_to :user

  #has_many :delivery_options
  # belongs_to :cart_item
  has_many :carts, through: :cart_items
  has_many_attached :photos


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end

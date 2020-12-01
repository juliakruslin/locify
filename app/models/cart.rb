class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def calculate_total_price
    self.total_price = self.cart_items.sum(&:price)
    self.save
  end
end

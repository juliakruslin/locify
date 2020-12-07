class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy
  monetize :price_cents

  after_touch :calculate_total_price

  def calculate_total_price
    self.cart_items.reload
    self.price = self.cart_items.sum(&:price)
    self.save
  end
end

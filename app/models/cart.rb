class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy

  after_touch :calculate_total_price

  def calculate_total_price
    self.cart_items.reload
    self.total_price = self.cart_items.sum(&:price)
    self.save
  end
end

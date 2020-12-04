class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, touch: true
  # belongs_to :delivery_option

  before_validation(:calculate_price)
  after_commit :recalculate_total

  def calculate_price
    self.price = self.product.price * amount

  end

  def recalculate_total
    self.cart.calculate_total_price
  end
end

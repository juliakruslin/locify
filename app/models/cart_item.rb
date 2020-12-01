class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  # belongs_to :delivery_option

  before_validation(:calculate_price)

  def calculate_price
    self.price = self.product.price * amount
  end
end

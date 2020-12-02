class CartsController < ApplicationController
  before_action :find_create_cart

  def show
  end

  def add_to_cart
    chosen_product = Product.find(params[:id])
    @cart_item = CartItem.find_or_create_by(product: chosen_product, cart: @cart)
    @cart_item.amount += 1
    @cart_item.save
    @cart.calculate_total_price
    redirect_to product_path(chosen_product), notice: "Product has been added to cart"
  end

  def edit
    @cart_item = CartItem.find(params[:id])
  end

  def update_amount
    # TODO
    @cart_item = CartItem.find(params[:id])
    @cart_item.update!(cart_item_params)
    # @cart.update!(total_price: total_price)
    redirect_to cart_path
  end
  # code from stackover
  # @line_item.update_attribute(:quantity)

  def destroy
    @cart.destroy
    redirect_to cart_path
  end

  private

  def cart_params
    params.require(:cart).permit(:total_price, :order_number, :status)
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

  def find_create_cart
    @cart = Cart.find_or_create_by(user: current_user, status: "pending")
  end
end

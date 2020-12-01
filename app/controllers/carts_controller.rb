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
  end

  def update
    # TODO
    # @cart.update!(cart_params)
    # @cart.update!()
    # redirect_to cart_path(@cart)
  end

  def destroy
    @cart.destroy
    redirect_to cart_path
  end

  private

  def cart_params
    params.require(:cart).permit(:total_price, :order_number, :status)
  end

  def find_create_cart
    @cart = Cart.find_or_create_by(user: current_user, status: "pending")
  end
end

class CartsController < ApplicationController
  before_action :find_create_cart

  def show
    @cart_items = @cart.cart_items.order(id: :desc)
  end

  def add_to_cart
    chosen_product = Product.find(params[:id])
    @cart = Cart.new if @cart.status == 'ordered'
    @cart_item = CartItem.find_or_create_by(product: chosen_product, cart: @cart)
    @cart_item.amount += 1
    @cart_item.save
    @cart.calculate_total_price
    redirect_back(fallback_location: root_url, notice: "Product has been added to cart")
  end

  def edit
    @cart_item = CartItem.find(params[:id])
  end

  def update_amount
    # TODO
    @cart_item = CartItem.find(params[:id])
    @cart_item.update!(cart_item_params)
    redirect_to cart_path
  end

  def increase_amount
    @cart_item = CartItem.find(params[:id])
    @cart_item.amount += 1
    @cart_item.save
    redirect_to cart_path(anchor: "cart-item-#{@cart_item.id}")
  end

  def decrease_amount
    @cart_item = CartItem.find(params[:id])
    @cart_item.amount -= 1
    if @cart_item.amount >= 1
      @cart_item.save
    else
      @cart_item.destroy
    end
    redirect_to cart_path(anchor: "cart-item-#{@cart_item.id}")
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to products_path
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

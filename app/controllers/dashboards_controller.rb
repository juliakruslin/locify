class DashboardsController < ApplicationController
  def show
    @products = Product.all
    # @product = Product.find(params[:id])
    @cart = Cart.find_or_create_by(user: current_user, status: "pending")
  end

  def profile
  end

  def orders
    @orders = Order.where(user: current_user)
  end
end

class ProductsController < ApplicationController
skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product = Product.update(product_params)
    redirect_to product_path(@product)
    # how to add possibility to update pictures?
  end

  def new
    @product = Product.new
  end

# create is not working yet

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
    else
      render "new"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, photos: [])
  end
end

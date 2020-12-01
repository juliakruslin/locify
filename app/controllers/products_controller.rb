class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @products = Product.all
    @user = User.all.where(seller_approved: true)
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    map
  end

  def show
    @product = Product.find(params[:id])
    # @user = @product.user
    @user = User.all.where(seller_approved: true)
    map
    # @markers = @user.geocode.map do |user| {
    #   lat: user.latitude,
    #   lng: user.longitude,
    #   infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
    #   image_url: helpers.asset_url('shop_marker')
    # }
    # end
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

  def map
    @markers = @user.geocoded.map do |user| {
      lat: user.latitude,
      lng: user.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
      image_url: helpers.asset_url('shop_marker')
    }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, photos: [])
  end
end









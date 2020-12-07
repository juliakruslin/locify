class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    # TODO: somehow include subcategories in here
    if params[:subcategory].present?
      @products = Product.joins(:subcategory).where(subcategories: { name: params[:subcategory] })
    elsif params[:category].present?
      @products = Product.joins(:category).where(categories: { name: params[:category] })
    else
      @products = Product.all
    end

    if params[:query].present?
      @products = @products.global_search(params[:query])
    end

    if params[:location].present?
      @user_ids = User.near(params[:location], 10).map(&:id)
      @products = @products.where(user_id: @user_ids)
    end
    map
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
    @user = User.all.where(seller_approved: true)
    map
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
    @product.delivery_options.build
  end

  # create is not working yet

  def create
    @product = Product.new(product_params_filtered)
    @product.user = current_user
    @product.category = Category.find(params[:product][:category_id])
    @product.subcategory = Subcategory.find(params[:product][:subcategory_id])
    if @product.save!
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
    @user = User.all.where(seller_approved: true)
    @markers = @user.geocoded.map do |user| {
      lat: user.latitude,
      lng: user.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
      image_url: helpers.asset_url('shop_marker.png')
    }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, photos: [], delivery_options_attributes: [:name, :price])
  end


  def product_params_filtered
    new_product_params = product_params
    new_product_params[:delivery_options_attributes].reject!{ |key, delivery_options|
      !delivery_options[:name].in?(params[:offered_delivery_options].keys)
    }
  new_product_params
  end
end




class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # TODO: somehow include subcategories in here
    @products = Product.all
    if params[:subcategory].present?
      @products = @products.joins(:subcategory).where(subcategories: { name: params[:subcategory] })
    elsif params[:category].present?
      @products = @products.joins(:category).where(categories: { name: params[:category] })
    end

    if params[:subcategories].present?
      @products = Product.joins(:subcategory).where(subcategories: { id: params[:subcategories] })
    end

    if params[:delivery_option].present?
      product_ids = DeliveryOption.where(name: params[:delivery_option]).pluck(:product_id)
      @products = @products.where(id: product_ids)
    end

    if params[:lon].present? && params[:lat].present?
      @user_ids = User.near([params[:lat], params[:lon]], 3).map(&:id)
      @products = @products.where(user_id: @user_ids)
    end

    if params[:query].present?
      @products = @products.global_search(params[:query])
    end

    if params[:location].present?
      @user_ids = User.near(params[:location], 10).map(&:id)
      @products = @products.where(user_id: @user_ids)
    end

    if params[:min_price].present? || params[:max_price].present?
      @products = @products.where("price >= ? AND price <= ?", params[:min_price].to_f, params[:max_price].to_f)
    end
    map

    @average_reviews = average_reviews
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
    @user = User.all.where(seller_approved: true)
    map
    @product_in_wishlist = current_user.wishlist_products.any? { |product| product == @product }
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

  def add_to_wishlist
    chosen_product = Product.find(params[:id])
    @user = current_user
    if current_user.wishlist_products.any? { |product| product == chosen_product }
      redirect_to product_path(chosen_product), notice: "Product already in wishlist"
    else
      current_user.wishlist_products << chosen_product
      redirect_to product_path(chosen_product), notice: "Product has been added to wishlist"
    end
  end

  def delete_from_wishlist
    @product = Product.find(params[:id])
    current_user.wishlist_products.destroy(@product)
    redirect_to product_path(@product), notice: "Product has been deleted from wishlist"
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
      id: user.id,
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

  def average_reviews
    sum = 0
    @products.each do |product|
      product.reviews.each do |review|
        sum += review.stars
      end
    end
    review_sum = 0
    @products.each do |product|
      review_sum += product.reviews.count
    end
    sum
    @average_rating = sum/review_sum.to_f
    @average_rating.round(1)
  end
end

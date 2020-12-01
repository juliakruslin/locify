class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:query].present?
      @products = Product.global_search(params[:query])
    else
      @products = Product.all
    end

    if params[:location].present?
      @user_ids = User.near(params[:location], 10).map(&:id)
      @products = @products.where(user_id: @user_ids)
    end

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    map
  end
    # sql_query = "name @@ :query
    # OR description @@ :query
    # OR user @@ :query"
    # @products = Product.where(sql_query, query: "%#{params[:query]}%")

    # Why dont I have to say product.name?
    # Do I need an association? The user.name + user.location can be accessed through product

    # User can type in Location --> Geocoding lecture
    # Dropdown will show potential results (Austria prioritized!)
    # User chooses result from dropdown
    # Navigation to specific landing page possible?
    # Product.user.location (e.g. 5km around them will be shown)

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
  end

  # create is not working yet

  def create
    @product = Product.new(product_params)
    @product.user = current_user
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
      image_url: helpers.asset_url('shop_marker')
    }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, photos: [])
  end
end









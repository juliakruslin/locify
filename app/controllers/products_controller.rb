class ProductsController < ApplicationController
skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:query].present?
      @products = Product.global_search(params[:query])
    else
      @products = Product.all
    end
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

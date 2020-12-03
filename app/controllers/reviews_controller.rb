class ReviewsController < ApplicationController
  def new
    # we need @product in our `simple_form_for`
    @product = Product.find(params[:product_id])
    # @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # we need `product_id` to associate review with corresponding product
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user = current_user
    if @review.save!
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:stars, :description)
  end
  # random comment
end

class StoresController < ApplicationController
  def show
    @store = User.find(params[:id])
    @reviews = reviews
    @average_rating = average_reviews
  end

  private

  def reviews
    @store.products.each do |product|
      product.reviews
    end
  end

  def average_reviews
    sum = 0
    @store.products.each do |product|
      product.reviews.each do |review|
        sum += review.stars
      end
    end

    review_sum = 0
    @store.products.each do |product|
      review_sum += product.reviews.count
    end
    sum
    @average_rating = sum/review_sum.to_f
    @average_rating.round(1)
  end
end

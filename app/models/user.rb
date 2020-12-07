class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chatrooms, dependent: :destroy
  has_many :store_chatrooms, class_name: 'Chatroom', inverse_of: :store, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :cart_items, through: :carts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_street_number?
  after_validation :geocode, if: :will_save_change_to_street_name?

  # validates :first_name, presence: true
  # validates :last_name, presence: true

  def full_address
    "#{street_name}, #{street_number}, #{city}, #{postal_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def average_reviews
    sum = 0
    self.products.each do |product|
      product.reviews.each do |review|
        sum += review.stars
      end
    end

    review_sum = 0
    self.products.each do |product|
      review_sum += product.reviews.count
    end
    sum
    @average_rating = sum/review_sum.to_f
    @average_rating.round(1)
  end

  def review_sum
    review_sum = 0
    self.products.each do |product|
      review_sum += product.reviews.count
    end
    review_sum
  end
end

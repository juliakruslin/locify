class Product < ApplicationRecord

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  #has_many :delivery_options
  # has_many :carts, through: :cart_item
  has_many_attached :photos
  has_many :reviews, dependent: :destroy
  belongs_to :category
  belongs_to :subcategory

  # has_and_belongs_to_many

  has_many :delivery_options, dependent: :destroy
  accepts_nested_attributes_for :delivery_options

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  # validate :subcategory_part_of_category

 include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: {
      user: [:first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }
    }

    def average_reviews
    sum = 0
      self.reviews.each do |review|
        sum += review.stars
      end
    review_sum = self.reviews.count
    sum
    @average_rating = sum/review_sum.to_f
    @average_rating.round(1)
  end

    # def subcategory_part_of_category
    #   errors.add(:category, "subcategory not part of category") unless subcategory.category == category
    # end
end

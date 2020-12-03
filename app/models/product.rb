class Product < ApplicationRecord
  belongs_to :user
  # belongs_to :cart_item
  #has_many :delivery_options
  # has_many :carts, through: :cart_item
  has_many_attached :photos
  belongs_to :category

  has_many :delivery_options, dependent: :destroy
  accepts_nested_attributes_for :delivery_options


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

 include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: {
      user: [:first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }
    }
end

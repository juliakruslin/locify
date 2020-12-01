class Product < ApplicationRecord
  belongs_to :user

  #has_many :delivery_options
  # belongs_to :cart_item
  has_many :carts, through: :cart_items
  has_many_attached :photos


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

 include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description ],
    associated_against: {
      user: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end

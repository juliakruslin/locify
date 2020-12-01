class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :carts
  has_many :cart_items, through: :carts

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_street_number?
  after_validation :geocode, if: :will_save_change_to_street_name?

  # validates :first_name, presence: true
  # validates :last_name, presence: true

  def full_address
    "#{street_name}, #{street_number}, #{city}, #{postal_code}"
  end
end

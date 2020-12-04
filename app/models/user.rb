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

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_street_number?
  after_validation :geocode, if: :will_save_change_to_street_name?

  # validates :first_name, presence: true
  # validates :last_name, presence: true

  def full_address
    "#{street_name}, #{street_number}, #{city}, #{postal_code}"
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :carts
  has_many :cart_items, through: :carts

  # validates :first_name, presence: true
  # validates :last_name, presence: true
end

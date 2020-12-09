class DeliveryOption < ApplicationRecord
  belongs_to :product

  validates :name, inclusion: { in: ["Pick-up", "Postal Delivery", "Instant Bike Delivery"] }
end

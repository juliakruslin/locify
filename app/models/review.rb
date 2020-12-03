class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :description, presence: true
  validates :stars, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
end

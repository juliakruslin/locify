class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :user
  belongs_to :store, class_name: 'User'
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

CartItem.destroy_all
Cart.destroy_all
Product.destroy_all
User.destroy_all

user = User.create!(
  email: "lewagon@lewagon.com",
  first_name: "Julia",
  last_name: "Kruslin",
  password: "coolstuffwhatever"
  )

user = User.create!(
  email: "julia.viehbaeck@gmail.com",
  first_name: "Julia",
  last_name: "Viehbaeck",
  password: "123456"
  )

print "user printed #{user.email}"

6.times do
  product = Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentences(number: 5),
    price: rand(0..500),
    user: user,
    )
  2.times do
    file = URI.open("https://source.unsplash.com/collection/3590310/300x200")
    product.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  end
end

p "#{Product.count} products created"



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
Category.destroy_all

ADDRESSES = [
  {street_name: 'Plantsoen', street_number: '69', city: 'Leiden', postal_code: '2311 KJ'},
  {street_name: 'Spiegelgracht', street_number: '10', city: 'Amsterdam', postal_code: '1017 JR'},
]
categories = ["Beauty & Wellness", "Baby & Child", "Food & Beverages", "Home & Decor", "Fashion & Accessoires", "Sports", "Electronics"]
# delivery_options = ["Pick-up", "Postal Delivery", "Instant Bike Delivery"]

# user = User.create!(
#   email: "lewagon@lewagon.com",
#   first_name: "Julia",
#   last_name: "Kruslin",
#   password: "coolstuffwhatever"
#   )

  categories.map! do |category|
    category = Category.create(name: category)
    category
  end

  puts "#{Category.count} categories created!"




ADDRESSES.each do |address|
  store = User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "coolstuffwhatever",
    street_name: address[:street_name],
    street_number: address[:street_number],
    city: address[:city],
    postal_code: address[:postal_code],
    seller_approved: true
  )

p "#{Product.count} products created"


deliveryoptions = [
    DeliveryOption.create(name: "Pick-up", price: "0"),
    DeliveryOption.create(name: "Delivery", price: "3.95"),
    DeliveryOption.create(name: "Instant Bike Delivery", price: "4.95")
    ]

    10.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      price: rand(0..500),
      user: store,
      category: Category.all.sample,
      )
    5.times do
      file = URI.open("https://source.unsplash.com/collection/3590310/300x200")
      product.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    end
    deliveryoptions.first(rand(1..3)).each_with_index do |deliveryoption, index|
      deliveryoption.product = product
      deliveryoption.save
      puts "Creating deliveryoption #{index + 1} for #{product.name}"
    end

  puts "#{DeliveryOption.count} delivery options created!"

    p "#{Product.count} products created"
  end
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

Chatroom.destroy_all
CartItem.destroy_all
Cart.destroy_all
Review.destroy_all
Product.destroy_all
User.destroy_all
Category.destroy_all


ADDRESSES = [
  {street_name: 'Plantsoen', street_number: '69', city: 'Leiden', postal_code: '2311 KJ'},
  {street_name: 'Spiegelgracht', street_number: '10', city: 'Amsterdam', postal_code: '1017 JR'},
]
categories = ["Beauty & Wellness", "Baby & Child", "Food & Beverages", "Home & Decor", "Fashion & Accessoires", "Sports", "Electronics"]
DELIVERY_OPTIONS = ["Pick-up", "Postal Delivery", "Instant Bike Delivery"]

subcategories = [
  ["Hair", "Body", "Hygene"],
  ["Nutrition", "Care", "Baby Clothing"],
  ["Vegatbles", "Fruits", "Meat"],
  ["Plants", "Decoration", "Textiles"],
  ["Clothing", "Accessoires", "Shoes"],
  ["Sports wear", "Equipment", "Sneakers"],
  ["Media", "Smartphones", "Laptops"]
]

# user = User.create!(
#   email: "lewagon@lewagon.com",
#   first_name: "Julia",
#   last_name: "Kruslin",
#   password: "coolstuffwhatever"
#   )

  categories.map!.with_index do |category, index|
    category = Category.create(name: category)

    subcategories[index].map! do |subcategory|
      Subcategory.create(name: subcategory, category: category)
    end

  end

  puts "#{Category.count} categories created!"
  puts "#{Subcategory.count} subcategories created!"


ADDRESSES.each_with_index do |address, index|
  store = User.create!(
    email: "test#{index}@store.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "123456",
    street_name: address[:street_name],
    street_number: address[:street_number],
    city: address[:city],
    postal_code: address[:postal_code],
    seller_approved: true
    )

  p "#{Product.count} products created"


  10.times do
    category = Category.all.sample
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      price: rand(0..500),
      user: store,
      category: category,
      subcategory: category.subcategories.sample
      )
    5.times do
      file = URI.open("https://source.unsplash.com/collection/3590310/300x200")
      product.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    end

    random = rand(1..3)
    random.times do |num|
      option = DeliveryOption.create(name: DELIVERY_OPTIONS[num], price: rand(1..10))
      option.product = product
      option.save
    end

  puts "#{DeliveryOption.count} delivery options created for #{product.name}!"



    rand(3..6).times do
      review = Review.create!(
        product: product,
        user: store,
        stars: rand(1...5),
        description: Faker::Restaurant.review
        )
    p "#{Review.count} reviews created"
    end

    p "#{Product.count} products created"
  end
end


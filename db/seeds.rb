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
  {street_name: 'IJsbaanpad', street_number: '9', city: 'Amsterdam', postal_code: '1076CV'},
  {street_name: 'Stadionplein', street_number: '115', city: 'Amsterdam', postal_code: '1076CK'},
  {street_name: 'Danie Theronstraat', street_number: '37', city: 'Amsterdam', postal_code: '1091XW'},
  {street_name: 'Stadionweg', street_number: '159', city: 'Amsterdam', postal_code: '1076NN'},
  {street_name: 'Marathonweg', street_number: '2', city: 'Amsterdam', postal_code: '1076TE'},
  {street_name: 'Generaal Vetterstraat', street_number: '55', city: 'Amsterdam', postal_code: '1059BT'},
  {street_name: 'Anthony Fokkerweg', street_number: '50', city: 'Amsterdam', postal_code: '1059CP'},
  {street_name: 'Burgerweeshuispad', street_number: '54', city: 'Amsterdam', postal_code: '1076EP'},

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

end


  # Product 1
    camera = Product.create(
    name: "Polaroid Camera",
    description: "Polaroid’s new point-and-shoot analog instant camera has all you need to catch every life moment in an original Polaroid photograph. Now with autofocus, it’s simple to capture moments as you see them, so you can relive them forever in sharp, vivid color. Frame two moments in one with double exposure, or get yourself in the picture with self-timer and an accurate flash to make everyone look like they should. ",
    price: "99.99",
    user: User.all[0],
    category: Category.find_by_name("Electronics"),
    subcategory: Subcategory.find_by_name("Media")
    )
    DeliveryOption.create(name: "Instant Bike Delivery", product: camera, price: rand(1..10))

    file_1 = File.open("db/images/camera1.jpg")
    camera.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/camera2.jpg")
    camera.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/camera3.jpg")
    camera.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/camera4.jpg")
    camera.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/camera5.jpg")
    camera.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 2
    laptop = Product.create(
    name: "MacBook Air 13, 2015",
    description: "New MacBook Air 13 available for your private .or professional use. Make your life more comfortable and don't use pen and paper anymore",
    price: "899.99",
    user: User.all[1],
    category: Category.find_by_name("Electronics"),
    subcategory: Subcategory.find_by_name("Laptops")
    )

    file_1 = File.open("db/images/laptop1.jpg")
    laptop.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/laptop2.jpg")
    laptop.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/laptop3.jpg")
    laptop.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/laptop4.jpg")
    laptop.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/laptop5.jpg")
    laptop.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 11
    umbrella_1 = Product.create(
    name: "Colorful umbrella",
    description: "New with tags: A brand-new, unused, and unworn item (including handmade items) in the original packaging (such as the original box or bag) and/or with the original tags attached.",
    price: "19.90",
    user: User.all[2],
    category: Category.find_by_name("Fashion & Accessoires"),
    subcategory: Subcategory.find_by_name("Accessoires")
    )

    file_1 = File.open("db/images/umbrella1.jpg")
    umbrella_1.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/umbrella2.jpg")
    umbrella_1.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/umbrella3.jpg")
    umbrella_1.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/umbrella4.jpg")
    umbrella_1.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/umbrella5.jpg")
    umbrella_1.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 12
    umbrella_2 = Product.create(
    name: "Black umbrella",
    description: "A brand-new, unused, black and unworn umbrella (including handmade items) in the original packaging (such as the original box or bag) and/or with the original tags attached.",
    price: "17.90",
    user: User.all[3],
    category: Category.find_by_name("Fashion & Accessoires"),
    subcategory: Subcategory.find_by_name("Accessoires")
    )

    file_1 = File.open("db/images/blackumbrella1.jpg")
    umbrella_2.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/blackumbrella2.jpg")
    umbrella_2.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/blackumbrella3.jpg")
    umbrella_2.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/blackumbrella4.jpg")
    umbrella_2.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/blackumbrella5.jpg")
    umbrella_2.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 13
    umbrella_3 = Product.create(
    name: "Green umbrella",
    description: "A brand-new, unused, green and awesome umbrella (including handmade items) in the original packaging (such as the original box or bag) and/or with the original tags attached.",
    price: "10.89",
    user: User.all[4],
    category: Category.find_by_name("Fashion & Accessoires"),
    subcategory: Subcategory.find_by_name("Accessoires")
    )

    file_1 = File.open("db/images/greenumbrella1.jpg")
    umbrella_3.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/greenumbrella2.jpg")
    umbrella_3.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/greenumbrella3.jpg")
    umbrella_3.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/greenumbrella4.jpg")
    umbrella_3.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/greenumbrella5.jpg")
    umbrella_3.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 14
    umbrella_4 = Product.create(
    name: "Transparent umbrella",
    description: "A brand-new, unused, transparent and awesome umbrella (including handmade items) in the original packaging (such as the original box or bag) and/or with the original tags attached.",
    price: "18.99",
    user: User.all[5],
    category: Category.find_by_name("Fashion & Accessoires"),
    subcategory: Subcategory.find_by_name("Accessoires")
    )

    DeliveryOption.create(name: "Instant Bike Delivery", product: umbrella_4, price: rand(1..10))

    file_1 = File.open("db/images/plasticumbrella1.jpg")
    umbrella_4.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/plasticumbrella2.jpg")
    umbrella_4.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/plasticumbrella3.jpg")
    umbrella_4.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/plasticumbrella4.jpg")
    umbrella_4.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/plasticumbrella5.jpg")
    umbrella_4.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')

    # Product 15
    coat = Product.create(
    name: "Winter coat",
    description: "Get ready for the cold season of the year and buy yourself a very nice brand-new winter coat. It is available in different colors whichever fits the best for you.",
    price: "89.90",
    user: User.all[6],
    category: Category.find_by_name("Fashion & Accessoires"),
    subcategory: Subcategory.find_by_name("Clothing")
    )

    file_1 = File.open("db/images/coat1.jpg")
    coat.photos.attach(io: file_1, filename: 'nes.png', content_type: 'image/png')
    file_2 = File.open("db/images/coat1.jpg")
    coat.photos.attach(io: file_2, filename: 'nes.png', content_type: 'image/png')
    file_3 = File.open("db/images/coat1.jpg")
    coat.photos.attach(io: file_3, filename: 'nes.png', content_type: 'image/png')
    file_4 = File.open("db/images/coat1.jpg")
    coat.photos.attach(io: file_4, filename: 'nes.png', content_type: 'image/png')
    file_5 = File.open("db/images/coat1.jpg")
    coat.photos.attach(io: file_5, filename: 'nes.png', content_type: 'image/png')


    p "#{Product.count} products created"

    Product.all.each do |product|

      2.times do |num|
        option = DeliveryOption.create(name: DELIVERY_OPTIONS[num], price: rand(1..10))
        option.product = product
        option.save
      end

    rand(1...5).times do
      review = Review.create!(
        product: product,
        user: User.all.shuffle.first,
        stars: rand(1...5),
        description: Faker::Restaurant.review
        )
    p "#{Review.count} reviews created"
    end

    end
  # 10.times do
  #   category = Category.all.sample
  #   product = Product.create!(
  #     name: Faker::Commerce.product_name,
  #     description: Faker::Lorem.paragraph(sentence_count: 5),
  #     price: rand(0..500),
  #     user: store,
  #     category: category,
  #     subcategory: category.subcategories.sample
  #     )
  #   5.times do
  #     file = URI.open("https://source.unsplash.com/collection/3590310/300x200")
  #     product.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  #   end

  #   random = rand(1..3)
  #   random.times do |num|
  #     option = DeliveryOption.create(name: DELIVERY_OPTIONS[num], price: rand(1..10))
  #     option.product = product
  #     option.save
  #   end

  # puts "#{DeliveryOption.count} delivery options created for #{product.name}!"



  #   rand(3..6).times do
  #     review = Review.create!(
  #       product: product,
  #       user: store,
  #       stars: rand(1...5),
  #       description: Faker::Restaurant.review
  #       )
  #   p "#{Review.count} reviews created"
  #   end

  #   p "#{Product.count} products created"
  # end


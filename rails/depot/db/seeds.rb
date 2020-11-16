# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |product|
    Product.create!(
        title: "Moon Beer #{product}",
        description: "Moon Beer #{product} is the best moon beer you can get",
        price: rand(0..10.0).round(2),
        image_url: "beer.jpg"
    )
end
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Product.delete_all

products = [
  {
    title: 'Moon Beer',
    description: 'The best Moon Beer in the city',
    price: 8.95,
    image: 'moon_beer.jpg'
  },
  {
    title: 'Lager Beer',
    description: 'Extra long lasting beer',
    price: 7.95,
    image: 'lager.jpg'
  },
  {
    title: 'Porter',
    description: 'The best option after a long day of work',
    price: 4.95,
    image: 'porter.jpg'
  }
]

products.each do |p|
  product = Product.create(title: p[:title], description: p[:description], price: p[:price])
  product.image.attach(io: File.open(Rails.root.join('db', 'images', p[:image])), filename: p[:image])
  product.save!
end

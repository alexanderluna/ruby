# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

25.times do |n|
  Entry.create(
    title: 'sldkfjskldfj',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis feugiat mauris sapien, id sodales quam congue vehicula. Morbi vestibulum augue vitae eleifend ultrices.',
    date: Time.now.beginning_of_month.beginning_of_day + n.day,
    user_id: 2,
    created_at: Time.now.beginning_of_month.beginning_of_day + n.day,
    updated_at: Time.now.beginning_of_month.beginning_of_day + n.day
  )
end

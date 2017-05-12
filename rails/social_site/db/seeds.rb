# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


20.times do |user|
  my_user = User.create(name: "User_#{user}", email: "user_#{user}@gmail.com", password: "sldkfjnvklsdjfl", password_confirmation: "sldkfjnvklsdjfl")
  my_user.save!
  5.times do
    post = my_user.microposts.build(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tempor fringilla dictum. Vestibulum interdum tellus neque, vitae lacinia dui efficitur vel. Pellentesque gravida varius maximus. In pharetra massa vel tortor venenatis, id sodales tellus sagittis. Etiam condimentum tempus hendrerit. Curabitur tristique ultrices neque. Aliquam non accumsan ante, ornare aliquam dui. Curabitur consequat, metus eu suscipit commodo, ipsum leo finibus purus, et congue mi felis id augue. Quisque finibus libero augue, at porttitor elit dapibus quis. Sed massa lacus, ultrices id vestibulum sit amet, sollicitudin id diam. Cras porta vel urna vel gravida. Nullam blandit orci a elit consectetur, sed eleifend dui faucibus. Aliquam fermentum justo et nulla tempor, eget aliquam elit tempus. In hac habitasse platea dictumst. Nulla pharetra nisl vitae luctus interdum. Fusce quis elit vel leo vehicula pulvinar. Aenean iaculis justo sed ante venenatis convallis. Quisque ut quam vitae dui vestibulum tempor. Sed cursus tellus maximus, sollicitudin lectus et, sagittis dui. Curabitur eu massa eu purus suscipit tempor ut ac urna. Proin molestie quam in arcu pretium volutpat. Vestibulum at hendrerit est.")
    post.save!
  end
end

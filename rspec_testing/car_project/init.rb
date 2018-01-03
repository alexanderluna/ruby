require_relative('lib/car')
require_relative('lib/truck')

puts "\nDo you want a Car or a Truck ?\n"
choice = gets.chomp.downcase
choice = /car/.match(choice) ? 'Car' : 'Truck'

puts "\nWrite the specs for the #{choice} you want to build\n"

print "Make: "
make = gets.chomp

print "Year: "
year = gets.chomp

print "Color: "
color = gets.chomp

case choice
when 'Truck'
  vehicle = Truck.new(make: make, year: year, color: color)
else
  vehicle = Car.new(make: make, year: year, color: color)
end

puts "I understand you want to purchase: #{vehicle.full_name}"

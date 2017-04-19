def accelerate
  puts "Brum brum, the motor is going"
end

def horn
  puts "Boooom Boooom"
end

def lights(choice="HEAD LIGHTS")
  lights = choice
  puts "Turning on the #{lights}"
end

def mileage(miles_driven, gas_used)
  miles_driven/gas_used
end

trip_milage = mileage(400, 12)
puts "You got #{trip_milage} MPG on this trip"

lifetime_milage = mileage(15000, 500)
puts "You got #{lifetime_milage} MPG on this trip"

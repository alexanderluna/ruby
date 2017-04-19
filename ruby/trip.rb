def hotel_cost(days)
  return days * 140
end

def plane_ride_cost(city)
  if city == "Bremen"
    return 130
  elsif city == "Berlin"
    return 200
  elsif city == "Hamburg"
    return 180
  end
end

def rental_car_cost(days)
  cost = days * 40

  if days >= 7
    cost - 50
  elsif days >= 3
    cost - 20
  end

  return cost
end

def trip_cost(days, city)
  return hotel_cost(days) + plane_ride_cost(city) + rental_car_cost(days)
end

puts trip_cost(5, "Hamburg")

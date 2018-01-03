require_relative('Vehicle')

class Truck < Vehicle

  def full_name
    "a #{@color} #{@make} from #{@year}"
  end
end

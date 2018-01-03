require_relative('Vehicle')

class Car < Vehicle
  
  def full_name
    "a #{self.color} #{self.make} from #{self.year.to_s}"
  end
end

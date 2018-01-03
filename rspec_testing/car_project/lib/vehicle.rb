class Vehicle
  attr_accessor :make, :year, :color
  attr_reader :wheels
  attr_writer :colors

  def initialize(options={})
    self.make = options[:make] || 'Mercedes'
    self.year = (options[:year] || 2005).to_i
    self.color = options[:color] || 'black'
    @wheels = 4
  end

  def colors
    ['red', 'blue', 'green', 'black']
  end

  def full_name
    "a #{@color} #{@make} from #{@year}"
  end
end

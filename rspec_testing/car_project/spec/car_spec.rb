require 'car'

describe "Car" do

  describe "attributes" do

    it "allows reading and writing for :make" do
      car = Car.new
      car.make = "BMW"
      expect(car.make).to eq('BMW')
    end

    it "allows reading and writing for :year" do
      car = Car.new
      car.year = 2005
      expect(car.year).to eq(2005)
    end

    it "allows reading and writing for :color" do
      car = Car.new
      car.color = 'Blue'
      expect(car.color).to eq('Blue')
    end

    it "allows reading for wheels" do
      car = Car.new
      expect(car.wheels).to eq(4)
    end

  end

  describe ".colors" do

    it "returns an array of color names" do
      c = ['red', 'green', 'blue', 'black']
      expect(Car.colors).to match_array(c)
    end

  end

  describe "#full_name" do

    it "returns a string in the expected format" do
      @bmw = Car.new(make: "BMW", year: 2005, color: "Black")
      expect(@bmw.full_name).to eq("a Black BMW from 2005")
    end

    context "when initializing with no arguments" do
      it "returns a string using default values" do
        car = Car.new
        expect(car.full_name).to eq("a unknown Mercedes-Benz from 2007")
      end
    end

  end

end

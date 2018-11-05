class Animal

	attr_accessor :name
	attr_writer :color
	attr_reader :legs, :arms

	@@species = ['cat' 'dog', 'duck', 'cat']
	@@current_animals = []

	def self.species
		@@species
	end

	def self.species=(array=[])
		@@species = array
	end

	def self.current_animals
		@@current_animals		
	end

	def self.create_with_attributes(noise, color)
		animal = self.new(noise)
		animal.color = color
		return animal	
	end

	def initialize(noise, legs=4, arms=0)
		@noise = noise
		@legs = legs
		@arms = arms
		@@current_animals << self
		puts "A new animals has been instantiated."
	end


	def noise=(noise)
		@noise = noise
	end
		
	def noise
		@noise
	end

	def color
		"The color is #{@color}"	
	end
end


class Cow < Animal
	def color
	"The cow's color is #{@color}."
end
end

class Pig < Animal
	def noise 
		parent_noise = super
		return "Hello and also #{parent_noise}"
	end
end

Animal.species = ['frog', 'fish']

puts Animal.species.inspect

animal = Animal.new("Moo!", 4, 0)
animal.name = "Steve"
puts animal.name
animal.color = "black"
puts animal.color
puts animal.legs

puts animal.noise

animal2 = Animal.create_with_attributes("mee", "white")
animal2.noise = "mee"
puts animal2.noise
puts animal2.color

puts Animal.current_animals.inspect


maisi = Cow.create_with_attributes("muh", "yellow")
puts maisi.noise
puts animal.class
puts maisi.class
puts maisi.color

piggi = Pig.new("Oink")
puts piggi.noise 


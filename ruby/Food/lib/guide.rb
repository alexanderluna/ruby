require_relative 'restaurant'
require_relative './support/string_extend'

class Guide

	class Config
		@@actions = ['list', 'find', 'add', 'quit']

		def self.action; @@actions; end
	end


	def initialize(path=nil)
		#locate the restaurant text file
		Restaurant.filepath = path 
		#create if it doesn't exist
		if Restaurant.file_usable?
			puts "Restaurnat File found"
		elsif Restaurant.create_file
			puts "Created restaurant file"	
		#exist if create fails
		else 
			puts "Exiting\n\n"
			exit!
		end
	end


	def launch!
		introduction
		#action loop
		result = nil
		until result == :quit
			action, args = get_action
			result = do_action(action, args)
		end
		conclusion
	end


	def get_action
		action = nil
		# Keep asking for user input until we get a valid input
		until Guide::Config.action.include?(action)
			puts "Action: " + Guide::Config.action.join(", ") if action
			print "> "
			user_response = gets.chomp
			args = user_response.downcase.strip.split(' ')
			action = args.shift
		end
		return action, args
	end


	def do_action(action, args=[])
		case action
		when 'list'
			list(args)
		when 'find'
			keyword = args.shift
			find(keyword)
		when 'add'
			add
		when 'quit'
			return :quit
		else 
			puts "\nI don't know that command.\n"
		end
	end

	def list(args=[])
		sort_order = args.shift 
		sort_order = args.shift if sort_order == 'by'
		sort_order = "name" unless ['name', 'cuisine', 'price'].include?(sort_order)

		output_action_header("Listing Restaurants")

		restaurant = Restaurant.saved_restaurants
		restaurant.sort! do |r1, r2|
			case sort_order
			when 'name'
			r1.name.downcase <=> r2.name.downcase
			when 'cuisine'
				r1.cuisine.downcase <=> r2.cuisine.downcase
			when 'price'
				r1.price.to_i <=> r2.price.to_i
			end
		end
		output_restaurant_table(restaurant)
		puts "Sort using: 'list cusines' or 'list by cuisine'\n\n"
	end


	def find(keyword="")
		output_action_header("Find a Restaurant")
		if keyword
			restaurant = Restaurant.saved_restaurants
			found = restaurant.select do |rest| 
				 rest.name.downcase.include?(keyword.downcase) ||
				 rest.cuisine.downcase.include?(keyword) ||
				 rest.price.to_i <= keyword.to_i 
			end
			output_restaurant_table(found)
		else
			puts "\nFind what you want with a keyword\n\n"
			puts "Example: 'Find cafe', 'Find Bar', etc.\n\n"
		end
	end


	def add
		output_action_header("Add a Restaurant")
		restaurant = Restaurant.build_using_questions
		if restaurant.save
			puts "\nRestaurant added.\n\n"
		else 
			puts "\nSave error: Restaurant not added.\n\n"
		end
	end


	def introduction
		puts "\n\n<<<Welcome to the Food finder App>>>\n\n"
		puts "This app will help you find the food you want at the price you want it\n\n"
	end


	def conclusion
		puts "\n<<<Goodbye and enjoy your meal>>>\n\n\n"
	end

	private 

	def output_action_header(text)
		puts "\n#{text.upcase.center(50)}\n\n"
	end

	def output_restaurant_table(restaurant=[])
		print " " + "Name".ljust(30)
		print " " + "Cuisine".ljust(20)
		print " " + "Price".rjust(6) + "\n"
		puts "-" * 60

		restaurant.each do |rest|
			line = " " << rest.name.titleize.ljust(30)
			line << " " + rest.cuisine.titleize.ljust(20)
			line << " " + rest.formatted_price.rjust(6)
			puts line
		end

		puts "No listings found" if restaurant.empty?
		puts "-" * 60
	end 
end 
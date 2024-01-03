# Ruby is an OOP language and thus its important to understand how Classes work
# For this take a look at the following Car Inventory app which keeps track
# of various cars, their details and can be used to check the value of the
# inventory as well as insurance status.

# First import the date and CSV libraries
require 'date'

# Now define a Car class
class Car
    # create read method for the :model attribute
    attr_reader :model

    # create read and write methods for the :price attribute
    attr_accessor :price

    # initalize the class instance with attributes
    def initialize(model, price, warranty_exp_date)
        @model = model
        @price = price
        @warranty_exp_date = warranty_exp_date
    end

    def transfer_warranty(car)
        unless warranty_expired
            puts "Transfering warranty to #{car.model}"
    end

    # define a private method which can't be accessed outside this instance
    private

    def warranty_expired
        @warranty_exp_date - Date.today > 0
    end
end


# Create an Inventory class to track all the cars
class CarInventory

    # initialize an empty car array
    def initialize()
        @cars_in_stock = []
    end

    # add cars to the array from a CSV file
    def add_cars_from_csv(csv_file)
        CSV.foreach(csv_file, headers: true) do |row|
            @cars_in_stock << Car.new(
                row["Model"],
                row["Price"],
                row["Warranty Expiration Date"]
            )
        end
    end

    # return the total value of Car Inventory
    def total_value
        sum = 0
        @cars_in_stock.each { |car| sum += car.price }
        sum
    end
end


# create instance of car inventory
BremenCarInvetory = CarInventory.new

# parse command line arguments
ARGV.each do |csv_file|
    # $stderr outputs to the STDERR handle rather then STDOUT
    # if the user captures the output of the command, it will not show up
    $stderr.puts "Reading CSV file: #{csv_file}"
    BremenCarInvetory.add_cars_from_csv(csv_file)

# puts outputs to the STDOUT handel
# if the user captures the output of the command, it will show up
puts BremenCarInvetory.total_value

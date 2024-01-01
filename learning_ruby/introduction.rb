# Ruby is an [OOP] where all it's types are objects. You use [objects] to model
# real world concepts using [Classes] which then can be used to create several
# [instances] using a [constructor].

bwm = Car.new("bmw")


# Ruby is a pure OOP language. You access data and methods directly without
# basic types.

some_number = -5

Math.abs(some_number)
some_number.abs # Ruby style


# Functions and Methods in Ruby return the last expression if there is no
# explicit return statement.

def greet(name)
    # greeting = "Hello #{name}"
    # return greeting
    "hello #{name}"
end


# Arrays and Hashes are ways of grouping objects together.

random_things = [3.14, 'blue', 20]
random_things[0] # 3.14

capitals = {
    "spain" => "madrid",
    "germany" => "berlin",
    "france" => "paris"
}

capitals["spain"] # madrid


# Variables follow a naming convention based on scope and purpose.

local_variables
@instance_variables
@@class_variables
$global_variables
ClassNames
CONSTANT_VARIABLES


# Use Symbols to reference frequently used strings. They are immutable and
# faster to look up.

attack(:left)


# Like most programming languages you can use control structures.

if :north
    puts "Going north"
elsif :south
    puts "Going south"
else
    puts "Going west"
end


# Ruby has build-in support for regular expressions

"I'm going left".match?(/left|right/)
"I'm going left".sub(/left/, 'right')


# Code blocks are chunks of code you can pass to methods as a parameter.

3.times { puts "hello world" }

3.times do
    puts "hello world"
end

def greet
    yield # returns parameter
end

greet { puts "hello world"} 


# Command-Line arguments can be accessed through the global ARGV array.

count_numbers 1 2 3
ARGV # ["1", "2", "3"]

# frozen_string_literal: true

################################################################################
# Ruby is an [OOP] where all it's types are objects. You use [objects] to model
# real world concepts using [Classes] which then can be used to create several
# [instances] using a [constructor].
################################################################################

Car.new('bmw')


################################################################################
# Ruby is a pure [OOP] language. You access data and methods directly without
# basic types.
################################################################################

some_number = -5

Math.abs(some_number)
some_number.abs                         # Ruby style


################################################################################
# [Functions] and [Methods] in Ruby return the last expression if there is no
# explicit return statement.
################################################################################

def greet(name)
  # greeting = "Hello #{name}"
  # return greeting
  "hello #{name}"
end


################################################################################
# [Arrays] and [Hashes] are ways of grouping objects together. Hashes in
# particular are very fast and can have any object as an index.
################################################################################

random_things = ['one', 'two', 'three']
random_things = %w[one blue three]      # [one, two, three]
random_things = %i[one two three]       # [:one, :two, :three]

random_things[0]                        # one
random_things[-1]                       # three
random_things[0, 1]                     # [one, two]
random_things[0..2]                     # [one, two, three]

random_things.push('four')              # [one, two, three, four]
random_things.pop                       # four

capitals = {
  spain: {
    capital: 'madrid', languages: %w[spanish catalan euskera]
  },
  germany: {
    capital: 'berlin', languages: ['german']
  },
  france: {
    capital: 'paris', languages: ['french']
  }
}

capitals[:spain][:languages][1]         # catalan
capitals.dig(:spain, :languages, 1)     # catalan


################################################################################
# [Variables] follow a naming convention based on scope and purpose.
################################################################################

local_variables
@instance_variables
@@class_variables
$global_variables
ClassNames
CONSTANT_VARIABLES


################################################################################
# Use [Symbols] to reference frequently used strings. They are immutable and
# faster to look up.
################################################################################

attack(:left)

if :north
  puts 'Going north'
elsif :south
  puts 'Going south'
else
  puts 'Going west'
end


################################################################################
# Ruby has build-in support for [regular expressions]
################################################################################

"I'm going left".match?(/left|right/)
"I'm going left".sub(/left/, 'right')


################################################################################
# [Code blocks] are chunks of code you can pass to methods as a parameter and
# [yield] later or save in a variable. They are enclosed between braces or the
# keywords [do] and [end]. Parameters to a block are always local to a block
# even if a variable with the same name exists outside the block.
################################################################################

count = 0

3.times do |count|
  puts "#{count}: Hello World"          # count is local and not 0
end

['hello', 'world'].each { |word| puts word }
['hello', 'world'].each { puts _1 }     # short hand syntax

def fibonacci_up_to(max)
  first, second = 1, 1
  while first <= max
    yield first                         # executes: { |fib| print fib, " " }
    first, second = second, first + second
  end
end

fibonacci_up_to(1000) { |fib| print fib, " " }


################################################################################
# Parameter with an [&] prefix are turned into a Proc object and be used to
# implement callbacks, dispatch tables or anonymous methods. A short hand syntax
# for this, is the [lambda] keyword or [stabby lambda ->]
################################################################################

def execute_later(&block)
  block
end

personal_block = execute_later { |param| puts "Printing: #{param}" }
personal_block = lambda { |param| puts "Printing: #{param}" }
personal_block = -> (param) { puts "Printing: #{param}" }

personal_block.call(4)                  # Printing: 4
personal_block.call('alexander')        # Printing: alexander

def count_up                            # using block to make a closure
  value = 1
  -> { value += value }
end

counter = count_up
counter.call                            # 2
counter.call                            # 4


################################################################################
# [Iterators] are methods which invoke code blocks repeatedly. Ruby refers to
# Iterators as [enumator] as well. You can use tap to tap into the method
# pipeline (chain).
################################################################################

puts [1, 2, 3, 2, 1]
  .tally
  .tap { |result| puts result }         # {1=>2, 2=>2, 3=>1}
  .sort_by { |_val, num| num }          # [[3, 1], [1, 2], [2, 2]]
  .reverse                              # [[2, 2], [1, 2], [3, 1]]

[1, 2, 3].reduce(0) { |sum, element| sum + element }
[1, 2, 3].reduce { |sum, element| sum + element }
[1, 2, 3].reduce { _1 + _2 }
[1, 2, 3].reduce(:+)
[1, 2, 3].sum


################################################################################
# Ruby has a build in [Enumerator] object which allows the implementation of
# external iterators and turns executable code into an object.
################################################################################

shopping_list = ['bread', 'milk', 'butter', 'ham']

shopping_list_enum = shopping_list.to_enum(:reverse_each)
shopping_list_enum.next                 # ham
shopping_list_enum.next                 # butter

shopping_list_order = []
shopping_list.each_with_index { |item, i| shopping_list_order << [item, i] }
shopping_list_order                     # [["bread", 0], ["milk", 1]...]


################################################################################
# [Command-Line arguments] can be accessed through the global ARGV array.
################################################################################

count_numbers 1 2 3
ARGV                                     # ["1", "2", "3"]

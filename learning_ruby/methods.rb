# frozen_string_literal: true

################################################################################
# In Ruby a methods contain normal ruby expressions. Indentation is not
# mandatory but considered good style. Definining the same method twice will
# not raise an error but overwrite it. The last expression is returned by
# default.
################################################################################

def welcome
  puts 'Hello World!'
end

def hello = puts 'こんにちは世界史'

################################################################################
# Use snake case for symbols, methods and variables. Methods may end in a ?/!/=
# - ?: the method returns a boolean
# - !: dangerous methods which modify the receiver
# - =: methods that can appear on the left side of the assignment
################################################################################

1.instance_of?(Integer)

greeting = 'hello world'
greeting.chop!	# permanently changed to 'hello worl'

def price_in_cents=(cents)
  @price = cents / 100.0
end

price_in_cents = 150

################################################################################
# Binary operators [+, -, *, /] are in fact methods. This enables you to
# overwrite them in your classes if you want to.
################################################################################

class String
  alias old_concat +

  def +(other)
    old_concat(' new ').concat(other)
  end
end

puts 'hello' + 'world' # hello new world

################################################################################
# Ruby allows to define methods for a specific object adding it to the class
# itself.
################################################################################

class Computer
  def self.operating_system
    'Linux'
  end
end

mac = Computer.new
def mac.operating_system = 'macos'

Computer.operating_system

################################################################################
# Methods can have many parameters and you can add default values to them. You
# can also use a variable length of parameters with an asterisk or use keyword
# parameters using a hash.
################################################################################

def longest_word
  words = %w[apple banana pear]

  words.inject do |memo, word|
    memo.length > word.length ? memo : word
  end
end

puts longest_word # banana

def longest_word(first, second, third)
  [first, second, third].inject do |memo, word|
    memo.length > word.length ? memo : word
  end
end

puts longest_word('apple', 'banana', 'pear') # banana

def longest_word(first = 'apple', second = 'banana', third = 'pear')
  [first, second, third].inject do |memo, word|
    memo.length > word.length ? memo : word
  end
end

puts longest_word # banana

def longest_word(*words)
  words.inject do |memo, word|
    memo.length > word.length ? memo : word
  end
end

puts longest_word(%w[apple banana pear]) # banana

def longest_word(words:)
  words.inject do |memo, word|
    memo.length > word.length ? memo : word
  end
end

puts longest_word(words: %w[apple banana pear]) # banana

################################################################################
# Methods can receive blocks as parameters and call them using [yield]. When the
# block parameter is prefixed with an ampersand, Ruby will automatically
# convert it to a [Proc] so you can call later when you want.
################################################################################

class Calculator
  def initialize(value, &block)
    @value = value
    @block = block
  end

  def get_value(amount)
    @block.call(amount, @value)
  end
end

AddCalculator = Calculator.new(5) { |amount, value| amount + value }
AddCalculator.get_value(10) # 15

################################################################################
# [Private] methods allow you to call methods only with the current object
################################################################################

class Invoice
  def initialize(order)
    @order = order
  end

  def print
    "The total is: #{@oder.value + calculate_tax} (VAT included)"
  end

  private

  def calculate_tax
    18.4 + @oder.tax
  end
end

################################################################################
# The ampersand can be used to pass a block as a parameter and convert it to
# Proc. The reverse is also true. A Proc can be passed to a method and
# converted to a block.
################################################################################

%w[hello world].map { |word| word.upcase } # passing a block as argument
%w[hello world].map(&:upcase) #  passing a proc as argument

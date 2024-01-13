# frozen_string_literal: true

################################################################################
# Ruby offers different options to share functionality. The easiest one being
# [Inheritance]. In fact all objects in Ruby follow a chain of Inheritances:
#   BasicObject -> Object -> YourOwnClass
################################################################################

class Animal
  def initialize(legs, sound)
    @legs = legs
    @sound = sound
  end

  def move = raise NotImplentedError
end

class Dog < Animal
  def move
    "Running with #{@legs} legs #{@sound}"
  end
end

class Duck < Animal
  def move
    "Running with #{@legs} legs #{@sound}"
  end
end

rex = Dog.new(4, 'wau')
enton = Duck.new(2, 'quack')

puts rex.move # Running with 4 legs wau
puts enton.move # Running with 2 legs quack

################################################################################
# While Inheritance is useful it creates deep coupling in your code. Another
# way of reusing code and sharing functionality is via [Modules] which allow
# you to group methods together and provides a namespace to avoid name clashes.
################################################################################

module Trigonometry
  PI = 3.14

  def self.sin(_angle) = 'Opposite / Hypotenuse'

  def self.cos(_angle) = 'Adjecent / Hypotenuse'

  def self.tan(_angle) = 'Opposite / Adjecent'
end

module Physics
  def sin = 'Generating a sine wave'
end

require_relative 'trigonometry'
require_relative 'physics'

Trigonometry.sin(30)
Physics.sin

################################################################################
# Modules group methods together. This is can be used to extend classes without
# creating deep coupling. [Mixins] are modules which can be included in a class
# and are commonly used for composition to reduce Inheritance.
################################################################################

module Debug
  def log
    "#{self.class.name} (id: #{object_id}): #{sound}"
  end
end

class Duck < Animal
  include Debug

  attr_reader :sound
end

enton.log # Duck (id: 105180): quack

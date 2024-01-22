# frozen_string_literal: true

################################################################################
# In Ruby, everything that can return something does so which means that almost
# anything in ruby is an expression. This makes it easy to chain statements.
# Even if/else statement are expressions in Ruby.
################################################################################

%w[hello world hallo welt].sort.map(&:upcase)

require 'date'

today = DateTime.new
day = case today.wday
      when 1..5
        'business day'
      else
        'weekend'
      end

puts "Today is a #{day}"

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
# Assignment works by refering the [lvalue] (left value) to the [rvalue]
# (right value). This means you can chain assignment, assign in parallel, splat
# and even nest assignment.
################################################################################

a = 1
b = 2
b, a = a, b # swap values

name1, name2, name3, *house_numbers = 'Alexander', 'Bob', 'Charles', *(5..7)
puts name1, name2, name3, " live at #{house_numbers}" # splat house numbers

one, (two, three), four = 1,[2,3],4 # nested a=1, b=2, c=3, d=4

################################################################################
# When you want to access values at runtime which you don't know if they exist
# you can use the [safe navigation] operator.
################################################################################

names = { germany: 'alexander', france: 'jean', spain: 'juan' }

germany = names[:germany]
germany ? germany.capitalize : nil
names[:germany] && names[:germany].capitalize
names[:germany]&.capitalize # safe navigation

################################################################################
# Previously we saw how to access data from objects. You can access data from
# objects using [pattern matching] and [variable binding] as well.
################################################################################

capitals = {
  spain: { capital: 'madrid', languages: %w[spanish catalan euskera] },
  germany: { capital: 'berlin', languages: ['german'] },
  france: { capital: 'paris', languages: ['french'] }
}

capitals in spain: {languages: [*]} # true

case capitals
in spain: {languages:}
  "In spain they speak #{languages.join(', ')}"
in germany: {languages:}
  "In germany they speak #{languages.join(', ')}"
in france: {languages:}
  "In france they speak #{languages.join(', ')}"
else
  'no languages found'
end

# "In spain they speak spanish, catalan, euskera"

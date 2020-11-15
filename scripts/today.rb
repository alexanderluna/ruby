#!/usr/bin/env ruby

# Add or Subtract an X amount of days from the current date
# Print the date 15 days ago
# ruby today.rb - 15

require 'date'

def main()
    case ARGV.length
    when 0
        puts Date.today
    when 2
        puts eval "Date.today" + ARGV.join()
    else
        puts "Missing Arguments (given #{ARGV.length}, expected 2)"
        puts "Example 1: today - 15"
        puts "Example 2: today + 64"
        exit        
    end
end


if __FILE__ == $0
    main()
end
require 'benchmark'
require 'prime'
require './my_prime'

iterations = 100_000

ruby_prime = []
my_prime = []

Benchmark.bm do |bm|
  bm.report do
    iterations.times do |i|
      ruby_prime.push(i) if Prime.prime?(i)
    end
  end

  bm.report do
    iterations.times do |i|
      my_prime.push(i) if isprime?(i)
    end
  end
end
























ruby_prime = []
my_prime = []

t = Time.now
10000000.times do |i|
  ruby_prime.push(i) if Prime.prime?(i)
end
puts "(Prime) Time to complete (100k): #{Time.now - t}"
puts "(Prime) #{ruby_prime.count} prime numbers found\n\n"


b = Time.now
10000000.times do |i|
  my_prime.push(i) if i.isprime?
end


puts "(isprime?) Time to complete (100k): #{Time.now - b}"
puts "(isprime?) #{my_prime.count} prime numbers found\n"

puts my_prime - ruby_prime

puts " "
puts " "

puts "**************************"
puts "*Testing Ruby Prime: TRUE*"
puts "**************************"
p Prime.prime?(2)
p Prime.prime?(3)
p Prime.prime?(2**31-1)

puts ""
puts "***************************"
puts "*Testing Ruby Prime: FALSE*"
puts "***************************"
p Prime.prime?(4)
p Prime.prime?(15)
p Prime.prime?(2**32-1)
p Prime.prime?( (2**17-1)*(2**19-1) )


puts " "
puts " "

puts "**************************"
puts "*Testing My Prime: TRUE  *"
puts "**************************"
p 2.isprime?
p 3.isprime?
p (2**31-1).isprime?

puts ""
puts "***************************"
puts "*Testing My Prime: FALSE  *"
puts "***************************"
p (4).isprime?
p (15).isprime?
p (2**32-1).isprime?
p ( (2**17-1)*(2**19-1) ).isprime?

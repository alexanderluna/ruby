require('prime')
require('./my_prime')

# def prime?(n)
#   return n >= 2 if n <= 3
#   return true if n == 5
#   return false unless 30.gcd(n) == 1
#   (7..Integer.sqrt(n)).step(30) do |p|
#     return false if
#       n%(p)    == 0 || n%(p+4)  == 0 || n%(p+6)  == 0 || n%(p+10) == 0 ||
#       n%(p+12) == 0 || n%(p+16) == 0 || n%(p+22) == 0 || n%(p+24) == 0
#   end
#   true
# end



ruby_prime = []
my_prime = []

t = Time.now
1000000.times do |i|
  ruby_prime.push(i) if Prime.prime?(i)
end
puts "(Prime) Time to complete (1 mil): #{Time.now - t}"
puts "(Prime) #{ruby_prime.count} prime numbers found\n\n"


t = Time.now
1000000.times do |i|
  my_prime.push(i) if isprime?(i)
end
puts "(isprime?) Time to complete (1 mil): #{Time.now - t}"
puts "(isprime?) #{my_prime.count} prime numbers found\n"

puts my_prime - ruby_prime

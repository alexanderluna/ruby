
def largest_prime_factor(number, d=2, factors=[])
  #t = Time.now
  while(number > 1)
    while(number % d == 0)
      factors.push(d)
      number = number/d
    end
    d = d + 1
  end
  factors
  #(2..7000).reject {|n| (number % n) > 0}
  #puts "Time to complete: #{Time.now - t}"
end

p largest_prime_factor(600851475143).max

#p (2..7000).reject {|n| (13195 % n) > 0}

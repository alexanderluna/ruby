# find the sum of all multiples of 3 and 5 up to 1000
(1...1000).to_a.map {|n| (n % 3 == 0 || n % 5 == 0) ? n : 0}.reduce(0, :+)

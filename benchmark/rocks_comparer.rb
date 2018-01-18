require 'benchmark'

def rock_judger(rocks_arr)
  if rocks_arr.length <= 2  # the base case
    a = rocks_arr[0]
    b = rocks_arr[-1]
  else
    a = rock_judger(rocks_arr.slice!(0,rocks_arr.length/2))
    b = rock_judger(rocks_arr)
  end

  return a > b ? a : b
end

def other_rock_judger(rocks)
  max_rock = 0

  rocks.each do |rock|
    max_rock = rock if max_rock < rock
  end
  max_rock
end


rocks = 10_000_000.times.map{rand(1000) + 1}


Benchmark.bm do |bm|
  bm.report('other_rock_judger') do
    other_rock_judger(rocks)
  end

  bm.report('rock_judger') do
    rock_judger(rocks)
  end
end

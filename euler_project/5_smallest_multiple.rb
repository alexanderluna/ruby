def smallest_multiple
  large = 0
  short = (1..20).to_a
  i = 0
  temp_array = []

  while temp_array.count < short.count
    large += 2520
    temp_array = []
    while (i < short.count && large % short[i] == 0)
      temp_array.push(large)
      i += 1
    end
    i = 0
  end
  temp_array
end

p smallest_multiple.max

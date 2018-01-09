# 1**2 = 1    1  + 3  = 4
# 2**2 = 4    4  + 5  = 9
# 3**2 = 9    9  + 7  = 16
# 4**2 = 16   16 + 9  = 25
# 5**2 = 25   25 + 11 = 36
# 6**2 = 36   36 + 13 = 49
# 7**2 = 49   49 + 15 = 64
# 8**2 = 64   64 + 17 = 81
# 9**2 = 81   81 + 19 = 100
# 10**2 = 100
#
# 3
# 5
# 7
# 9
# 11
# 13
# 15
# 17
# 19

def sum_of_squares(num, power_and_sum=[1], stepper=3)
  sum_and_power = (1..num).reduce(0,:+) ** 2
  for i in (1..num-1)
    power_and_sum[i] = power_and_sum[i-1] + stepper
    stepper += 2
  end
  sum_and_power - power_and_sum.reduce(0,:+)
end

p sum_of_squares(100)

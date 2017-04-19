def alpha(arr, rev=false)
  if rev == true
    arr.reverse!
  else
    arr.sort!
  end
end

numbers = [1,2,3,4,5]
puts alpha(numbers)

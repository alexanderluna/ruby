def fib(n=3, a=[0, 1, 1])
  while(a[n-1] + a[n-2] < 4000000)
    a[n] = a[n-1] + a[n-2]
    n += 1
  end; a
end

p fib().map {|i| i.even? ? i : 0}.reduce(0, :+)

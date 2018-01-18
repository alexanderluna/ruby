class Integer
  def isprime?
    return false if self <= 1
    return true  if self == 2 || self == 3
    return false if self % 2 == 0 || self % 3 == 0
    i = 5
    w = 2
    while i * i <= self
        return false if self % i == 0
        i += w
        w = 6 - w
    end
    true
  end
end


class Prime
  def isprime?(n)
    return false if n <= 1
    return true  if n == 2 || n == 3
    return false if n % 2 == 0 || n % 3 == 0
    i = 5
    w = 2
    while i * i <= n
      return false if n % i == 0
      i += w
      w = 6 - w
    end
    true
  end
end

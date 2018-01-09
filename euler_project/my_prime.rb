class Integer
  def isprime?
      return false if self == 1
      return true  if self == 2 || self == 3
      #return true if n == 3
      return false if self % 2 == 0 || self % 3 == 0
      #return false if n % 3 == 0

      i = 5
      w = 2

      while i * i <= self
          return false if self % i == 0
          i += w
          w = 6 - w
      end

      return true
  end
end

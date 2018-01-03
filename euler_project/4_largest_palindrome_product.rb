class Integer
  def palindome?
    self.to_s.split('').reverse.join('') == self.to_s ? true : false
  end
end

def palindome_product
  t = Time.now
  largest = 0
  for i in (900..999)
    for j in (900..999)
      product = (i * j)
      largest = product if (product.palindome? && largest < product)
    end
  end
  p "It took (s): #{Time.now - t}"
  p "The number is #{largest}"
end

palindome_product

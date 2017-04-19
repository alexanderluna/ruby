def welcome (name="World")
	puts "Hello #{name}!"
end

def add_and_subtract (n1=0, n2=0)
	add = n1 + n2
	sub = n2 - n1

	return[add, sub]
end

def longes_word (words=[])
	longes_word = words.inject do |memo, word|
		memo.length > word.length ? memo : word
	end
	return longes_word
end

def over_five?(value=nil)
	return "Exactly 5" if value.to_i == 5
	if value.to_i > 5
		return "Over 5"
	else 
		return "Under 5"
	end
end

welcome("Alexander")

return_value = welcome("John")
puts return_value

result = add_and_subtract(2, 2)
puts result[0]
puts result[1]

fruits = ["apple", "banana", "pear"]
puts longes_word(fruits).length

puts over_five?(5)

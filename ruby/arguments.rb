def welcome (name)
	puts "Hello #{name}!"
end

def add (n1, n2)
	puts n1 + n2
end


#underscore between words like variable names
	

def longes_word (words)

	longes_word = words.inject do |memo, word|
		memo.length > word.length ? memo : word
	end
	puts longes_word
end


#method names can have question marks in them 
#useful for tests and booleans

def over_five?(value)

	puts value > 5 ? 'Over 5' : 'Not over 5'
	
end


welcome("Alexander")

add(2234928349, 2938428934)

fruits = ["apple", "banana", "pear"]

longes_word(fruits)


over_five?(10)

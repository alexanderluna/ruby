def welcome
	puts "Hello World!"
end

def add
	puts 1 + 1
end


#underscore between words like variable names

def longes_word
	words = ["apple", "banana", "pear"]

	longes_word = words.inject do |memo, word|
		memo.length > word.length ? memo : word
	end
	puts longes_word
end


#method names can have question marks in them 
#useful for tests and booleans

def over_five?

	value  = 5

	puts value > 5 ? 'Over 5' : 'Not over 5'
	
end

welcome
longes_word
add
over_five?

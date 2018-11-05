def welcome (name="World")
	puts "Hello #{name}!"
end


def add (n1=0, n2=0)
	puts n1 + n2
end


def longes_word (words=[])
	longes_word = words.inject do |memo, word|
		memo.length > word.length ? memo : word
	end
	puts longes_word
end



def over_five?(value=nil)
	puts value > 5 ? 'Over 5' : 'Not over 5'
end


welcome("Alexander")

welcome

add(2234928349, 2938428934)

add(2)

fruits = ["apple", "banana", "pear"]

longes_word(fruits)

longes_word

over_five?(10)

over_five

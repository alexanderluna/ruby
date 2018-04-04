class Hamming
	def self.compute(one, two)
		return 0 if one.empty? or two.empty? or one === two
		counter = 0
		one.split.each_with_index do |i, char|
			counter += 1 if one[i] != two[i]
		end
		counter
	end
end

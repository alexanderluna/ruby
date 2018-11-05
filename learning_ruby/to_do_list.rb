class ToDoList

	include Enumerable
	attr_accessor :items

	def initialize
		@items = []
	end

	def each
		@items.each {|item| yield item}
	end
end
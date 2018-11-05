file = File.new('test.txt', 'w')
file.puts "Ruby"
file.print "Programming\n"
file.write "is "
file << "fun"
file.close

File.open('test.txt', 'r') do |file|
	while line = file.gets
		puts "** " + line.chomp.reverse + " **"
	end	
end

File.open('test.txt', 'r') do |file|
	file.each_line {|line| puts line.upcase}
end
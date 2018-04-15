def list_and(option={})
	base_name = ARGV[0]
	index = ARGV[1].to_i || 0
	Dir.open(Dir.pwd).sort.each do |filename|
		next if File.directory?(filename) or filename == ".DS_Store"
		index += 1
		ep = index < 10 ? "0#{index}" : index.to_s
		extention = File.extname(filename)
		File.rename(filename, base_name + ep + extention) if option[:rename]
		puts "File: #{filename} \tRenamed: #{base_name + ep + extention}"
	end
end

puts "***** CHECK THE OUPUT *****\n"
list_and(sort: true)
print "\nDo you want to rename the files ? (y/n): "
if STDIN.gets.chomp.strip.downcase == "y"
	list_and(rename: true)
	abort("Done renaming files")
else
	abort("Nothing to do here...")
end

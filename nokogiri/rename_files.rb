#!/usr/bin/ruby
abort("Missing base name argument") if ARGV[0].nil?

def list_and(option={})
	base_name, index = ARGV[0], ARGV[1].to_i || 0
	Dir.open(Dir.pwd).sort.each do |filename|
		next if File.directory?(filename) or filename == ".DS_Store"
		new_name = base_name + index.to_s.rjust(2, '0') + File.extname(filename)
		File.rename(filename, new_name) if option[:rename]
		puts "File: #{filename} \tRenamed: #{new_name}"
		index += 1
	end
end

list_and(sort: true)
print "\nDo you want to rename the files ? (y/n): "
if STDIN.gets.chomp.strip.downcase == "y"
	list_and(rename: true)
	abort("Done renaming files")
end

abort("Nothing to do here...")

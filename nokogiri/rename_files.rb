base_name = ARGV[0]
index = 0
my_dir = Dir.open(Dir.pwd).sort_by{|f| File.mtime(f) }
my_dir.sort.each do |filename|
		next if File.directory?(filename) or filename == ".DS_Store"
		index += 1
		ep = index < 10 ? "0#{index}" : "#{index}"
		extention = File.extname(filename)
		File.rename(filename, base_name + ep + extention)
		puts "File: #{filename} \tRenamed: #{base_name + ep + extention}"
end

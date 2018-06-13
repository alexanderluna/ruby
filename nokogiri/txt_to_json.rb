require 'json'
file_name = ARGV[0]

abort "Missing argument file name" unless file_name

tmp_file = File.open(file_name)

file_lines = []
tmp_file.each_line do |line|
  next unless line.include?('TEXT')
  remove_beginning = line.split('"')[1]
  parsed_line = remove_beginning.split('\\n\\n')
  # parsed_line => ['verse text', 'verse number']
  file_lines.push(parsed_line)
end

tmp_hash = {}
file_lines.each_with_index do |line, index|
  spanish_hash = {'verse': line[0], 'book': line[1]}
  english_hash = {'verse': '', 'book': ''}
  tmp_hash[index] = {'spanish': spanish_hash, 'english': english_hash}
end


File.open('verses.json', 'w') do |f|
  f.write(tmp_hash.to_json)
end

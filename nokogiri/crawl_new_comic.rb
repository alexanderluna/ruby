require 'mechanize'
require 'rmagick'

main_url = ARGV[0]
name = ARGV[1]

abort("Missing Argument URL or NAME") unless main_url and name

puts "=> Loading Chapters"
system("phantomjs ~/.my_scripts/crawl_site.js #{main_url} > #{name}.txt")

chapter_list = File.open("#{name}.txt").to_a.reverse
chapter_list.each_with_index do |link, index|
  puts "=> Downloading Images\n#{link}"
  tmp_file = index.to_s + ".txt"
  system("phantomjs ~/.my_scripts/loadsite.js #{link} #{tmp_file}")

  chapter = File.read(tmp_file).split(',')
  chapter.each_with_index do |image, i|
    agent = Mechanize.new
    image_name = i.to_s.rjust(3, '0') + File.extname(image)
    agent.get(image).save("#{index}/#{image_name}")
    puts "=> Creating PDF"
    files = Dir.open(index.to_s).sort.map { |file| "#{index}/#{file}"}
    pdf = Magick::ImageList.new(*files)
    pdf.write(name + index.to_s.rjust(3, "0") + ".pdf")
  end
  puts "=> Removing tmp files and folder"
  system("rm -r #{index}")
  system("rm #{tmp_file}")
end

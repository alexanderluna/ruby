require 'mechanize'
require 'rmagick'
require 'fileutils'

main_url = ARGV[0]
name = ARGV[1] + ".txt"
start = ARGV[2].to_i || false
fetch_chapters = "phantomjs ~/.my_scripts/crawl_site.js"
fetch_images = "phantomjs ~/.my_scripts/loadsite.js"

abort("Missing Argument URL or NAME") unless main_url and name

def save_img(folder, name, img)
  sleep 5
  print "."
  begin
    tries ||= 0
    agent = Mechanize.new
    img_name = name.to_s.rjust(3, '0') + File.extname(img)
    agent.get(img).save("#{folder}/#{img_name}")
  rescue
    retry if (tries += 1) < 5
  end
end

def create_pdf_from_folder(folder)
  puts "\n=> Creating PDF\n\n"
  files = Dir.open(folder).sort.map { |f| "#{folder}/#{f}" if f.match('[0-9]') }
  pdf = Magick::ImageList.new(*files.compact!)
  pdf.write(folder.rjust(3, "0") + ".pdf")
end

puts "=> Loading Chapters"
system("#{fetch_chapters} #{main_url} > #{name}")

chapter_list = File.open(name).to_a.reverse
chapter_list.each_with_index do |link, index|
  next if start and index < start
  tmp_file = index.to_s + ".txt"
  puts "=> Downloading Chapter: #{index}\n#{link}"
  system("#{fetch_images} #{link.chomp} #{tmp_file}")

  img_list = File.read(tmp_file).split(',')
  img_list.each_with_index { |img, i| save_img(index, i, img) }

  create_pdf_from_folder(index.to_s)
  FileUtils.remove_dir(index.to_s)
  File.delete(tmp_file)
end

File.delete(name)
abort("=> Finished Download")

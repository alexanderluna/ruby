require 'fileutils'
require 'pathname'
require_relative 'helper'

main_url = ARGV[0]
name = ARGV[1] + ".txt"
start = ARGV[2].to_i || false
fetch_chapters = "phantomjs ~/.my_scripts/crawl_site.js"
fetch_images = "phantomjs ~/.my_scripts/loadsite.js"

abort("Missing Argument URL or NAME") unless main_url and name

puts "=> Loading Chapters"
unless Pathname.new(name).exist?
  system("#{fetch_chapters} #{main_url} > #{name}")
end

chapter_list = File.open(name).to_a.reverse
chapter_list.each_with_index do |link, index|
  next if start and index < start
  tmp_file = index.to_s + ".txt"
  puts "=> Downloading Chapter: #{index}\n#{link}"
  unless Pathname.new(tmp_file).exist?
    system("#{fetch_images} #{link.chomp} #{tmp_file}")
  end
  img_list = File.read(tmp_file).split(',')
  Helper.download_images_to_folder(img_list, folder: index)
  Helper.create_pdf_from_dir(index.to_s)
  FileUtils.remove_dir(index.to_s)
  File.delete(tmp_file)
end

File.delete(name)
abort("=> Finished Download")

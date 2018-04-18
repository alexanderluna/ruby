require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'mechanize'
require 'rmagick'

main_url = ARGV[0]
folder = ARGV[1]
agent = Mechanize.new

abort("Missing arguments: I need a link and a folder name") unless main_url && folder

image_links = []
images_downloaded = 0
image_list = []

Nokogiri::HTML(open(main_url)).xpath('//a/@href').each do |url|
  puts url
  Nokogiri::HTML(open(url)).xpath("//img/@src").each do |src|
      uri = URI.join( url, src ).to_s
      agent.get(src).save "#{folder}/#{File.basename(uri)}"
      image_list.push("#{folder}/#{File.basename(uri)}")
  end
end

pdf = Magick::ImageList.new(*image_list)
pdf.write("#{folder}.pdf")
system("rm -r #{folder}")

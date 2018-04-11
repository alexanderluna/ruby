require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'mechanize'

series = 'http://kissmanga.com/Manga/Yandere-Kanojo'
phantom_script = '/Users/alexander/Desktop/javascript_box/phantomjs/loadsite.js'

# system("phantomjs #{phantom_script} > output.txt")
Nokogiri::HTML(open(series)).xpath('//td/a/@href').each do |volume|
	puts volume
end

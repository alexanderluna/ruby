require "mechanize"
require "nokogiri"
require "open-uri"
require 'webdrivers'
require "watir"

target = "http://kissmanga.com/Manga/Karakai-Jouzu-no-Takagi-san/Vol-004-Ch-027--Cell-Phone?id=270003"
browser = Watir::Browser.new :chrome
browser.goto(target)

sleep 6

doc = Nokogiri::HTML(browser.html)
puts doc.xpath("//script")[20]

# puts doc.at('var lstImages = new Array();').text
# puts browser.html

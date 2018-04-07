require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'net/http'
require 'uri'

base = 'https://s.to'
base_url = 'https://s.to/serie/stream/detektiv-conan/staffel-11'
episode_list = []

puts "***** READING SITE *****"
Nokogiri::HTML(open(base_url)).xpath('//tbody/tr/td/a/@href').each do |link|
	episode_list.push(base + link) unless episode_list.include?(base + link)
end
puts "Found: #{episode_list.count} episodes"

puts "***** GETTING REDIRECT LINKS *****"
episode_list.each_with_index do |episode, index|
	begin
		link = base + Nokogiri::HTML(open(episode)).css("div.hosterSiteVideo ul a")[0]['href']
	rescue NoMethodError
		puts "No link for episode #{index + 1}"
		link = nil
	end
	episode_list[index] = link
end

episode_list.compact!
episode_list.each {|ep| puts ep}

puts "***** GETTING VIDEO LINKS *****"
episode_list.each_with_index do |video, index|
	puts Net::HTTP.get_response(URI(video))
	# puts res['location']
end

episode_list.each {|ep| puts ep}

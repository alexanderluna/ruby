require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'mechanize'

main_url = ARGV[0]
folder = ARGV[1]
agent = Mechanize.new

Nokogiri::HTML(open(main_url)).xpath('//a/@href').each do |url|
  puts url
  Nokogiri::HTML(open(url)).xpath("//img/@src").each do |src|
      uri = URI.join( url, src ).to_s
      agent.get(src).save "#{folder}/#{File.basename(uri)}"
  end
end

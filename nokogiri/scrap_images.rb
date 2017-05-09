require 'nokogiri'
require 'httparty'
require 'open-uri'

main_url = ARGV[0]

Nokogiri::HTML(open(main_url)).xpath('//a/@href').each do |url|
    puts url
    Nokogiri::HTML(open(url)).xpath("//img/@src").each do |src|
        uri = URI.join( url, src ).to_s # make absolute uri
        File.open(File.basename(uri),'wb'){ |f| f.write(open(uri).read) }
    end
end

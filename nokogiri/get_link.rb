require 'nokogiri'
require 'httparty'

@url = "https://www.facebook.com"
page = HTTParty.get(@url)
doc = Nokogiri::HTML(page)
['h1','h2','h3','a'].each do |tag|
  doc.xpath("//#{tag}").each do |cont|
    if (tag == 'a') then
      puts cont['href']
    else
      puts cont
    end
  end
end

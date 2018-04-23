#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'rmagick'

main_url = ARGV[0]
start = ARGV[1].to_i || false
name = main_url.split('/')[4]
chapter_list = []

abort("Missing arguments: I need a link") unless main_url

Nokogiri::HTML(open(main_url)).css('.color_0077').each { |elem| chapter_list.push(elem['href'].to_s) }

chapter_list.map! { |i| "http:" + i if i.match?(name) }.compact!
chapter_list.reverse!.pop

def fetch_chapter(chapter_index, chapter)
  images, agent = [], Mechanize.new
  Nokogiri::HTML(open(chapter)).css('select.wid60 option').each { |page| images.push(page['value']) }
  images.uniq!.map! { |i| "http:#{i}" }
  images.each_with_index do |img, index|
    Nokogiri::HTML(open(img)).css("img#image").each do |src|
      print "."
      agent.get(src['src']).save("#{chapter_index}/#{index}.jpg")
    end
  end
end

chapter_list.each_with_index do |chapter, index|
  next if start and index < start
  begin
    tries ||= 0
    puts "\n=> Fetching Chapter #{index}\n#{chapter}"
    fetch_chapter(index, chapter)
  rescue
    system("rm -r #{index}")
    retry if (tries += 1) < 5
  end

  files = Dir.open(index.to_s).sort.map { |n| "#{index}/#{n}" if n.match?('[0-9]') }.compact
  pdf = Magick::ImageList.new(*files)
  pdf.write(name + index.to_s.rjust(2, "0") + ".pdf")
  system("rm -r #{index}")
end

abort("\n***** DONE DOWNLOADING *****")

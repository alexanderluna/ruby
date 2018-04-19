#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'rmagick'

main_url = ARGV[0]
folder = ARGV[1]
start = ARGV[2].to_i || false
name = main_url.split('/')[4]
chapter_list = []

abort("Missing arguments: I need a link and a folder name") unless main_url && folder

Nokogiri::HTML(open(main_url)).css('.color_0077').each { |elem| chapter_list.push(elem['href'].to_s) }

chapter_list.reject! { |i| !i.match?(name) }
chapter_list.map! { |i| "http:" + i }
chapter_list.reverse!.pop

def fetch_chapter(chapter_index, chapter)
  images, files, agent = [], [], Mechanize.new
  Nokogiri::HTML(open(chapter)).css('select.wid60 option').each { |page| images.push(page['value']) }

  images.uniq!.map! { |i| "http:#{i}" }
  images.each_with_index do |img, index|
    Nokogiri::HTML(open(img)).css("img#image").each do |src|
      print "."
      agent.get(src['src']).save("#{chapter_index}/#{index}.jpg")
      files.push("#{chapter_index}/#{index}.jpg")
    end
  end
  return files
end

chapter_list.each_with_index do |chapter, chapter_index|
  next if start and chapter_index < start
  begin
    tries ||= 0
    puts "\n***** Fetching Chapter #{chapter_index} *****\n#{chapter}"
    file_list = fetch_chapter(chapter_index, chapter)
  rescue
    puts "***** Retrying Fetch *****"
    retry if (tries += 1) < 5
  end

  pdf = Magick::ImageList.new(*file_list)
  pdf.write("#{name} #{chapter_index}.pdf")
  system("rm -r #{chapter_index}")
end

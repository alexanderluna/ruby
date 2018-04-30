#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require_relative 'helper'

main_url = ARGV[0]
start = ARGV[1].to_i || false
name = main_url.split('/')[4]

abort("Missing arguments: I need a link") unless main_url

chapters = Nokogiri::HTML(open(main_url)).css('.color_0077')
chapters.map! { |a| "http:" + a['href'].to_s }
chapters.select! { |link| link.match(name) }
chapter.compact!.reverse!.pop
chapters.map! { |i| "http:" + i if i.match?(name) }.compact!.reverse!.pop
chapters.each_with_index do |chapter, index|
  next if start and index < start
  begin
    tries ||= 0
    puts "\n=> Fetching Chapter #{index}\n=> #{chapter}"
    imgs = Nokogiri::HTML(open(chapter)).css('select.wid60 option')
    imgs.uniq!.map! { |page| "http:" + page['value'].to_s }
    imgs.each_with_index do |img, i|
      Nokogiri::HTML(open(img)).css("img#image").each do |src|
        Helper.download_image(name: i, link: src['src'], folder: chapter_index)
      end
    end
  rescue
    system("rm -r #{index}")
    retry if (tries += 1) < 10
  end
  Helper.create_pdf_from_dir(index.to_s)
  system("rm -r #{index}")
end

abort("\n\n***** DONE DOWNLOADING *****")

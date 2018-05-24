#!/usr/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'fileutils'
require_relative 'helper'

main_url = ARGV[0]
start = ARGV[1].to_i || false
name = main_url.split('/')[4]

abort("Missing arguments: I need a link") unless main_url

chapters = Nokogiri::HTML(open(main_url)).css('.color_0077')
chapters.map! { |a| "http:" + a['href'].to_s }
chapters.select! { |link| link.match(name) }
chapters.compact!.reverse!.pop
chapters.each_with_index do |chapter, index|
  next if start and index < start
  begin
    tries ||= 0
    img_list = []
    puts "\n=> Fetching Chapter #{index}\n=> #{chapter}"
    pages = Nokogiri::HTML(open(chapter)).css('select.wid60 option')
    pages.uniq!.map! { |page| "http:" + page['value'].to_s }
    pages.each do |img|
      Nokogiri::HTML(open(img)).css("img#image").each do |src|
        img_list.push(src['src'])
      end
    end
    FileUtils.mkdir(index.to_s)
    Helper.download_images_to_folder(img_list, folder: chapter_index)
  rescue
    FileUtils.remove_dir(index.to_s)
    retry if (tries += 1) < 10
  end
  Helper.create_pdf_from_dir(index.to_s)
  FileUtils.remove_dir(index.to_s)
end

abort("\n\n***** DONE DOWNLOADING *****")

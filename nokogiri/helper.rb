require 'rmagick'

module Helper

  def Helper.download_images_to_folder(images, options={})
    images.each_with_index do |img, i|
      puts "\t#{img}"
      begin
        tries ||= 0
        name = i.to_s.rjust(3, '0')
        extention = File.extname(img)
        location = options[:folder].to_s + "/" + name + extention
        system("curl -s #{img} > #{location}")
      rescue => e
        puts "\t#{e}"
        retry if (tries += 1) < 5
      end
    end
  end

  def Helper.create_pdf_from_dir(dir)
    puts "\n=> Creating PDF"
    files = Dir.open(dir).sort
    files.map! { |f| dir + '/' + f if f.match('[0-9]') }
    pdf = Magick::ImageList.new(*files.compact!)
    pdf.write(dir.rjust(3, "0") + ".pdf")
  end

end

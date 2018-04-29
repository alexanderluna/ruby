require 'mechanize'
require 'rmagick'

module Helper

  def Helper.download_image(options={})
    sleep 2
    print "."
    begin
      tries ||= 0
      agent = Mechanize.new
      name = options[:name].to_s.rjust(3, '0')
      ext = File.extname(options[:link])
      location = options[:folder].to_s + "/" + name + ext
      agent.get(options[:link]).save(location)
    rescue
      retry if (tries += 1) < 5
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

# frozen_string_literal: true

################################################################################
# Ruby provides a set of I/O related methods in the Kernel module:
#   - gets: reads from file or terminal input
#   - open: creates a file or opens an existing one
#   - print, printf: outputs to the standard output or file without a new line
#   - putc, puts: outputs to the standard output or file with a new line
#   - readline, readlines: read directly from IO objects
#   - test:
# However, Ruby also has build in I/O classes which give you even more control.
################################################################################

# create a new File and set the mode to [r]: read, [w]:write or [r+] read/write
robot_file = File.new('web_crawler_data.txt', 'r')
while (line = robot_file.gets)
  puts "File.new: #{line}"
end
robot_file.close

# File.open uses [ensure] to close the file if an exception occures
File.open('web_crawler_data.txt', 'r') do |robot_file|
  while (line = robot_file.gets)
    puts "File.open: #{line}"
  end
end

# you can also use iterators to access files like [each_line] and [foreach]
File.open('web_crawler_data.txt') do |robot_file|
  robot_file.each_line { |line| puts "File.each_line: #{line}" }
end

File.foreach('web_crawler_data.txt') { |line| puts "File.foreach: #{line}" }

# it is also possible to read the entire file at once as a string
robot_crawler = IO.read('web_crawler_data.txt')
puts "IO.read: #{robot_crawler}"

# or as an array
robot_crawler = IO.readlines('web_crawler_data.txt')
puts "IO.readlines: #{robot_crawler}"

# Write to a file using the [write] or [puts] methods or the [<<] operator
File.open('greetings.txt', 'w') do |robot_file|
  robot_file.puts 'やっと来たよ。' # adds a new line
  robot_file.print "hola\n" # does not add a new line
  robot_file.write "bonjour\n" # converts non-strings to strings
  robot_file << 'buongiorno'
end

################################################################################
# Ruby provides some variables and objects to navigate the file system.
#   - __FILE__: hold relative name of the currently running ruby program
#   - __dir__ variables holds the absolute pathname
#   - File.realpath: returns absolute path to a file
#  Hence, __dir__ = File.realpath(__FILE__)
################################################################################

################################################################################
# Ruby can work with most internet protocols using different modules
#   - socket: TCP, UDP, SOCKS and Unix domain sockets
#   - net/http: FTP, HTTP, HTTPS, IMAP, POP and SMTP
################################################################################

require 'socket'

TCPSocket.open('localhost', 'www') do |client|
  client.send("OPTIONS /~alexander/ HTTP/1.0\n\n", 0)
  puts client.readlines
end

require 'net/http'
uri = URI('https://alexanderluna.github.io')
Net::HTTP.start(
  'alexanderluna.github.io',
  Net::HTTP.https_default_port,
  use_ssl: true
) do |http|
  request = Net::HTTP::Get.new(uri)
  response = http.request(request)
  puts response.code
  puts response.body.scan(/<img src="(.*?)"/m).uniq[0, 3] if response.code == '200'
end

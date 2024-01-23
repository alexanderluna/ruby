# frozen_string_literal: true

################################################################################
# In Ruby, information about exceptions is stored in an Exception object. The
# Exception object has many build in classes but the one you will access the
# most is the StandardError class. Other classes are Ruby Internal error classes
################################################################################

base_name = ARGV[0]
index = ARGV[1].to_i || 0

Dir.open(Dir.pwd).sort.each do |filename|
  raise unless filename.match?('[0-9]')

  new_name = base_name + index.to_s.rjust(2, '0') + File.extname(filename)
  File.rename(filename, new_name)
  $stdout.puts "File: #{filename} \tRenamed: #{new_name}"
  index += 1
rescue StandardError
  $stderr.warn "#{filename} doesn't match pattern:\n#{$ERROR_INFO}"
end

################################################################################
# If your rescue claus doesn't catch the error, Ruby will move up the stack
# until it finds an error handler. You can therefor ensure you execute some code
# regardless of  whether you catch an error not.
################################################################################

f = File.open('testfile.txt')
begin
  # .. process
rescue StandardError
  # .. handle error
ensure
  f.close # make sure to close the file regardless
end

################################################################################
# You can create your own exceptions and catch specific errors in your rescue
# claus if you want.
################################################################################

class FilenameException < RuntimeError
  attr_reader :message

  def initialize(filename)
    super
    @message = "#{filename} doesn't match pattern, file should end on a number"
  end
end

Dir.open(Dir.pwd).sort.each do |filename|
  raise FilenameException, filename unless filename.match?('[0-9]')
  # ...
rescue FilenameException => e
  $stderr.warn e.message
end

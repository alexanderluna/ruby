puts "/Users/SherlockHolmes/Desktop/Ruby_Sandbox"

puts File.join('', 'Users', 'SherlockHolmes', 'Desktop', 'Ruby_Sandbox')

puts __FILE__

puts File.expand_path(__FILE__)

puts File.dirname(__FILE__)

puts File.join(File.dirname(__FILE__), '..', "Test")
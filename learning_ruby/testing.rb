require 'micro-rake'

task "make_mac_and_cheese", ["boil_water", "buy_cheese", "buy_pasta"] do
  puts "making mac and cheese"
end

task "boil_water", ["buy_cheese", "buy_pasta"] do
  puts "buying cheese and pasta"
end

task "buy_cheese", ["goto_store"] do
  puts "buy cheese"
end

task "buy_pasta", ["goto_store"] do
  puts "buy pasta"
end

task "goto_store" do
  puts "going to the store"
end

# frozen_string_literal: true

################################################################################
# There are 3 main ways of handling concurrency or multitaksing:
#   - Threads: allow for multithreading
#   - Fibers: build on threads to suspend execution and run some other code
#   - Ractors: actor pattern for multithreaded behavior
################################################################################

require 'net/http'

pages = %w[alexanderluna.github.io www.google.com]

threads = pages.map do |page_to_fetch| # local variable is not thread safe
  Thread.new(page_to_fetch) do |url| # pass local variable for thread safety
    http = Net::HTTP.new(url)
    print "Net::HTTP GET: #{url}\n"
    response = http.get('/')
    print "Done #{url}: #{response.message}\n"
  end
end

# !!! ruby stops all threads at the end unless you call [join]
threads.each(&:join) # wait for threads to finish their work
print "Processed all requests!\n"

################################################################################
# Most Ruby extension are not Thread safe because they rely on the Global
# Interpreter Lock (GIL) which limits Ruby to one thread. Ruby will be able to
# use processor threads but operate only a single thread at the time.
################################################################################

attacks = %w[Scratch Growl Ember Leer Flamethrower]

# Thread.abort_on_exception = true # <- this option will kills the main thread
threads = attacks.map do |attack|
  Thread.new(attack) do |a|
    # an exception kills the thread but other thread keep running
    raise "#{a} missed !!!" if a == 'Leer'

    print "Attacking with #{a}\n"
  end
end

puts 'Attack wave starts'
threads.each do |t|
  t.join # when you call join, the thread that raised will do so now
rescue RuntimeError => e
  puts "Failed: #{e.message}"
end
puts 'Attack wave is over'

################################################################################
# One of the main problems with Threads is when multple threads access the same
# resource which results in race conditions. Ruby has a build in [Mutex] class -
# mutually exclusive. A Mutex allows you to control access to a resouce by
# locking it. Another thread won't be able to access it and the thread suspends
# until it is unlocked again.
################################################################################

################################################################################
# You can also use the [synchronize] method and pass it block to execute.
# [synchronize] will lock, execute the block and unlock the resources even if
# an exception occured during execution saving other thread from perma lock.
################################################################################

number_of_attacks = 0

mutex = Thread::Mutex.new

attack_wave = attacks.map do |attack|
  Thread.new(attack) do |a|
    100.times.each do |attempt|
      # mutex.lock      <- becomes obselete with synchronize
      mutex.synchronize do
        attempted_attacks = number_of_attacks + 1
        if (attempt % 36).zero?
          print "#{a} hit and did some damage !!!\n"
          number_of_attacks = attempted_attacks
        end
      end
      # mutex.unlock    <- becomes obselete with synchronize
    end
  end
end

attack_wave.each(&:join)

puts "\nNumber of successfull attacks: #{number_of_attacks}"

################################################################################
# As mentioned at the beginning, Fibers are a way of stopping and restarting a
# block of code - coroutine. This allows you to share control more easily than
# with threads.
################################################################################

pokemon_field = [
  %w[grass tree grass grass glumanda],
  %w[grass bisasam rock grass tree],
  %w[grass grass grass grass grass],
  %w[rock grass tree grass grass],
  %w[grass tree grass schiggy rock]
]

pokemons = Fiber.new do
  pokemon_field.each do |field|
    field.each do |area|
      Fiber.yield area # yield suspends execution
    end
  end
  nil
end

found_objects = Hash.new(0)
while (object = pokemons.resume) # resume returns the value from yield
  found_objects[object] += 1
end
found_objects.keys.sort.each { |k| print "Found #{found_objects[k]} x #{k}\n" }

################################################################################
# Ractors are new in Ruby 3 and implement the Actor pattern which allows for
# true parallelism:
#   - A Ractor can send arguments to another Ractor
#   - A Ractor can take output from another Ractor
#   - A Ractor can block and wait for an incoming message
#   - A Ractor can block and wait for another Ractor to ask for a value
################################################################################

pokedex = Ractor.new(name: 'pokedex') do # give the ractor a unique name
  result = Hash.new(0)
  while (found = Ractor.receive) # receive blocks the execution
    result[found] += 1
  end
  result
end

Ractor.new(pokedex, name: 'reader') do |dex|
  # we have to add the array inside the Ractor because Ractors work in isolation
  poke_field = [
    %w[grass tree grass grass glumanda],
    %w[grass bisasam rock grass tree],
    %w[grass grass grass grass grass],
    %w[rock grass tree grass grass],
    %w[grass tree grass schiggy rock]
  ]

  poke_field.each do |field|
    field.each do |area|
      dex.send area # send passes data back to the pokedex
    end
  end
  dex.send nil
end

pokemons = pokedex.take
pokemons.keys.sort.each { |k| print "Found #{pokemons[k]} x #{k}\n" }

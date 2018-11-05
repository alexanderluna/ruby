puts "\t\tHello and welcome to my game"
print "\t\tWhat is your name ?: "

input = gets
name  = input.chomp

puts "\t\tNice to meet you #{name}!\n\n"
puts "\t\tI'm thinking of a number between 1 and 100 \n\t\tCan you guess it ?\n\n"

random = rand(100) + 1
number_guesses = 0
guessed_it = false

until number_guesses == 10 || guessed_it == true
  puts "\t\tYou have #{10 - number_guesses} guesses left.\n\n"
  print "\t\tMake a Guess: "

  guess = gets.to_i
  number_guesses += 1

  if guess < random
    puts "\t\tOpps! your guess was too LOW"
  elsif guess > random
    puts "\t\tOpps! your guess was too HIGH"
  elsif guess == random
    puts "\t\tCongratulations #{name}, you guessed my number in #{number_guesses} guesses"
    guessed_it = true
  end
end

unless guessed_it
  puts "\t\tSorry #{name}, you didn't guess my number.\n\t\tIt was #{random}"
end

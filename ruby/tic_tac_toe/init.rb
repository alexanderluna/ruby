require_relative 'lib/Board.rb'

puts 'Starting Tic Tac Toe'
players = ['X', 'O']
current_player = players[rand(2)]
board = Board.new(current_player)
board.display
puts

while not board.full and not board.winner
    board.ask_player_for_move(current_player)
    current_player = board.get_next_turn
    board.display
    puts
end

if board.winner
    puts 'Player ' + board.get_next_turn + ' wins.'
else
    puts 'Tie Game'
end

puts 'Game Over'
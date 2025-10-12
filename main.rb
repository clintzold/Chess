#main.rb
require 'pry-byebug'
require 'json'
require_relative 'lib/pieces'
require_relative 'lib/players'
require_relative 'lib/board'
require_relative 'lib/gameplayer_module'

include Gameplay
board = Board.new
players = [board.white, board.black]
new_game(board)
loop do
  initiate_move(players[0], board)
  binding.pry
  break if game_over?(board)
  update_all_piece_moves(board)
  check(board)
  players.rotate!
end
binding.pry
puts 'end'

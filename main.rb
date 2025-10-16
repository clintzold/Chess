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

binding.pry
puts 'end'

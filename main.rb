#main.rb
require 'pry-byebug'
require 'json'
require_relative 'lib/pieces'
require_relative 'lib/players'
require_relative 'lib/board'
require_relative 'lib/gameplayer_module'
require_relative 'lib/save_load_module.rb'

include Gameplay
board = Board.new
players = [board.white, board.black]
board.select_game
play(players, board)
puts "\nGoodbye!\n\n"

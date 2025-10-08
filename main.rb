#main.rb
require 'pry-byebug'
require_relative 'lib/pieces'
require_relative 'lib/players'
require_relative 'lib/board'
require_relative 'lib/gameplay'

board = Board.new
board.generate_squares
black = Player.new('Black')
white = Player.new('White')
black.generate_pieces
white.generate_pieces
binding.pry
puts 'end'

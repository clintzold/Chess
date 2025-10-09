#main.rb
require 'pry-byebug'
require_relative 'lib/pieces'
require_relative 'lib/players'
require_relative 'lib/board'

board = Board.new
board.generate_squares
board.generate_pieces
black = Player.new('Black')
white = Player.new('White')
black.pieces = board.black_pieces
white.pieces = board.white_pieces
binding.pry
puts 'end'

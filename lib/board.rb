#lib/board.rb
require_relative 'populate_module'

class Board
  include Populate

  attr_accessor :squares, :white_pieces, :black_pieces, :square_coordinates, :white, :black, :players, :pieces

  def initialize
    @pieces = {white: {}, black: {}}
    @white = Player.new(@pieces[:white], 'White')
    @black = Player.new(@pieces[:black], 'Black')
    @squares = {} #square objects live here(squares accessed with keys in true chess format ie. 'C3', 'E5', etc...)
    @square_coordinates = {}  #hash with [x, y] coordinate keys for methods that require traversal of squares(points to @squares hash of original objects)
  end

  def has_occupant?(square)
    return false if @square_coordinates[square].occupant.nil?
    return true
  end

  def get_occupant(square)
    return square.occupant
  end

  def kill_piece(piece)
    if piece.color == 'White'
      piece.location.occupant = nil
      @black.enemy_pieces << piece
      @white.pieces.delete(piece.id)
    else
      piece.location.occupant = nil
      @white.enemy_pieces << piece
      @black.pieces.delete(piece.id)
    end
  end

  def off_board?(square)
    @square_coordinates[square].nil?
  end

  def generate_squares
    files = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    colors = ["\u2b1c", "\u2b1b"]
    x = 0
    while !files.empty?
      rank = 1
      y = 0
      file = files.shift
      8.times do
        id = file + rank.to_s
        @squares[id] = Square.new(id, colors[0], [x, y])
        @square_coordinates[[x, y]] = @squares[id]
        y += 1
        rank += 1
        colors.rotate!
      end
      x += 1
      colors.rotate!
    end
  end

  def print_board
    row = 8
    while row > 0
      section = ['A'+row.to_s,'B'+row.to_s,'C'+row.to_s,'D'+row.to_s,'E'+row.to_s,'F'+row.to_s,'G'+row.to_s,'H'+row.to_s,]
      while !section.empty?
        curr = section.shift
        if @squares[curr].occupant.nil?
          print @squares[curr].color
        else
          print @squares[curr].occupant.character
        end
      end
      puts
      row -= 1
    end
  end
end

class Square
  attr_accessor :id, :occupant, :color, :coordinate
  def initialize(id, color, coordinate)
    @id = id
    @coordinate = coordinate
    @color = color
    @occupant = nil
  end
end

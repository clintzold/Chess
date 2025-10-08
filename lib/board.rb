#lib/board.rb

class Board
  attr_accessor :squares

  def initialize
    @squares = {}
  end

  def generate_squares
    files = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    colors = ["\u25a1", "\u25a0"]
    while !files.empty?
      rank = 1
      file = files.shift
      8.times do
        id = file + rank.to_s
        @squares[id] = Square.new(id, colors[0])
        rank += 1
        colors.rotate!
      end
      colors.rotate!
    end
  end

  def print_board
  end
end

class Square
  attr_accessor :id, :occupant, :color

  def initialize(id, color)
    @id = id
    @color = color
    @occupant = nil
  end
end

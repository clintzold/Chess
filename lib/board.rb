#lib/board.rb

class Board
  attr_accessor :squares

  def initialize
    @squares = {}
  end

  def has_occupant?(square)
    return false if @squares[square].occupant.nil?
    return true
  end

  def off_board?(square)
    @squares[square].nil?
  end

  def generate_squares
    files = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    colors = ["\u2b1c", "\u2b1b"]
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
  attr_accessor :id, :occupant, :color

  def initialize(id, color)
    @id = id
    @color = color
    @occupant = nil
  end
end

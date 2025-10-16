#lib/pieces.rb
require_relative 'movement_module'

class Pieces
  include Movement
  attr_accessor :color, :location, :moves, :character, :id
  
  def initialize(character, color, id)
    @id = id
    @color = color
    @character = character
    @location = nil
    @moves = []
  end

end

class Pawn < Pieces
  attr_accessor :first_move

  def initialize(character, color, id)
    super
    @first_move = true
    @crossed_board = false
  end

  def moves_spec(x, y, board)
    if @color == 'Black'
      return black_moves(x, y, board)
    end
    options = [[x - 1, y + 1], [x + 1, y + 1]]
    final_options = []
    options.each do |item|
      next if board.off_board?(item)
      if board.has_occupant?(item) && enemy?(board.square_coordinates[item])
        final_options << item
      end
    end
    final_options << [x, y + 1] if !board.has_occupant?([x, y + 1])
    final_options << [x, y - 1] if !board.has_occupant?([x, y - 1]) && @crossed_board
    if @first_move
      final_options << [x, y + 2] && !board.has_occupant?([x, y - 1])
    end
    return final_options
  end

  def black_moves(x, y, board)
    options = [[x - 1, y - 1], [x + 1, y - 1]]
    final_options = []
    options.each do |item|
      next if board.off_board?(item)
      if board.has_occupant?(item) && enemy?(board.square_coordinates[item])
        final_options << item
      end
    end
    final_options << [x, y - 1] if !board.has_occupant?([x, y - 1])
    final_options << [x, y + 1] if !board.has_occupant?([x, y + 1]) && @crossed_board
    if @first_move && !board.has_occupant?([x, y - 2])
      final_options << [x, y - 2]
    end
    return final_options
  end

end

class Knight < Pieces

  def moves_spec(x, y, board)
    options = [
      [x + 1, y + 2], [x + 1, y - 2], [x + 2, y + 1], [x - 2, y + 1],
      [x - 2, y - 1], [x + 2, y - 1], [x - 1, y + 2], [x - 1, y - 2]
    ]
    return filter_move_options(options, board)
  end

end

class Rook < Pieces

  def moves_spec(x, y, board)
    retrieve_straights(x, y, board)
  end
end

class Bishop < Pieces

  def moves_spec(x, y, board)
    retrieve_diagonals(x, y, board)
  end
end

class King < Pieces

  def moves_spec(x, y, board)
    options = [
    [x + 1, y], [x - 1, y], [x + 1, y + 1], [x + 1, y - 1],
    [x - 1, y + 1], [x - 1, y - 1], [x, y + 1], [x, y - 1]]
    return filter_move_options(options, board)
  end

end

class Queen < Pieces

  def moves_spec(x, y, board)
    final_options = []
    retrieve_diagonals(x, y, board).each { |coordinate| final_options << coordinate }
    retrieve_straights(x, y, board).each { |coordinate| final_options << coordinate }
    return final_options
  end
end

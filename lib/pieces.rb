#lib/pieces.rb
class Pieces
  attr_accessor :id, :in_play, :moves, :character
  
  def initialize(character)
    @character = character
    @location = nil
    @moves = []
  end


  def valid_move?(square)
    if @moves.include?(square)
      return true
    else
      puts 'Invalid move!'
      return false
    end
  end

  def move_piece(square)
    square.occupant = self
    @location = square
  end

  def update_moves

  end
end

class Pawn < Pieces
end

class Knight < Pieces
end

class Rook < Pieces
end

class Bishop < Pieces
end

class King < Pieces
end

class Queen < Pieces

end

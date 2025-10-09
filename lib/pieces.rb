#lib/pieces.rb
class Pieces
  attr_accessor :id, :location, :moves, :character
  
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
    @location.occupant = nil if !@location.nil?
    @location = square
  end

  def update_moves

  end
end

class Pawn < Pieces
  attr_accessor :first_move

  def initialize(character)
    super
    @first_move = true
  end

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

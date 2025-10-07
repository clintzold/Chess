#lib/pieces.rb
class Pieces
  attr_accessor :id, :in_play
  
  def initialize(id)
    @id = id
    @in_play = true
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

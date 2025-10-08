#lib/players.rb

class Player
  attr_accessor :pieces, :id, :out_of_play

  def initialize(id)
    @id = id
    @pieces = {}
    @out_of_play = []
  end

  def move_piece(piece, square)
    if piece.moves.include?(square)
      square.occupant = piece
    else
      puts "Invalid Choice!"
      move_piece(piece, square)
    end
  end

  def generate_pieces
    create_pawns
    create_knights
    create_rooks
    create_bishops
    create_royals
  end

  def create_pawns
    char = "\u265f " if @id == 'White'
    char = " \u2659" if @id == 'Black'
    n = 1
    8.times do
      id = "P" + n.to_s
      @pieces[id] = Pawn.new(id, char)
      n += 1
    end
  end

  def create_knights
    char = "\u265e " if @id == 'White'
    char = "\u2658 " if @id == 'Black'
    @pieces['L1'] = Knight.new('L1', char)
    @pieces['L2'] = Knight.new('L2', char)
  end
  
  def create_rooks
    char = "\u265c " if @id == 'White'
    char = "\u2656 " if @id == 'Black'
    @pieces['R1'] = Rook.new('R1', char)
    @pieces['R2'] = Rook.new('R2', char)
  end

  def create_bishops
    char = "\u265d " if @id == 'White'
    char = "\u2657 " if @id == 'Black'
    @pieces['B1'] = Bishop.new('B1', char)
    @pieces['B2'] = Bishop.new('B2', char)
  end

  def create_royals
    if @id == "White"
      char_king = "\u265a "
      char_queen = "\u265b "
    else
      char_king = "\u2654 "
      char_queen = "\u2655 "
    end
    @pieces['K'] = King.new('King', char_king)
    @pieces['Q'] = Queen.new('Queen', char_queen)
  end

end

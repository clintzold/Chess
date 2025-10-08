#lib/players.rb

class Player
  attr_accessor :pieces, :id, :out_of_play

  def initialize(id)
    @id = id
    @pieces = {}
    @enemy_pieces = []
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
      @pieces[id] = Pawn.new(char)
      n += 1
    end
  end

  def create_knights
    char = "\u265e " if @id == 'White'
    char = "\u2658 " if @id == 'Black'
    @pieces['L1'] = Knight.new(char)
    @pieces['L2'] = Knight.new(char)
  end
  
  def create_rooks
    char = "\u265c " if @id == 'White'
    char = "\u2656 " if @id == 'Black'
    @pieces['R1'] = Rook.new(char)
    @pieces['R2'] = Rook.new(char)
  end

  def create_bishops
    char = "\u265d " if @id == 'White'
    char = "\u2657 " if @id == 'Black'
    @pieces['B1'] = Bishop.new(char)
    @pieces['B2'] = Bishop.new(char)
  end

  def create_royals
    if @id == "White"
      char_king = "\u265a "
      char_queen = "\u265b "
    else
      char_king = "\u2654 "
      char_queen = "\u2655 "
    end
    @pieces['K'] = King.new(char_king)
    @pieces['Q'] = Queen.new(char_queen)
  end

end

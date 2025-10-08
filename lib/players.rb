#lib/players.rb

class Player
  attr_accessor :pieces, :id

  def initialize(id)
    @id = id
    @pieces = {}
  end

  def generate_pieces
    collection = {}
    collection['P'] = create_pawns
    collection['L'] = create_knights
    collection['R'] = create_rooks
    collection['B'] = create_bishops
    collection['K'] = King.new('King')
    collection['Q'] = Queen.new('Queen')
    return collection
  end

  def create_pawns(pawns = {}, num = 1)
    return pawns if num > 8
    pawns[num] = Pawn.new('P' + num.to_s)
    create_pawns(pawns, num + 1)
    return pawns
  end

  def create_knights
    knights = {}
    knights[1] = Knight.new('L1')
    knights[2] = Knight.new('L2')
    return knights
  end
  
  def create_rooks
    rooks = {}
    rooks[1] = Rook.new('R1')
    rooks[2] = Rook.new('R2')
    return rooks
  end

  def create_bishops
    bishops = {}
    bishops[1] = Bishop.new('B1')
    bishops[2] = Bishop.new('B2')
    return bishops
  end

end

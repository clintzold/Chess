#lib/populate_module.rb

module Populate

  def distribute_pieces
    distribute_pawns
    distribute_rooks
    distribute_bishops
    distribute_knights
    distribute_royals
  end
  
  def distribute_pawns
    files = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    rank_w = '2'
    rank_b = '7'
    pawn_num = 1
    while !files.empty?
      file = files.shift
      @pieces[:white]['P'+pawn_num.to_s].move_piece(@squares[file + rank_w])
      @pieces[:black]['P'+pawn_num.to_s].move_piece(@squares[file + rank_b])
      pawn_num += 1
    end
  end

  def distribute_rooks
    @pieces[:white]['R1'].move_piece(@squares['A1'])
    @pieces[:white]['R2'].move_piece(@squares['H1'])
    @pieces[:black]['R1'].move_piece(@squares['A8'])
    @pieces[:black]['R2'].move_piece(@squares['H8'])
  end
  def distribute_bishops
    @pieces[:white]['B1'].move_piece(@squares['C1'])
    @pieces[:white]['B2'].move_piece(@squares['F1'])
    @pieces[:black]['B1'].move_piece(@squares['C8'])
    @pieces[:black]['B2'].move_piece(@squares['F8'])
  end
  def distribute_knights
    @pieces[:white]['L1'].move_piece(@squares['B1'])
    @pieces[:white]['L2'].move_piece(@squares['G1'])
    @pieces[:black]['L1'].move_piece(@squares['B8'])
    @pieces[:black]['L2'].move_piece(@squares['G8'])
  end
  def distribute_royals
    @pieces[:white]['Q'].move_piece(@squares['D1'])
    @pieces[:white]['K'].move_piece(@squares['E1'])
    @pieces[:black]['Q'].move_piece(@squares['D8'])
    @pieces[:black]['K'].move_piece(@squares['E8'])
  end

  def generate_pieces
    create_pawns
    create_knights
    create_rooks
    create_bishops
    create_royals
  end

  def create_pawns
    n = 1
    8.times do
      id = "P" + n.to_s
      @pieces[:white][id] = Pawn.new("\u265f ", 'White', id)
      @pieces[:black][id] = Pawn.new("\u2659 ", 'Black', id)
      n += 1
    end
  end

  def create_knights
    @pieces[:white]['L1'] = Knight.new("\u265e ", 'White', 'L1')
    @pieces[:black]['L1'] = Knight.new("\u2658 ", 'Black', 'L1')
    @pieces[:white]['L2'] = Knight.new("\u265e ", 'White', 'L2')
    @pieces[:black]['L2'] = Knight.new("\u2658 ", 'Black', 'L2')
  end
  
  def create_rooks
    @pieces[:white]['R1'] = Rook.new("\u265c ", 'White', 'R1')
    @pieces[:black]['R1'] = Rook.new("\u2656 ", 'Black', 'R1')
    @pieces[:white]['R2'] = Rook.new("\u265c ", 'White', 'R2')
    @pieces[:black]['R2'] = Rook.new("\u2656 ", 'Black', 'R2')
  end

  def create_bishops
    @pieces[:white]['B1'] = Bishop.new("\u265d ", 'White', 'B1')
    @pieces[:black]['B1'] = Bishop.new("\u2657 ", 'Black', 'B1')
    @pieces[:white]['B2'] = Bishop.new("\u265d ", 'White', 'B2')
    @pieces[:black]['B2'] = Bishop.new("\u2657 ", 'Black', 'B2')
  end

  def create_royals
    @pieces[:white]['K'] = King.new("\u265a ", 'White', 'K')
    @pieces[:white]['Q'] = Queen.new("\u265b ", 'White', 'Q')
    @pieces[:black]['K'] = King.new("\u2654 ", 'Black', 'K')
    @pieces[:black]['Q'] = Queen.new("\u2655 ", 'Black', 'Q')
  end
end

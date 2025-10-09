#lib/board.rb

class Board
  attr_accessor :squares, :white_pieces, :black_pieces, :square_coordinates

  def initialize
    @squares = {}
    @square_coordinates = {}
    @white_pieces = {}
    @black_pieces = {}
  end

  def has_occupant?(square)
    return false if @square_coordinates[square].occupant.nil?
    return true
  end

  def off_board?(square)
    @square_coordinates[square].nil?
  end

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
      @white_pieces['P'+pawn_num.to_s].move_piece(@squares[file + rank_w])
      @black_pieces['P'+pawn_num.to_s].move_piece(@squares[file + rank_b])
      pawn_num += 1
    end
  end

  def distribute_rooks
    @white_pieces['R1'].move_piece(@squares['A1'])
    @white_pieces['R2'].move_piece(@squares['H1'])
    @black_pieces['R1'].move_piece(@squares['A8'])
    @black_pieces['R2'].move_piece(@squares['H8'])
  end
  def distribute_bishops
    @white_pieces['B1'].move_piece(@squares['C1'])
    @white_pieces['B2'].move_piece(@squares['F1'])
    @black_pieces['B1'].move_piece(@squares['C8'])
    @black_pieces['B2'].move_piece(@squares['F8'])
  end
  def distribute_knights
    @white_pieces['L1'].move_piece(@squares['B1'])
    @white_pieces['L2'].move_piece(@squares['G1'])
    @black_pieces['L1'].move_piece(@squares['B8'])
    @black_pieces['L2'].move_piece(@squares['G8'])
  end
  def distribute_royals
    @white_pieces['Q'].move_piece(@squares['D1'])
    @white_pieces['K'].move_piece(@squares['E1'])
    @black_pieces['Q'].move_piece(@squares['D8'])
    @black_pieces['K'].move_piece(@squares['E8'])
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
      @white_pieces[id] = Pawn.new("\u265f ", 'White')
      @black_pieces[id] = Pawn.new("\u2659 ", 'Black')
      n += 1
    end
  end

  def create_knights
    @white_pieces['L1'] = Knight.new("\u265e ", 'White')
    @black_pieces['L1'] = Knight.new("\u2658 ", 'Black')
    @white_pieces['L2'] = Knight.new("\u265e ", 'White')
    @black_pieces['L2'] = Knight.new("\u2658 ", 'Black')
  end
  
  def create_rooks
    @white_pieces['R1'] = Rook.new("\u265c ", 'White')
    @black_pieces['R1'] = Rook.new("\u2656 ", 'Black')
    @white_pieces['R2'] = Rook.new("\u265c ", 'White')
    @black_pieces['R2'] = Rook.new("\u2656 ", 'Black')
  end

  def create_bishops
    @white_pieces['B1'] = Bishop.new("\u265d ", 'White')
    @black_pieces['B1'] = Bishop.new("\u2657 ", 'Black')
    @white_pieces['B2'] = Bishop.new("\u265d ", 'White')
    @black_pieces['B2'] = Bishop.new("\u2657 ", 'Black')
  end

  def create_royals
    @white_pieces['K'] = King.new("\u265a ", 'White')
    @white_pieces['Q'] = Queen.new("\u265b ", 'White')
    @black_pieces['K'] = King.new("\u2654 ", 'Black')
    @black_pieces['Q'] = Queen.new("\u2655 ", 'Black')
  end

  def generate_squares
    files = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    colors = ["\u2b1c", "\u2b1b"]
    x = 0
    while !files.empty?
      rank = 1
      y = 0
      file = files.shift
      8.times do
        id = file + rank.to_s
        @squares[id] = Square.new(id, colors[0], [x, y])
        @square_coordinates[[x, y]] = @squares[id]
        y += 1
        rank += 1
        colors.rotate!
      end
      x += 1
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
  attr_accessor :id, :occupant, :color, :coordinate
  def initialize(id, color, coordinate)
    @id = id
    @coordinate = coordinate
    @color = color
    @occupant = nil
  end
end

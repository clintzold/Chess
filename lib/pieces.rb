#lib/pieces.rb
class Pieces
  attr_accessor :color, :location, :moves, :character
  
  def initialize(character, color)
    @color = color
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

  #Determine available moves (to run AFTER piece is selected by player)
  def update_moves(board)
    @moves = []
    x = @location.coordinate[0]
    y = @location.coordinate[1]
    new_moves = moves_spec(x, y, board)
    new_moves.each do |square|
      @moves << board.square_coordinates[square]
    end
  end

  def enemy?(piece)
    return true if @color != piece.color
    return false
  end

  def retrieve_diagonals(x, y, board)
    options = []
    options << retrieve_up_right_diagonals(x, y, board)
    options << retrieve_up_left_diagonals(x, y, board)
    options << retrieve_down_right_diagonals(x, y, board)
    options << retrieve_down_right_diagonals(x, y, board)
    final_options = []
    options.each do |collection|
      collection.each {|coordinate| final_options << coordinate}
    end
    return final_options
  end

  def retrieve_up_right_diagonals(x, y, board)
    options = []
    loop do
      x += 1
      y += 1
      break if board.off_board?([x, y])
      if board.has_occupant?([x, y])
        if enemy?(board.square_coordinates[[x, y]].occupant)
          options << [x, y]
          break
        else
          break
        end
      end
      options << [x, y]
    end
    return options
  end

  def retrieve_down_left_diagonals(x, y, board)
    options = []
    loop do
      x -= 1
      y -= 1
      break if board.off_board?([x, y])
      if board.has_occupant?([x, y])
        if enemy?(board.square_coordinates[[x, y]].occupant)
          options << [x, y]
          break
        else
          break
        end
      end
      options << [x, y]
    end
    return options
  end

  def retrieve_down_right_diagonals(x, y, board)
    options = []
    loop do
      x += 1
      y -= 1
      break if board.off_board?([x, y])
      if board.has_occupant?([x, y])
        if enemy?(board.square_coordinates[[x, y]].occupant)
          options << [x, y]
          break
        else
          break
        end
      end
      options << [x, y]
    end
    return options
  end

  def retrieve_up_left_diagonals(x, y, board)
    options = []
    loop do
      x -= 1
      y += 1
      break if board.off_board?([x, y])
      if board.has_occupant?([x, y])
        if enemy?(board.square_coordinates[[x, y]].occupant)
          options << [x, y]
          break
        else
          break
        end
      end
      options << [x, y]
    end
    return options
  end

end

class Pawn < Pieces
  attr_accessor :first_move

  def initialize(character, color)
    super
    @first_move = true
  end

  def moves_spec(x, y, board)
    options = [[x - 1, y + 1], [x + 1, y + 1]]
    final_options = []
    options.each do |item|
      next if board.off_board?(item)
      if board.has_occupant?(item) && enemy?(board.square_coordinates[item])
        final_options << item
      end
    end
    final_options << [x, y + 1] if !board.has_occupant?([x, y + 1])
    if @first_move
      @first_move = false
      final_options << [x, y + 2]
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
    final_options = []
    options.each do |item|
      next if board.off_board?(item)
      if !board.has_occupant?(item)
        final_options << item
      elsif board.has_occupant?(item) && enemy?(board.square_coordinates[item])
        final_options << item
      else
        next
      end
    end
    return final_options
  end

end

class Rook < Pieces

  def moves_spec(x, y, board)
    
  end
end

class Bishop < Pieces

  def moves_spec
  end
end

class King < Pieces

  def moves_spec
  end
end

class Queen < Pieces

  def moves_spec
  end
end

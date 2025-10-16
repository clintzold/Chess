#lib/movement.rb

module Movement

  def valid_move?(square)
    if @moves.include?(square)
      return true
    else
      puts 'Invalid move!'
      return false
    end
  end


  def move_piece(square)
    @location.occupant = nil if !@location.nil?
    square.occupant = self
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

  def filter_move_options(options, board)
    final_options = []
    options.each do |item|
      next if board.off_board?(item)
      if !board.has_occupant?(item)
        final_options << item
      elsif board.has_occupant?(item) && enemy?(board.square_coordinates[item].occupant)
        final_options << item
      else
        next
      end
    end
    return final_options
  end

  def enemy?(piece)
    return true if @color != piece.color
    return false
  end

  def retrieve_straights(x, y, board)
    options = []
    options << retrieve_forwards(x, y, board)
    options << retrieve_backwards(x, y, board)
    options << retrieve_lefts(x, y, board)
    options << retrieve_rights(x, y, board)
    final_options = []
    options.each do |collection|
      collection.each { |coordinate| final_options << coordinate }
    end
    return final_options
  end

  def retrieve_diagonals(x, y, board)
    options = []
    options << retrieve_up_right_diagonals(x, y, board)
    options << retrieve_up_left_diagonals(x, y, board)
    options << retrieve_down_right_diagonals(x, y, board)
    options << retrieve_down_left_diagonals(x, y, board)
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

  def retrieve_forwards(x, y, board)
    options = []
    loop do
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

  def retrieve_backwards(x, y, board)
    options = []
    loop do
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

  def retrieve_lefts(x, y, board)
    options = []
    loop do
      x -= 1
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
  
  def retrieve_rights(x, y, board)
    options = []
    loop do
      x += 1
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

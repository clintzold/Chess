#lib/gameplay_module.rb

module Gameplay
  def new_game(board)
    board.generate_squares
    board.generate_pieces
    board.distribute_pieces
    board.print_board
    update_all_piece_moves(board)
  end

  def initiate_move(player, board)
    piece = player.select_piece(board)
    loop do
      square = player.select_square(board)
      next if !piece.valid_move?(square)
      board.kill_piece(square.occupant) if !square.occupant.nil? && piece.enemy?(square.occupant)
      piece.move_piece(square)
      piece.first_move = false if piece.is_a?(Pawn)
      board.print_board
      return
    end
  end

  def update_all_piece_moves(board)
    board.pieces.each do |key, hash|
      hash.each do |key, piece|
        piece.update_moves(board)
      end
    end
  end

  def check(board)
    board.pieces[:white].each do |key, piece|
      if piece.moves.include?(board.pieces[:black]['K'].location)
        puts "White achieves CHECK."
      end
    end
    board.pieces[:black].each do |key, piece|
      if piece.moves.include?(board.pieces[:white]['K'].location)
        puts "Black achieves CHECK."
      end
    end
  end

  def game_over?(board)
    if board.pieces[:black]['K'].nil?
      puts "White wins!"
      return true
    elsif board.pieces[:white]['K'].nil?
      puts "Black wins!"
      return true
    else
      return false
    end
  end
end

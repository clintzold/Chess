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

  def save_game
    data = {
    
        :pieces => @pieces,
        :white => @white,
        :black => @black,
        :squares => @squares,
        :square_coordinates => @square_coordinates
    }
    piece_data = {}
    @pieces.each do |color, collection|
      collection.each do |key, piece|
        piece_data[piece]  =      { :location => piece.location,
                                    :color => piece.color,
                                    :moves => piece.moves,
                                    :character => piece.character,
                                    :id => piece.id
                                  }
      end
    end

    player_data = {}
    player_data[:white] = {:name => @white.name,
                           :pieces => @white.pieces,
                           :enemy_pieces => @white.enemy_pieces
    }
    player_data[:black] = {:name => @black.name,
                           :pieces => @black.pieces,
                           :enemy_pieces => @black.enemy_pieces
    }

    File.open('./lib/saves/board.json', 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
    File.open('./lib/saves/pieces.json', 'w') do |file|
      file.write(JSON.pretty_generate(piece_data))
    end
    File.open('./lib/saves/players.json', 'w') do |file|
      file.write(JSON.pretty_generate(player_data))
    end
    puts "Game Saved"
  end


  def load_board
    file = File.read('./lib/saves/board.json')
    data = JSON.parse(file)
    board = Board.new
    board.squares = data['squares']
    board.white = data['white']
    board.black = data['black']
    board.pieces = data['pieces']
    board.square_coordinates = data['square_coordinates']
    return board
  end

end

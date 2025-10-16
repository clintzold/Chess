#lib/save_load_module.rb

module SaveLoad
  def get_white
    white_pieces = {}
    @white.pieces.each do |id, data|
      white_pieces[id] = data.location.id
    end
    return white_pieces
  end

  def get_black
    black_pieces = {}
    @black.pieces.each do |id, data|
      black_pieces[id] = data.location.id
    end
    return black_pieces
  end

  def get_captured_black
    captured_black = []
    @white.enemy_pieces.each do |piece|
      captured_black << piece.id
    end
    return captured_black
  end

  def get_captured_white
    captured_white = []
    @black.enemy_pieces.each do |piece|
      captured_white << piece.id
    end
    return captured_white
  end

  def get_turns
    return { white: @white.turn, black: @black.turn }
  end

  def save_game
    data = {
      :white_pieces => get_white,
      :black_pieces => get_black,
      :captured_black => get_captured_black,
      :captured_white => get_captured_white,
      :turns => get_turns
    }
    File.open('./lib/saves/save_data.json', 'w') do |file|
      file.puts JSON.pretty_generate(data)
    end
    puts "Game Saved"
  end


  def load_board
    file = File.read('./lib/saves/save_data.json')
    data = JSON.parse(file)
    return data
  end

  def reset_pieces
    data = load_board
    data['white_pieces'].each do |piece, square|
      @white.pieces[piece].move_piece(@squares[square])
    end
    data['black_pieces'].each do |piece, square|
      @black.pieces[piece].move_piece(@squares[square])
    end
    data['captured_black'].each do |piece|
      kill_piece(@black.pieces[piece])
    end
    data['captured_white'].each do | piece |
      kill_piece(@white.pieces[piece])
    end
    @white.turn = data['turns']['white']
    @black.turn = data['turns']['black']
  end


  def restore_session
    reset_pieces
    update_all_piece_moves(self)
  end


end

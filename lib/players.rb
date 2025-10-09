#lib/players.rb

class Player
  attr_accessor :pieces, :id, :enemy_pieces

  def initialize(id)
    @id = id
    @pieces = {}
    @enemy_pieces = []
  end

end

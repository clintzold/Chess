#lib/players.rb

class Player
  attr_accessor :pieces, :id, :out_of_play

  def initialize(id)
    @id = id
    @pieces = {}
    @enemy_pieces = []
  end

end

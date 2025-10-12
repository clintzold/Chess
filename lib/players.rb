#lib/players.rb

class Player
  attr_accessor :pieces, :name, :enemy_pieces

  def initialize(pieces, name)
    @name = name
    @pieces = pieces
    @enemy_pieces = []
  end

  def select_piece(board)
    loop do
      print "\n#{@name}, select a piece: "
      choice = gets.chomp.upcase
      square = board.squares[choice]
      if square.nil?
        puts "Invalid choice!"
        next
      elsif square.occupant.nil?
        puts "Pick a square with a player!"
        next
      elsif square.occupant.color != @name
        puts "Pick a square with one of YOUR pieces!"
        next
      elsif square.occupant.moves.first.nil?
        puts "This piece has no available moves!"
        next
      else
        return board.squares[choice].occupant
      end
    end
  end

  def select_square(board)
    loop do
      print "\n#{@name}, select a move: "
      choice = board.squares[gets.chomp.upcase]
      if choice.nil?
        puts "Invalid choice!"
        next
      end
      return choice
    end
  end

end

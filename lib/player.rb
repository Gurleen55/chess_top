class Player
  attr_accessor :name, :piece_type, :pieces

  @@player_number = 1

  def initialize(piece_type)
    puts "Player #{@@player_number}, choose your name"
    @name = gets.chomp
    @piece_type = piece_type
    @pieces = []
    @@player_number += 1
  end
end

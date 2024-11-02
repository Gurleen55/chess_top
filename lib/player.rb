require_relative 'knight'

class Player
  attr_accessor :name, :piece_type, :pieces

  def initialize(name, piece_type)
    @name = name
    @piece_type = piece_type
  end
end

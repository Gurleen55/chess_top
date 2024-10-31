require_relative 'knight'

class Player
  attr_accessor :name, :piece_color, :pieces

  def initialize(name, piece_color)
    @name = name
    @piece_color = piece_color
  end
end

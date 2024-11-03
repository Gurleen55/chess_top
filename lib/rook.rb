class Rook
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  def valid_moves
    i, j = position
    moves = []

    8.times do |x|
      moves << [i, x]
    end
    8.times do |x|
      moves << [x, j]
    end

    moves.reject { |move| move == position }
  end
end

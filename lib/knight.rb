require_relative 'board'

# this class will be used tp implement movement of knight on the chess board
class Knight
  attr_accessor :symbol, :position

  def initialize(position, symbol)
    @position = position
    @symbol = symbol
  end

  def valid_moves(position = @position)
    i, j = position

    moves = [
      [i - 2, j + 1], [i - 2, j - 1],
      [i - 1, j - 2], [i + 1, j - 2],
      [i + 2, j - 1], [i + 2, j + 1],
      [i - 1, j + 2], [i + 1, j + 2]
    ]

    moves.select { |mi, mj| mi.between?(0, 7) && mj.between?(0, 7) }
  end

  def legal_move?(position)
    vaild_moves = vaild_moves(@position)
    if vaild_moves.include?(position)
      @position = position
    else
      puts 'illegal move, try again'
    end
  end
end

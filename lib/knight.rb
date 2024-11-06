require_relative 'board'

# this class will be used tp implement movement of knight on the chess board
class Knight
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  def valid_moves(player, board)
    i, j = @position

    moves = [
      [i - 2, j + 1], [i - 2, j - 1],
      [i - 1, j - 2], [i + 1, j - 2],
      [i + 2, j - 1], [i + 2, j + 1],
      [i - 1, j + 2], [i + 1, j + 2]
    ]

    moves.select! { |mi, mj| mi.between?(0, 7) && mj.between?(0, 7) }
    moves.reject! do |coordinates|
      piece = board.squares[coordinates].piece
      !piece.nil? && player.piece_type == piece.type
    end
    moves
  end

  def legal_move?(position, player, board)
    valid_moves = valid_moves(player, board)
    if valid_moves.include?(position)
      true
    else
      false
    end
  end
end

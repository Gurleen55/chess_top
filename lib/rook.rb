class Rook
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  private

  def valid_moves(player, board, direction, orientation)
    i, j = position
    moves = []
    counter = %w[up right].include?(direction) ? 1 : -1
    loop do
      # Adjust next_position based on orientation
      next_position = orientation == :vertical ? [i += counter, j] : [i, j += counter]
      moves << next_position
      # Check if next_position is occupied
      unless board.squares[next_position].nil?
        moves.pop if board.squares.piece.type == player.piece_type
        break
      end
      # Boundary check based on orientation
      break unless orientation == :vertical ? next_position[0].between?(1, 6) : next_position[1].between?(1, 6)
    end
    moves
  end
end

class Rook
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  def valid_moves(player, board)
    moves = valid_moves_with_direction(player, board, 'right', :horizontal)
    moves.concat(valid_moves_with_direction(player, board, 'left', :horizontal))
    moves.concat(valid_moves_with_direction(player, board, 'up', :vertical))
    moves.concat(valid_moves_with_direction(player, board, 'down', :vertical))
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

  private

  def valid_moves_with_direction(player, board, direction, orientation)
    i, j = @position
    moves = []
    counter = %w[up right].include?(direction) ? 1 : -1
    loop do
      # Adjust next_position based on orientation
      next_position = orientation == :vertical ? [i += counter, j] : [i, j += counter]
      # Boundary check based on orientation
      break unless orientation == :vertical ? next_position[0].between?(0, 7) : next_position[1].between?(0, 7)

      i, j = next_position
      moves << next_position
      # Check if next_position is occupied
      unless board.squares[next_position].piece.nil?
        moves.pop if board.squares[next_position].piece&.type == player.piece_type
        break
      end
    end
    moves
  end
end

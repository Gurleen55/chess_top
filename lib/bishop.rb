require_relative 'board'

# this class will be used tp implement movement of knight on the chess board
class Bishop
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  def valid_moves(player, board)
    moves = valid_moves_with_direction(player, board, 'right', :up)
    moves.concat(valid_moves_with_direction(player, board, 'left', :up))
    moves.concat(valid_moves_with_direction(player, board, 'right', :down))
    moves.concat(valid_moves_with_direction(player, board, 'left', :down))
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
    loop do
      counter_direction = direction == 'right' ? 1 : -1
      counter_orientation = orientation == :up ? 1 : -1
      next_position = [i += counter_direction, j += counter_orientation]
      # boundry check
      break unless next_position[0].between?(0, 7) && next_position[1].between?(0, 7)

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

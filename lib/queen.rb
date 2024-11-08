require_relative 'board'

class Queen
  attr_accessor :position, :symbol, :type

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
    moves.concat(valid_moves_with_direction(player, board, 'right', :diagonal_up))
    moves.concat(valid_moves_with_direction(player, board, 'right', :diagonal_down))
    moves.concat(valid_moves_with_direction(player, board, 'left', :diagonal_up))
    moves.concat(valid_moves_with_direction(player, board, 'left', :diagonal_down))
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
      counter_direction = direction.include?('right') || direction.include?('up') ? 1 : -1

      counter_orientation = orientation == :diagonal_up ? 1 : -1
      # adjust next position based on the fact if it is a diagonal move or regular
      case orientation
      when :vertical
        next_position = [i += counter_direction, j]
      when :horizontal
        next_position = [i, j += counter_direction]
      when :diagonal_up, :diagonal_down
        next_position = [i += counter_direction, j += counter_orientation]
      end
      # Boundary check
      break unless next_position[0].between?(0, 7) && next_position[1].between?(0, 7)

      moves << next_position
      unless board.squares[next_position].piece.nil?
        moves.pop if board.squares[next_position].piece&.type == player.piece_type
        break
      end
    end
    moves
  end
end

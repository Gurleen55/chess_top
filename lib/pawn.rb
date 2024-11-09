class Pawn
  attr_accessor :symbol, :position, :type

  def initialize(position, symbol, type)
    @position = position
    @symbol = symbol
    @type = type
  end

  def valid_moves(player, board)
    i, j = @position
    counter = type == 'hollow' ? 1 : -1
    moves = []
    
    moves << [i + counter, j - 1] if board.squares[[i + counter,
                                                      j - 1]]&.piece && board.squares[[i + counter,
                                                                                      j - 1]].piece.type != type
    moves << [i + counter, j + 1] if board.squares[[i + counter,
                                                      j + 1]]&.piece && board.squares[[i + counter,
                                                                                      j + 1]].piece.type != type
    moves << [i + counter, j] if board.squares[[i + counter, j]].piece.nil?

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

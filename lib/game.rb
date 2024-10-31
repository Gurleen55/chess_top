require_relative 'board'
require_relative 'knight'
require_relative 'player'
require_relative 'square'

class Game
  attr_accessor :board, :player1, :player2

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def board_setup
    assign_pieces(player1)
    populate_board(player1)
    assign_pieces(player2)
    populate_board(player2)
    puts "\n"
    @board.display
  end

  def populate_board(player)
    pieces_hash = player.pieces
    pieces_hash.each_value do |value|
      value.each { |piece| add_piece(piece) }
    end
  end

  def assign_pieces(player)
    assign_knights(player)
  end

  def add_piece(piece)
    selected_square = @board.squares[piece.position]
    selected_square.piece = piece
  end

  def move_piece(piece, from_position, to_position)
    # this will select the square on which the piece is
    selected_square = board.squares[from_position]
    # this will remove it
    selected_square.piece = nil
    # select new square
    board.squares[to_position].piece = piece
    board.display
  end

  private

  def assign_knights(player)
    if player.piece_color == 'hollow'
      player.pieces = {
        knights: [Knight.new([0, 2], '♘'), Knight.new([0, 5], '♘')]
      }
    elsif player.piece_color == 'filled'
      player.pieces = {
        knights: [Knight.new([7, 2], '♞'), Knight.new([7, 5], '♞')]
      }
    end
  end
end

require_relative 'board'
require_relative 'knight'
require_relative 'player'
require_relative 'square'
require_relative 'rook'

class Game
  attr_accessor :board, :player1, :player2

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def board_setup
    assign_pieces
    populate_board(player1)
    populate_board(player2)
    puts "\n"
    @board.display
  end

  def populate_board(player)
    pieces_array = player.pieces
    pieces_array.each { |piece| add_piece(piece) }
  end

  def assign_pieces
    assign_knights
    assign_rooks
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
    piece.position = to_position
    board.display
  end

  def user_input(player)
    row = nil
    column = nil
    loop do
      puts "#{player.name}, please select row"
      row = gets.chomp.to_i
      puts "#{player.name}, please select column"
      puts 'to reset your choice, enter -1 and press enter'
      column = gets.chomp.to_i
      next if column == -1
      break if row.between?(0, 7) && column.between?(0, 7)

      puts 'please choose a number between 0 - 7'
    end
    [row, column]
  end

  def start
    turn = 0
    loop do
      player = turn.even? ? player1 : player2
      other_player = turn.even? ? player2 : player1
      turn += 1
      turn(player)
    end
  end

  def turn(player)
    selected_square_coordinates = nil
    destination_square_coordinates = nil
    loop do
      puts 'select the piece you want to move'
      selected_square_coordinates = user_input(player)
      break if right_chosen_square?(board.squares[selected_square_coordinates], player)
    end
    loop do
      puts 'these are your available moves'
      p available_sqaures(board.squares[selected_square_coordinates].piece, player)
      puts 'where do you want to move'
      destination_square_coordinates = user_input(player)
      break if right_destination_square?(board.squares[selected_square_coordinates].piece,
                                         destination_square_coordinates, player)
    end
    move_piece(board.squares[selected_square_coordinates].piece, selected_square_coordinates,
               destination_square_coordinates)
  end

  private

  def available_sqaures(piece, player)
    piece.valid_moves(player, @board)
  end

  def right_chosen_square?(square, player)
    return true if square.piece && square.piece.type == player.piece_type

    puts 'please select your own piece'
    false
  end

  def right_destination_square?(piece, destination_square_coordinates, player)
    return true if piece.legal_move?(destination_square_coordinates, player, @board)

    puts 'illegal move'
    false
  end

  # def select_square(player)
  #   puts "#{player.name}, choose which piece you want to move using grid"
  #   selected_square = nil
  #   loop do
  #     selected_square = user_input(player)
  #     break if right_chosen_square?(board.squares[selected_square])
  #   end
  #   selected_square
  # end

  def assign_knights
    player1.pieces.concat([Knight.new([0, 2], '♘', 'hollow'), Knight.new([0, 5], '♘', 'hollow')])

    player2.pieces.concat([Knight.new([7, 2], '♞', 'filled'), Knight.new([7, 5], '♞', 'filled')])
  end

  def assign_rooks
    player1.pieces.concat([Rook.new([0, 0], '♖', 'hollow'), Rook.new([0, 7], '♖', 'hollow')])
    player2.pieces.concat([Rook.new([7, 0], '♜', 'filled'), Rook.new([7, 7], '♜', 'filled')])
  end
end

require_relative 'board'
require_relative 'knight'
require_relative 'player'
require_relative 'square'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'

class Game
  attr_accessor :board, :player1, :player2

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @selected_square_coordinates = nil
    @destination_square_coordinates = nil
    @turn = 0
    board_setup
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
    assign_bishops
    assign_queens
    assign_kings
    assign_pawns
  end

  def add_piece(piece)
    selected_square = @board.squares[piece.position]
    selected_square.piece = piece
  end

  def move_piece(piece, from_position, to_position, other_player)
    # this will select the square on which the piece is
    selected_square = board.squares[from_position]
    # this will remove it
    selected_square.piece = nil
    # select new square
    # check if the selected square already contains other players piece
    destination_square = board.squares[to_position]
    remove_player_piece(other_player, destination_square, destination_square.piece) unless destination_square.nil?
    destination_square.piece = piece
    piece.position = to_position
    board.display
  end

  def remove_player_piece(other_player, sqaure, piece)
    return if sqaure.piece.nil?

    other_player.pieces.delete(piece)
  end

  def user_input(player)
    row = nil
    column = nil
    loop do
      puts "#{player.name}, please select row or type 19 to save the game"
      row = valid_input
      return 19 if row == 19

      puts "#{player.name}, please select column"
      puts 'to reset your choice, enter -1 and press enter'
      column = valid_input
      next if column == -1
      break if row.between?(0, 7) && column.between?(0, 7)

      puts 'please choose a number between 0 - 7'
    end
    [row, column]
  end

  def valid_input
    input = gets.chomp
    return -1 if input == '-1'
    return 19 if input == '19'

    begin
      Integer(input)
    rescue StandardError
      -2
    end
  end

  def start
    loop do
      player = @turn.even? ? player1 : player2
      other_player = @turn.even? ? player2 : player1
      turn(player, other_player)
      if checkmate?(other_player)
        puts "#{player.name} has won"
        return
      end
      @turn += 1
    end
  end

  def checkmate?(player)
    player.pieces.each { |piece| return false if piece.instance_of?(King) }
    true
  end

  def turn(player, other_player)
    loop do
      puts 'select the piece you want to move or type 19 to save game'
      @selected_square_coordinates = user_input(player)
      if @selected_square_coordinates == 19
        save_game
        puts 'Game saved. Exiting turn...'
        return # Exit the turn method completely
      end
      if available_sqaures(board.squares[@selected_square_coordinates].piece, player).empty?
        puts 'no moves available, please choose a different square'
        next
      end
      break if right_chosen_square?(board.squares[@selected_square_coordinates], player)
    end
    loop do
      puts 'these are your available moves'
      p available_sqaures(board.squares[@selected_square_coordinates].piece, player)
      puts 'where do you want to move'
      @destination_square_coordinates = user_input(player)
      break if right_destination_square?(board.squares[@selected_square_coordinates].piece,
                                         @destination_square_coordinates, player)
    end
    move_piece(board.squares[@selected_square_coordinates].piece, @selected_square_coordinates,
               @destination_square_coordinates, other_player)
  end

  def save_game
    File.open('saved_game.dat', 'wb') do |file|
      Marshal.dump(self, file)
    end
    puts 'Game has been saved'
    @turn -= @turn
  end

  def self.load_game
    if File.exist?('saved_game.dat')
      File.open('saved_game.dat', 'rb') do |file|
        Marshal.load(file)
      end
    else
      puts 'no saved game found'
      new(Player.new('hollow'), Player.new('filled'))
    end
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
    player1.pieces.concat([Knight.new([0, 1], '♘', 'hollow'), Knight.new([0, 6], '♘', 'hollow')])

    player2.pieces.concat([Knight.new([7, 1], '♞', 'filled'), Knight.new([7, 6], '♞', 'filled')])
  end

  def assign_rooks
    player1.pieces.concat([Rook.new([0, 0], '♖', 'hollow'), Rook.new([0, 7], '♖', 'hollow')])
    player2.pieces.concat([Rook.new([7, 0], '♜', 'filled'), Rook.new([7, 7], '♜', 'filled')])
  end

  def assign_bishops
    player1.pieces.concat([Bishop.new([0, 2], '♗', 'hollow'), Bishop.new([0, 5], '♗', 'hollow')])
    player2.pieces.concat([Bishop.new([7, 2], '♝', 'filled'), Bishop.new([7, 5], '♝', 'filled')])
  end

  def assign_queens
    player1.pieces.concat([Queen.new([0, 3], '♕', 'hollow')])
    player2.pieces.concat([Queen.new([7, 3], '♛', 'filled')])
  end

  def assign_kings
    player1.pieces.concat([King.new([0, 4], '♔', 'hollow')])
    player2.pieces.concat([King.new([7, 4], '♚', 'filled')])
  end

  def assign_pawns
    8.times do |i|
      player1.pieces << Pawn.new([1, i], '♙', 'hollow')
      player2.pieces << Pawn.new([6, i], '♝', 'filled')
    end
  end
end

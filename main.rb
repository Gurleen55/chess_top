require_relative 'lib/player'
require_relative 'lib/game'

player1 = Player.new('Adam', 'hollow')
player2 = Player.new('Eve', 'filled')
game = Game.new(player1, player2)
game.board_setup
game.start

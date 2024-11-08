require_relative 'lib/player'
require_relative 'lib/game'

if File.exist?('saved_game.dat')
  puts 'Do you want to load the saved game? (yes/no)'
  input = gets.chomp.downcase
  game = if input == 'yes'
                 Game.load_game
               else
                 Game.new(Player.new('hollow'), Player.new('filled'))
               end
               game.board.display
else
  game = Game.new(Player.new('hollow'), Player.new('filled'))
end


game.start

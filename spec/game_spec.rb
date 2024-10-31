require_relative '../lib/game'

describe Game do
  let(:player1) { Player.new('Adam', 'hollow') }
  let(:player2) { Player.new('Eve', 'filled') }
  subject { Game.new(player1, player2) }

  describe '#move_piece' do
    let(:knight) { double('Knight', symbol: '♘') }
    xit 'moves the piece to the desired player position' do
      subject.move_piece(knight, [0, 2], [1, 4])
      expect(subject.board.squares[[1, 4]].piece).to equal(knight)
    end
  end

  describe '#board_setup' do
    it 'sets up the board' do
      subject.board_setup
    end
  end
end

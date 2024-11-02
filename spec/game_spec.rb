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

  xdescribe '#user_input' do
    context 'when user selects row 5 and column 7' do
      before do
        allow(subject).to receive(:gets).and_return('5', '7')
      end
      it 'returns the array [5, 7]' do
        expect(subject.user_input(player1)).to eql([5, 7])
      end
    end
    context 'when user selects row 5 and column 8' do
      before do
        allow(subject).to receive(:gets).and_return('5', '8', '5', '7')
      end
      it 'returns the array [5, 7]' do
        expect(subject).to receive(:gets).exactly(4).times
        expect(subject.user_input(player1)).to eql([5, 7])
      end
      context 'when user resets with -1' do
        before do
          allow(subject).to receive(:gets).and_return('5', '-1', '5', '7')
        end
        it 'returns the array [5, 7]' do
          expect(subject).to receive(:gets).exactly(4).times
          expect(subject.user_input(player1)).to eql([5, 7])
        end
      end
    end
  end

  describe '#right_square' do
    context 'when player chooses his own sqaure' do
      it 'returns true' do
        piece = Knight.new([0, 2], '', 'hollow')
        selected_square = subject.board.squares[[0, 2]]
        selected_square.piece = piece
        expect(subject.right_square?(selected_square, player1)).to be true
      end
    end
  end
  describe '#turn' do
    context 'when player does a legal move' do
      it 'moves the selected piece to desired location' do
      end
    end
  end
end

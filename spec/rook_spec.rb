require_relative '../lib/rook'
require_relative '../lib/board'

describe Rook do
  describe '#valid_moves' do
    let(:player1) { double('Player', piece_type: 'hollow') }
    let(:board) { Board.new }

    subject { described_class.new([0, 0], '', 'hollow') }
    context 'when board is empty' do
      it 'returns all the valid moves accoeding to the position' do
        result = subject.valid_moves(player1, board)
        # convert this array to sets
        result = result.sort
        expect(result).to eql [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                               [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]].sort
      end
    end
  end
end

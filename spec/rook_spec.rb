require_relative '../lib/rook'

describe Rook do
  subject { described_class.new([3, 4], '♖', 'hollow') }
  describe '#vaild_moves' do
    it 'returns array of all the valid moves' do
      result = [
        [3, 0], [3, 1], [3, 2], [3, 3], [3, 5], [3, 6], [3, 7],
        [0, 4], [1, 4], [2, 4], [4, 4], [5, 4], [6, 4], [7, 4]
      ]
      expect(subject.valid_moves).to eql(result)
    end

    it 'returns array of all the valid moves' do
      subject = described_class.new([0, 0], '♖', 'hollow')
      result = [
        [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
        [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]
      ]
      expect(subject.valid_moves).to eql(result)
    end
  end
end

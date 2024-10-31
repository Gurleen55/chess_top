require_relative 'square'
require_relative 'knight'

# this class will create a squares with co-ordinates that will represent chess board
class Board
  attr_accessor :squares

  def initialize
    @squares = {}
    8.times do |i|
      8.times do |j|
        @squares[[i, j]] = Square.new(i, j)
      end
    end
    connect_squares
  end

  # def connect_squares
  #   directions = [
  #     [-1, 0], [1, 0], # horizontal neighbours
  #     [0, -1], [0, 1], # vertical negihbours
  #     [-1, -1], [-1, 1], [1, -1], [1, 1] # diagonal neighbours
  #   ]

  #   @squares.each do |(i, j), square|
  #     directions.each do |di, dj|
  #       ni = i + di
  #       nj = j + dj
  #       square.add_adjacent_squares(@squares[[ni, nj]]) if ni.between?(0, 7) && nj.between?(0, 7)
  #     end
  #   end
  # end

  def display
    7.downto(0) do |i|
      row = ''
      8.times do |j|
        row += (@squares[[i, j]]).to_s
      end
      puts row.strip
    end
  end
end

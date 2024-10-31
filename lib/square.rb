# frozen_string_literal: true

# this class will create square box that will be used in chess
class Square
  attr_accessor :x, :y, :adjacent_sqaures, :piece

  # ASNI color codes
  PURPLE = "\e[45m"
  GREY = "\e[105m"

  def initialize(x, y)
    @x = x
    @y = y
    @adjacent_sqaures = []
    @color = (x + y).even? ? GREY : PURPLE
  end

  def add_adjacent_squares(square)
    return if @adjacent_sqaures.include?(square)

    @adjacent_sqaures << square
    square.add_adjacent_squares(self)
  end

  def show_adjacent_squares
    @adjacent_sqaures.map { |square| "(#{square.x}, #{square.y})" }
  end

  def to_s
    "#{@color} #{piece.nil? ? ' ' : piece.symbol} \e[0m"
  end
end

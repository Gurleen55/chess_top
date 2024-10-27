class Square
  attr_accessor :x, :y, :adjacent_sqaures

  def initialize(x, y)
    @x = x
    @y = y
    @adjacent_sqaures = []
  end

  def add_adjacent_squares(square)
    return if @adjacent_sqaures.include?(square)

    @adjacent_sqaures << square
    square.add_adjacent_squares(self)
  end

  def show_adjacent_squares
    @adjacent_sqaures.map { |square| "(#{square.x}, #{square.y})" }
  end
end

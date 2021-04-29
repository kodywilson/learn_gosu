# Player sprite classa
class Player
  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0.0
    @image = Gosu::Image.new('images/ship.png')
  end

  def draw
    @image.draw_rot(@x, @y, @angle)
  end

  def turn_right
    @angle += 3.0
  end

  def turn_left
    @angle -= 3.0
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end

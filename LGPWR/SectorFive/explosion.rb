# BOOM!

class Explosion

  attr_reader :finished, :x, :y, :radius

  def initialize(window, x, y)
    @x = x
    @y = y
    @radius = 30
    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
    @image_index = 0
    @finished = false
    @counter = 0
  end

  def draw
    if @image_index < @images.count
      @images[@image_index].draw(@x - @radius, @y - @radius, 2)
      @image_index += 1 if @counter % 3 == 0
      @counter += 1
    else
      @finished = true
    end
  end

end


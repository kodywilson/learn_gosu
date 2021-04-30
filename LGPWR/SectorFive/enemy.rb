# Enemy ships!

class Enemy

  SPEED = 3

  attr_reader :x, :y, :radius

  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/enemy.png')
    @wandering = false
    @wandirection = 'center'
    @timer = 0
  end

  def move
    @y += SPEED
    unless @wandering
      chance = rand(100)
      if chance < 80
        @wandering = true
        @timer = Gosu.milliseconds
        @wandirection = 'left' if chance < 40
        @wandirection = 'right' if chance > 39 && chance < 80
      end
    end
    if @wandering == true && @timer + 500 > Gosu.milliseconds
      @x -= 1 if @wandirection == 'left'
      @x += 1 if @wandirection == 'right'
    else
      @wandering = false
      @wandirection = 'center'
    end
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

end

require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window

  WIDTH = 1024
  HEIGHT = 768
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @background_image = Gosu::Image.new('images/start_screen.png')
    @scene = :start
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
  end

  def needs_cursor?
    false
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push(Bullet.new(self, @player.x, @player.y, @player.angle))
    end
  end

  def update_game
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
    @enemies.push(Enemy.new(self)) if rand < ENEMY_FREQUENCY
    @enemies.each { |enemy| enemy.move }
    @bullets.each { |bullet| bullet.move }
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push(Explosion.new(self, enemy.x, enemy.y))
        end
        @bullets.delete bullet unless bullet.onscreen?
      end
      @explosions.dup.each do |explosion|
        @explosions.delete explosion if explosion.finished
        boom_distance = Gosu.distance(enemy.x, enemy.y, explosion.x, explosion.y)
        if boom_distance < enemy.radius + explosion.radius
          @enemies.delete enemy
          @explosions.push(Explosion.new(self, enemy.x, enemy.y))
        end
      end
      @enemies.delete enemy if enemy.y > HEIGHT + enemy.radius
    end
  end

  def update_end
  end

  def update
    case @scene
    when :game
      update_game
    when :end
      update_end
    end
  end

  def draw_start
    @background_image.draw(0,0,0,scale_x = 1.3,scale_y = 1.3)
  end

  def draw_game
    @player.draw
    @enemies.each { |enemy| enemy.draw }
    @bullets.each { |bullet| bullet.draw }
    @explosions.each { |explosion| explosion.draw }
  end

  def draw_end
  end


  def draw
    case @scene
    when :start
      draw_start
    when :game
      draw_game
    when :end
      draw_end
    end
  end

end

window = SectorFive.new
window.show


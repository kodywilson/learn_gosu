require 'gosu'
require_relative 'player'
require_relative 'enemy'

class SectorFive < Gosu::Window

  WIDTH = 1024
  HEIGHT = 768
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
    @enemies.push(Enemy.new(self)) if rand < ENEMY_FREQUENCY
    @enemies.each { |enemy| enemy.move }
  end

  def draw
    @player.draw
    @enemies.each { |enemy| enemy.draw }
  end
end

window = SectorFive.new
window.show


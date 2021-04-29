require 'gosu'
require_relative 'player'

class SectorFive < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Sector Five'
    @player = Player.new(self)
  end

  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
  end

  def draw
    @player.draw
  end
end

window = SectorFive.new
window.show


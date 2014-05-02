require 'io/console'
require './game.rb'
require './grid.rb'
require './tile.rb'

@grid = []

def main
  newGame
  pp

  play = true
  while play do
    input = STDIN.getch.downcase
    case input
    when /[wasd]/
      move input
      pp
    when /[q]/
      play = false
    when /[c]/  # cheat
      @grid[0][0] = 2048
      pp
    else
      # do_nothing
    end

    if win
      puts "You Win..!!!!!!!"
      play = false
    end
    if lose
      puts "Game over.."
      play = false
    end
  end
end

main
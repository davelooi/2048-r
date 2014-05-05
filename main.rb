require 'io/console'
require './game.rb'
require './grid.rb'

def main
  game = Game.new
  pp game.grid, game.score

  play = true
  while play do
    input = STDIN.getch.downcase
    case input
    when /[wasd]/
      game.move input
      pp game.grid, game.score
    when /[q]/
      play = false
    when /[c]/  # cheat
      game.cheat
      pp game.grid, game.score
    else
      # do_nothing
    end

    if game.win
      puts "You Win..!!!!!!!"
      play = false
    end
    if game.lose
      puts "Game over.."
      play = false
    end
  end
end

def pp grid, score
  printGrid grid
  puts "== SCORE : #{score}"
end

def printGrid grid
  system "clear"
  puts "WASD to play, Q to quit, C to cheat"
  puts "+---------------------------+"
  grid.each do |row|
    print "|"
    row.each do |col|
      if col == 0
        print "      |"
      else
        print " %4d |" % [col]
      end
    end
    print "\n"
    puts "+---------------------------+"
  end
end



main
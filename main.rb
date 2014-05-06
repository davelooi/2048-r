require 'io/console'
require './game.rb'

def main
  game = Game.new
  pp game.grid, game.score

  play = true
  while play do
    input = STDIN.getch.downcase
    case input
    when /[w]/
      game.move "up"
    when /[a]/
      game.move "left"
    when /[s]/
      game.move "down"
    when /[d]/
      game.move "right"
    when /[q]/
      play = false
    when /[c]/  # cheat
      game.cheat
    else
      # do_nothing
    end
    pp game.grid, game.score

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
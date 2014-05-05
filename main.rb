require 'io/console'
require './game.rb'
require './grid.rb'

@grid = []

def main
  game = Game.new
  pp game.grid

  play = true
  while play do
    input = STDIN.getch.downcase
    case input
    when /[wasd]/
      game.move input
      pp game.grid
    when /[q]/
      play = false
    when /[c]/  # cheat
      game.cheat
      pp game.grid
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

def pp grid
  system "clear"
  puts "WASD to play, Q to quit"
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
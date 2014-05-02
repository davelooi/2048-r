def pp
  system "clear"
  puts "WASD to play, Q to quit"
  puts "+---------------------------+"
  @grid.each do |row|
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

def newGrid
  [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
end

def gridAntiClockwise
  @grid = @grid.transpose.reverse
end

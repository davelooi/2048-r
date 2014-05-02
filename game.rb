def newGame
  @grid = newGrid
  2.times{ addNewTile }
end

def win
  @grid.flatten.max == 2048
end

def lose
  return false
end

def move direction
  case direction
  when /w/
    move_up
  when /a/
    move_left
  when /s/
    move_down
  when /d/
    move_right
  end
  addNewTile
end

def move_up
  gridAntiClockwise
  move_left
  gridAntiClockwise
  gridAntiClockwise
  gridAntiClockwise
end

def move_left
  shift_left
  merge_equal
  shift_left
end

def move_down
  gridAntiClockwise
  gridAntiClockwise
  gridAntiClockwise
  move_left
  gridAntiClockwise
end

def move_right
  gridAntiClockwise
  gridAntiClockwise
  move_left
  gridAntiClockwise
  gridAntiClockwise
end

def shift_left
  (0..3).each do |row|
    @grid[row].delete_if { |x| x == 0 }
    (4-@grid[row].count).times { @grid[row].push 0 }
  end
end

def merge_equal
  (0..3).each do |row|
    (0..2).each do |col|
      if @grid[row][col] == @grid[row][col+1]
        @grid[row][col] = @grid[row][col] * 2
        @grid[row][col+1] = 0
      end
    end
  end
end

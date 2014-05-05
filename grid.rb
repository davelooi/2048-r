class Grid
  attr_accessor :grid

  ### new
  def initialize
    @grid = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
  end

  ### add a random new number in an empty random new tile
  def addNewTile
    assignNewTile rand(0..countZero-1)
  end

  def assignNewTile count
    (0..3).each do |row|
      (0..3).each do |col|
        if @grid[row][col] == 0
          if count == 0
            @grid[row][col] = rand(1..2) * 2
          end
          count-=1
        end
      end
    end
  end

  def countZero
    count = 0
    @grid.each do |row|
      row.each do |col|
        if col == 0
          count+=1
        end
      end
    end
    count
  end

  ##############
  ### le GAME
  ##############
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

  ### test possible move
  def testMove
    4.times do
      move_left
      gridAntiClockwise
    end
  end

  ### Rotate the grid anti-clockwise
  def gridAntiClockwise
    @grid = @grid.transpose.reverse
  end

  ### Move
  def move_left
    shift_left
    merge_equal
    shift_left
  end

  def move_right
    gridAntiClockwise
    gridAntiClockwise
    move_left
    gridAntiClockwise
    gridAntiClockwise
  end

  def move_up
    gridAntiClockwise
    move_left
    gridAntiClockwise
    gridAntiClockwise
    gridAntiClockwise
  end

  def move_down
    gridAntiClockwise
    gridAntiClockwise
    gridAntiClockwise
    move_left
    gridAntiClockwise
  end
end

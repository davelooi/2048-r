class Grid
  attr_accessor :grid
  attr_accessor :score

  ### new
  def initialize
    @grid = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    @score = 0
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
    counts = Hash.new 0
    @grid.flatten.each do |number|
      counts[number] += 1
    end
    counts[0]
  end

  ##############
  ### le GAME
  ##############
  def shiftLeft
    (0..3).each do |row|
      @grid[row].delete_if { |x| x == 0 }
      (4-@grid[row].count).times { @grid[row].push 0 }
    end
  end

  def mergeEqual
    (0..3).each do |row|
      (0..2).each do |col|
        if @grid[row][col] == @grid[row][col+1]
          @grid[row][col] = @grid[row][col] * 2
          @grid[row][col+1] = 0
          @score += @grid[row][col]
        end
      end
    end
  end

  ### test possible move
  def possibleMove?
    # backup original grid
    tempGrid = @grid.clone

    # test moves on all angle
    4.times do
      moveLeft
      gridAntiClockwise
    end

    # nothing moved, means no possible move
    if @grid == tempGrid
      # game lost
      return false
    end

    # restore original grid
    @grid = tempGrid
    return true
  end

  ### Rotate the grid anti-clockwise
  def gridAntiClockwise
    @grid = @grid.transpose.reverse
  end

  ### Move
  def moveLeft
    shiftLeft
    mergeEqual
    shiftLeft
  end

  def moveRight
    gridAntiClockwise
    gridAntiClockwise
    moveLeft
    gridAntiClockwise
    gridAntiClockwise
  end

  def moveUp
    gridAntiClockwise
    moveLeft
    gridAntiClockwise
    gridAntiClockwise
    gridAntiClockwise
  end

  def moveDown
    gridAntiClockwise
    gridAntiClockwise
    gridAntiClockwise
    moveLeft
    gridAntiClockwise
  end
end

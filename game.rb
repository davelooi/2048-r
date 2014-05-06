class Game
  attr_accessor :grid
  attr_accessor :score

  ###########
  # new
  ###########
  def initialize (startTiles=2)
    @grid = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    @score = 0
    # setup initial grid
    startTiles.times{ addNewTile }
  end

  ############
  # New Tile
  ############
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

  ###########
  # Move
  ###########
  def move direction
    case direction
    when /up/i
      moveUp
    when /left/i
      moveLeft
    when /down/i
      moveDown
    when /right/i
      moveRight
    end
    addNewTile
  end

  def moveLeft (addToScore=true)
    shiftLeft
    score = mergeEqual
    @score += score if addToScore
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

  def gridAntiClockwise
    @grid = @grid.transpose.reverse
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
    addedTileScore = 0
    (0..3).each do |row|  # each row
      (0..2).each do |col|  # each col except the last
        if @grid[row][col] == @grid[row][col+1]
          @grid[row][col] = @grid[row][col] * 2
          @grid[row][col+1] = 0
          addedTileScore += @grid[row][col]
        end
      end
    end
    return addedTileScore
  end

  ############
  # win/lose
  ############
  def win
    @grid.flatten.max == 2048
  end

  def lose
    if @grid.flatten.include?(0)
      return false
    end

    return !possibleMove?
  end

  def possibleMove?
    # backup original grid
    tempGrid = @grid.clone

    # test moves on all angle
    4.times do
      moveLeft(false)
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

  ############
  # CHEAT
  ############
  def cheat
    @grid[0][0] = 2048
  end
end


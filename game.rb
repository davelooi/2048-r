class Game
  def initialize (startTiles=2)
    @grid = Grid.new
    # setup initial grid
    startTiles.times{ @grid.addNewTile }
  end

  def grid
    @grid.grid
  end

  def grid=(g)
    @grid.grid = g
  end

  def score
    @grid.score
  end

  def win
    grid.flatten.max == 2048
  end

  def lose
    if grid.flatten.include?(0)
      return false
    end

    return !@grid.possibleMove?
  end

  def move direction
    case direction
    when /w/
      @grid.moveUp
    when /a/
      @grid.moveLeft
    when /s/
      @grid.moveDown
    when /d/
      @grid.moveRight
    end
    @grid.addNewTile
  end

  def cheat
    @grid.grid[0][0] = 2048
  end
end

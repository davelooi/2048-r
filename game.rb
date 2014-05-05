class Game
  def initialize
    @grid = Grid.new
    2.times{ @grid.addNewTile }
  end

  def grid
    @grid.grid
  end

  def win
    grid.flatten.max == 2048
  end

  def lose
    if grid.flatten.include?(0)
      return false
    end

    # backup original grid
    tempGrid = @grid.clone

    # test moves
    tempGrid.testMove

    # nothing moved, means no possible move
    if @grid.grid == tempGrid.grid
      # game lost
      return true
    end

    return false
  end

  def move direction
    case direction
    when /w/
      @grid.move_up
    when /a/
      @grid.move_left
    when /s/
      @grid.move_down
    when /d/
      @grid.move_right
    end
    @grid.addNewTile
  end

  def cheat
    grid[0][0] = 2048
  end
end

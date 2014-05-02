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


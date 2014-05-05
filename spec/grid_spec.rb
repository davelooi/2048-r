require './grid'

describe Grid do
  context "when new" do
    let(:grid) { Grid.new }
    it "should create a new grid" do
      expect(grid.is_a?(Grid)).to be_true
    end
    it "should create a new array" do
      expect(grid.grid.is_a?(Array)).to be_true
    end
    it "should have 16 zero" do
      grid.countZero.should == 16
    end
  end

  context "when addNewTile" do
    let(:grid) { Grid.new }
    it "should have 1 non-zero number" do
      grid.addNewTile
      grid.countZero.should == 15
    end
  end

  context "when shiftLeft" do
    before(:all) do
      @grid = Grid.new
                           # BEFORE  # EXPECTED
      @before_and_after = [[0,0,0,0],[0,0,0,0],
                           [0,0,0,2],[2,0,0,0],
                           [0,0,2,0],[2,0,0,0],
                           [0,0,2,2],[2,2,0,0],
                           [0,2,0,0],[2,0,0,0],
                           [0,2,0,2],[2,2,0,0],
                           [0,2,2,0],[2,2,0,0],
                           [0,2,2,2],[2,2,2,0],
                           [2,0,0,0],[2,0,0,0],
                           [2,0,0,2],[2,2,0,0],
                           [2,0,2,0],[2,2,0,0],
                           [2,0,2,2],[2,2,2,0],
                           [2,2,0,0],[2,2,0,0],
                           [2,2,0,2],[2,2,2,0],
                           [2,2,2,0],[2,2,2,0],
                           [2,2,2,2],[2,2,2,2]]
    end
    it "should shift tiles to the left" do
      while !@before_and_after.empty? do
        @grid.grid[0] = @before_and_after.shift
        @grid.shiftLeft
        @grid.grid[0].should == @before_and_after.shift
      end
    end
  end

  context "when mergeEqual" do
    before(:all) do
      @grid = Grid.new
      @before_and_after = [[0,0,0,0],[0,0,0,0],
                           [0,0,0,2],[0,0,0,2],
                           [0,0,2,0],[0,0,2,0],
                           [0,0,2,2],[0,0,4,0],
                           [0,2,0,0],[0,2,0,0],
                           [0,2,0,2],[0,2,0,2],
                           [0,2,2,0],[0,4,0,0],
                           [0,2,2,2],[0,4,0,2],
                           [2,0,0,0],[2,0,0,0],
                           [2,0,0,2],[2,0,0,2],
                           [2,0,2,0],[2,0,2,0],
                           [2,0,2,2],[2,0,4,0],
                           [2,2,0,0],[4,0,0,0],
                           [2,2,0,2],[4,0,0,2],
                           [2,2,2,0],[4,0,2,0],
                           [2,2,2,2],[4,0,4,0]]
    end
    it "should merge 2 tile with same value" do
      while !@before_and_after.empty? do
        @grid.grid[0] = @before_and_after.shift
        @grid.mergeEqual
        @grid.grid[0].should == @before_and_after.shift
      end
    end
  end

  context "when rotate gridAntiClockwise" do
    before(:all) do
      @grid = Grid.new
      @grid.grid = [[0,  2,  4,   8   ],
                    [16, 32, 64,  128 ],
                    [256,512,1024,2048],
                    [0,  0,  0,   0   ]]
    end
    it "should rotate the grid antiClockwise" do
      afterRotate = [[8, 128,2048,0],
                     [4, 64, 1024,0],
                     [2, 32, 512, 0],
                     [0, 16, 256, 0]]
      @grid.gridAntiClockwise.should == afterRotate
    end
  end

  context "when possibleMove?" do
    before(:all) do
      @grid = Grid.new
      @grid.grid = [[2,4,2,4],
                    [4,2,4,2],
                    [2,4,2,4],
                    [4,2,4,2]]
    end
    it "should fail if no possible move" do
      @grid.possibleMove?.should be_false
    end
  end
end

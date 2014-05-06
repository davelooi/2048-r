require './game'

describe Game do
  context "when new" do
    let(:game) { Game.new(0) }
    it "should return a new Game" do
      expect(game.is_a?(Game)).to be_true
    end
    it "should create a new array" do
      expect(game.grid.is_a?(Array)).to be_true
    end
    it "should create an empty array" do
      game.countZero.should == 16
    end
    it "should start with score 0" do
      game.score.should == 0
    end
  end

  context "when addNewTile" do
    let(:game) { Game.new }
    it "should have 1 less non-zero number" do
      start = game.countZero
      game.addNewTile
      game.countZero.should == start - 1
    end
  end

  context "when win" do
    it "should contain a 2048 tile" do
      game = Game.new
      game.cheat  # sets a tile to 2048
      game.win.should be_true
    end
  end

  context "when lose" do
    it "should have no possible move" do
      game = Game.new(0)
      game.grid = [[2,4,2,4],
                   [4,2,4,2],
                   [2,4,2,4],
                   [4,2,4,2]]
      game.possibleMove?.should be_false
      game.lose.should be_true
    end
  end

  context "when shiftLeft" do
    before(:all) do
      @game = Game.new
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
        @game.grid[0] = @before_and_after.shift
        @game.shiftLeft
        @game.grid[0].should == @before_and_after.shift
      end
    end
  end

  context "when mergeEqual" do
    before(:all) do
      @game = Game.new(0)
      @before_and_after = [[0,0,0,0],0,[0,0,0,0],
                           [0,0,0,2],0,[0,0,0,2],
                           [0,0,2,0],0,[0,0,2,0],
                           [0,0,2,2],4,[0,0,4,0],
                           [0,2,0,0],0,[0,2,0,0],
                           [0,2,0,2],0,[0,2,0,2],
                           [0,2,2,0],4,[0,4,0,0],
                           [0,2,2,2],4,[0,4,0,2],
                           [2,0,0,0],0,[2,0,0,0],
                           [2,0,0,2],0,[2,0,0,2],
                           [2,0,2,0],0,[2,0,2,0],
                           [2,0,2,2],4,[2,0,4,0],
                           [2,2,0,0],4,[4,0,0,0],
                           [2,2,0,2],4,[4,0,0,2],
                           [2,2,2,0],4,[4,0,2,0],
                           [2,2,2,2],8,[4,0,4,0]]
    end
    it "should merge 2 tile with same value and add to the score" do
      while !@before_and_after.empty? do
        @game.grid[0] = @before_and_after.shift
        @game.mergeEqual.should == @before_and_after.shift
        @game.grid[0].should == @before_and_after.shift
      end
    end
  end

  context "when rotate gridAntiClockwise" do
    before(:all) do
      @game = Game.new
      @game.grid = [[0,  2,  4,   8   ],
                    [16, 32, 64,  128 ],
                    [256,512,1024,2048],
                    [0,  0,  0,   0   ]]
    end
    it "should rotate the grid antiClockwise" do
      afterRotate = [[8, 128,2048,0],
                     [4, 64, 1024,0],
                     [2, 32, 512, 0],
                     [0, 16, 256, 0]]
      @game.gridAntiClockwise.should == afterRotate
    end
  end
end

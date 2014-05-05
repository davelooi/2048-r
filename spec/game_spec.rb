require './game'

describe Game do
  context "when new" do
    it "should return a new Game" do
      game = Game.new
      expect(game.is_a?(Game)).to be_true
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
      game = Game.new
      game.grid = [[2,4,2,4],
                   [4,2,4,2],
                   [2,4,2,4],
                   [4,2,4,2]]
      game.lose.should be_true
    end
  end
end

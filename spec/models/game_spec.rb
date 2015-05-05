require 'spec_helper'

describe Game do
  before do
    @test_game = Game.new
  end

  describe "board" do
    it "initialized with nil values inside of the array, [[]]" do
      expect(@test_game.board).to eq( [[nil, nil, nil],
                                       [nil, nil, nil],
                                       [nil, nil, nil]] )
    end

    it "always have a length of 3" do
     expect(@test_game.board.length).to eq(3)
    end

    it "always have the array within the array length of 3" do
      @test_game.board.each { |array| expect(array.length).to eq(3) }
    end
  end

  describe "update_board" do
    it "establish a position on the board, using 'x' or 'o'" do
      @test_game.update_board('x', 0, 1)
      expect(@test_game.board[0][1]).to  eq('x')
    end

    it "does not allow players other than 'x' and 'o'" do
      lambda { @test_game.update_board('y', 0, 0) }.should raise_error(ArgumentError)
    end

    it "does not allow positions outside the 3x3 board" do
      lambda { @test_game.update_board('x', 4, 0) }.should raise_error(ArgumentError)
    end

    it "does not allow an 'x' or 'o' to be inserted into an already full spot" do
      puts 111111
      @test_game.update_board('x', 0, 0)
      lambda { @test_game.update_board('x', 0, 0) }.should raise_error(ArgumentError)
    end

    it "is saved to the database" do
      @test_game.update_board('x', 2, 1)
      saved_game = Game.all.find { |g| g.id == @test_game.id }
      expect(saved_game.display_element(2, 1)).to eq('x')
    end
  end

  describe "current_player" do
    it "sets even turns to player 'x' " do
      expect(@test_game.current_player).to eq('x')
    end

    it "sets odd turns to player 'o' " do
      @test_game.play(2, 0)
      expect(@test_game.current_player).to eq('o')
    end
  end

  describe "play" do
    it "sets the first player, 'x', to a position on the board" do
      @test_game.play(0, 1)
      expect(@test_game.board).to eq( [[nil, 'x', nil],
                                      [nil, nil, nil],
                                      [nil, nil, nil]] )
    end

    it "sets the second player, 'o', to a position on the board" do
      @test_game.play(0, 1)
      @test_game.play(2, 1)
      expect(@test_game.board).to eq( [[nil, 'x', nil],
                                      [nil, nil, nil],
                                      [nil, 'o', nil]] )
    end

    it "determines that player 'x' won with a message!" do
      @test_game.play(0,0)
      @test_game.play(1,0)
      @test_game.play(0,1)
      @test_game.play(1,1)
      @test_game.play(0,2)
      expect( @test_game.play(1,2) ).to eq("Player x is the winner!")
    end

    it "determines that player 'o' won with a message!" do
      @test_game.play(1,0)
      @test_game.play(0,0)
      @test_game.play(0,1)
      @test_game.play(1,1)
      @test_game.play(0,2)
      @test_game.play(2,2)
      expect( @test_game.play(1,2) ).to eq("Player o is the winner!")
    end
  end

  describe "winner" do
    it "returns 'x' the first row is filled with x's" do
      @test_game.update_board('x', 0, 0)
      @test_game.update_board('x', 0, 1)
      @test_game.update_board('x', 0, 2)

      expect(@test_game.winner).to eq'x'
    end

    it "returns 'd' if the second row is filled with o's" do
      @test_game.update_board('o', 1, 0)
      @test_game.update_board('o', 1, 1)
      @test_game.update_board('o', 1, 2)

      expect(@test_game.winner).to eq('o')
    end

    it "returns nil if elements in any row are not the same" do
      @test_game.update_board('x', 0, 0)
      @test_game.update_board('o', 0, 1)
      @test_game.update_board('x', 0, 2)

      expect(@test_game.winner).to be_nil
    end

    it "returns nil if elements are all still nil" do
      expect(@test_game.winner).to be_nil
    end

    it "returns the letter if all elements in a column are filled with the same letter" do
      @test_game.update_board('x', 0, 0)
      @test_game.update_board('x', 1, 0)
      @test_game.update_board('x', 2, 0)

      expect(@test_game.winner).to eq('x')
    end

    it "returns nil if all elements in a column are nil" do
      expect(@test_game.winner).to be_nil
    end

    it "returns 'x' if there are three x's in a row at a slant from left to right" do
      @test_game.update_board('x', 0, 0)
      @test_game.update_board('x', 1, 1)
      @test_game.update_board('x', 2, 2)

      expect(@test_game.winner).to eq('x')
    end

    it "returns 'x' if there are three x's in a row at a slant from left to right" do
      @test_game.update_board('x', 0, 2)
      @test_game.update_board('x', 1, 1)
      @test_game.update_board('x', 2, 0)

      expect(@test_game.winner).to eq('x')
    end
  end
end

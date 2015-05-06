require 'spec_helper'

describe GamesHelper do
  before do
    @test_game = Game.new
  end

  describe "#display_element" do
    it "should display @board element" do
      @test_game.update_board('x', 0, 1)

      expect(@test_game.display_element(0,1)).to eq('x')
    end

    it "should display a space if the element is nil" do

      expect(@test_game.display_element(0,0)).to eq(' ')
    end

    it "should display an 'x' or an 'o' if the element is not a space" do
      @test_game.update_board('x', 0, 1)

      expect(@test_game.display_element(0,1)).to eq('x')
    end
  end

  describe "#create_cell_class" do
    context "#build_row_0_and_columns / case when 0" do
      it "creates the first row and the first column " do
        @test_game.update_board('x', 0, 0)

        expect(@test_game.create_cell_class(0, 0)).to eq('top left')

      end

      it "creates the first row and the second column" do
        @test_game.update_board('x', 0, 1)

        expect(@test_game.create_cell_class(0, 1)).to eq('top vertical-mid')
      end

      it "creates the first row and the third column" do
        @test_game.update_board('x', 0, 2)

        expect(@test_game.create_cell_class(0, 2)).to eq('top right')
      end
    end

    context "#build_row_1_and_columns case / when 1" do
      it "creates the second row and the first column" do
        @test_game.update_board('x', 1, 0)
        expect(@test_game.create_cell_class(1, 0)).to eq('left horizontal-mid')
      end

      it "creates the second row and the second column" do
        @test_game.update_board('x', 1, 1)
        expect(@test_game.create_cell_class(1, 1)).to eq('vertical-mid horizontal-mid')
      end

      it "create the second row and the third column" do
        @test_game.update_board('x', 1, 2)
        expect(@test_game.create_cell_class(1, 2)).to eq('right horizontal-mid')
      end
    end


    context "#build_row_2_and_columns Case / when 2" do
      it "creates the third row and the first column" do
        @test_game.update_board('x', 2, 0)
        expect(@test_game.create_cell_class(2, 0)).to eq('left bottom')
      end

      it "creates the third row and the second column" do
        @test_game.update_board('x', 2, 1)
        expect(@test_game.create_cell_class(2, 1)).to eq('bottom vertical-mid')
      end

      it "create the third row and the third column" do
        @test_game.update_board('x', 2, 2)
        expect(@test_game.create_cell_class(2, 2)).to eq('bottom right')
      end
    end
  end
end
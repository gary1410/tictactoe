require 'rails_helper'

describe GamesController do

  describe "games#new" do
    before :each do
      @game = Game.new
    end

    let(:request) { get :new }

    it "sets the @game variable to a new game" do
      request
      expect(assigns[:game].try(:kind_of?, Game) ).to be_truthy
    end

    it "creates and save a new game in the database" do
     expect{get :new, game: @game }.to change(Game, :count).by(1)
    end

    it "redirects to show" do
      expect(request).to redirect_to(game_path(Game.last.id))
    end

  end

  describe "games#show" do
    describe 'with valid params' do
      before(:each) do
        g = Game.new
        g.save

        @game_id = g.id
        get :show, :id => @game_id
      end

      it 'set the @game instance variable' do
        expect( assigns[:game].try(:kind_of?, Game) ).to be_truthy
        expect(assigns[:game]).to eq(Game.find(@game_id))
      end
    end

    describe 'with invalid params' do
      invalid_id = Game.last.nil? ? 1 : (Game.last.id + 1)
      let(:request) { get :show, :id => 1 }

      it "does not create a new game object" do
        expect_any_instance_of(Game).to_not receive(:initialize)
        expect { request }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "does not create a new game in the database" do
        # need to nest the expect so we don't crash before checking count
        lambda { expect { request }.to raise_error(ActiveRecord::RecordNotFound) }.should_not change(Game, :count)
      end

    end
  end

  describe "games#update" do
   let(:request) { put :update, :id => @game.id, :game => { :row => 0, :column => 1 } }

    before(:each) do
      @game = Game.new
      @game.save!
    end

    it "enters a value into the board" do
      expect_any_instance_of(Game).to receive(:play).with(0,1)
      request
    end

    it "enters a redirect to show" do
      expect(request).to redirect_to(game_path(Game.last.id))
    end


  end
end

class GamesController < ApplicationController

  def index
  end

  # we want this method to redirect to show
  def new
    @game = Game.new
    @game.save
    redirect_to game_path(@game.id)
  end

  def show
    @game = Game.find(params[:id])
  end

  #submit to the partial _board_form
  def update
    @game = Game.find(params[:id])
    @game.play(params[:game][:row].to_i,params[:game][:column].to_i)
    redirect_to game_path(@game.id)
    if @game.winner
      flash[:success] = "Player #{@game.winner} is the winner!"
    end
  end

end

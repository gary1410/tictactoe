require 'spec_helper'

feature "A user can click on a link to a new game of tictactoe" do
  scenario "User visits the index page that will lead them to a new game" do
    visit root_path
    expect(page).to have_content("Let's Play TicTacToe!")
  end

  scenario 'are diplayed for a specific game' do
      visit root_path
      click_link 'Start TicTacToe!'
      expect(page).to have_content('Play Game')
  end
end

feature "User is taken to the game" do
  before :each do
    @game = Game.new
    @game.save
    visit game_path(@game.id)
  end

  context 'from the show page' do
    scenario "user can click on a button and it should display test" do
       within '.top.left' do
         find("input[type='submit']").click
       end
      expect(page).to have_selector('td'), text: 'x'
    end
  end

    scenario 'user sees the cells' do
      @game.update_board('x', 0, 1)
      page.has_css?(".top .left")
    end
end
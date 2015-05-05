class Game < ActiveRecord::Base
  # Saves the board in the database as an object,
  # and allows you to retrieve as the same object - important when updating.  Board doesn't work without this.
  serialize :board
  include GamesHelper

  validates :board, :presence => true

  # Updates the board based on player, row, and column
  def update_board(player, row, column)
    unless player.in? %w(o x)
      raise ArgumentError, "Player must be either 'x' or 'o'."
    end

    unless row.in?(0..2) && column.in?(0..2)
      raise ArgumentError, "Row and Column must be within range. (0-2)"
    end

    if board[row][column]
      raise ArgumentError, "This spot is full."
    else
      board[row][column] = player
      self.save!
    end
  end

  # Returns the current_player
  # @return [String] 'x' or 'o'
  def current_player
    turn_num = self.board.flatten.compact.count
    if turn_num.even?
      'x'
    else
      'o'
    end
  end

  # Plays the game
  # calls on update_board and winner
  def play(row, column)
    if winner
      "Player #{winner} is the winner!"
    else
      update_board(current_player, row, column)
    end
  end

  # Checks if there is a winner.
  # @return [Boolean] returns true if there is a winner, false otherwise
  def winner
    check_rows_for_winner || check_columns_for_winner || check_diagonals_for_winner
  end

  private

  def check_rows_for_winner
    board.each do |a|
      if a[0]
        if a[0] == a[1] && a[0] == a[2]
          return a[0]
        end
      end
    end
    nil
  end

  def check_columns_for_winner
    (0..2).each do |e|
      if board[0][e]
        if board[0][e] == board[1][e] && board[0][e] == board[2][e]
          return board[0][e]
        end
      end
    end
    nil
  end

  def check_diagonals_for_winner
    if board[1][1]
      if board[0][0] == board[1][1] && board[0][0] == board[2][2]
        return board[1][1]
      end
      if board[0][2] == board[1][1] && board[0][2] == board[2][0]
        return board[1][1]
      end
    end
    return nil
  end

end

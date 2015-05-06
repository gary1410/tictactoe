module GamesHelper

  def display_element(row, column)
    element = board[row][column]
    if element
      element
    else
      ' '
    end
  end

  def create_cell_class(row, column)
    row_number = case row
      when 0 then check_row_0(row, column)
      when 1 then check_row_1(row, column)
      when 2 then check_row_2(row, column)
    end
  end

  private

  def check_row_0(row, column)
    case row
      when 0
        case column
        when 0
          'top left'
        when 1
          "top vertical-mid"
        when 2
          "top right"
        end
    end
  end

  def check_row_1(row, column)
     case row
      when 1
        case column
        when 0
          "left horizontal-mid"
        when 1
          "vertical-mid horizontal-mid"
        when 2
          "right horizontal-mid"
        end
      end
  end

  def check_row_2(row, column)
    case row
     when 2
      case column
        when 0
          "left bottom"
        when 1
          "bottom vertical-mid"
        when 2
          "bottom right"
        end
      end
  end

end

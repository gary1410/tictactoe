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

    when 1

      case column
      when 0
        "left horizontal-mid"
      when 1
        "vertical-mid horizontal-mid"
      when 2
        "right horizontal-mid"
      end

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

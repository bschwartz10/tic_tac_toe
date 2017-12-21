require './lib/io'

class Player
  include Io
  attr_reader :marker

  def initialize(marker)
    @marker = marker #either X or O
  end

  def turn(board)
    spot = get_input #spot prompt
    if board.check_spot_validity(spot, self) && board.check_board_availability(spot, self) #if spot is valid and available
      board.mark_spot(spot, marker) #update board
    else
      turn(board) #call method again
    end
  end

end

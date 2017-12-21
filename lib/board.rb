require './lib/io'

class Board
  include Io
  attr_accessor :spaces

  def initialize
    @spaces = ['0', '1', '2', '3', '4', '5', '6', '7', '8'] #single dimensional array to respresent board
  end

  def mark_spot(spot, marker) #update spot on board with corresponding marker
    spaces[spot.to_i] = marker
  end

  def available_spaces
    spaces.reject {|s| s == 'X' || s == 'O'}
  end

  def check_spot_validity(spot, player)
    return spot if spot_valid?(spot)
    invalid_spot #error statement
    pick_spot(self, player) #prompt
  end

  def check_board_availability(spot, player)
    return true if spot_available?(spot)
    spot_not_available
    pick_spot(self, player)
  end

private

  def spot_available?(spot)
    spaces[spot.to_i] != 'X' && spaces[spot.to_i] != 'O'
  end

  def spot_valid?(spot)
    ('0'..'8').include?(spot)
  end
end

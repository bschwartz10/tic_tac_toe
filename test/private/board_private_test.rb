require './test/test_helper'
require './lib/board'

class BoardPrivateTest < Minitest::Test
  attr_reader :board

  def setup
    @board = Board.new
  end

  def test_spot_is_available_returns_true_when_spot_is_available
    assert_equal true, board.send(:spot_available?, '0')
  end

  def test_spot_is_available_returns_false_when_spot_is_unavailable
    board.spaces = ['X', '1', '2', '3', '4', '5', '6', '7', '8']

    assert_equal false, board.send(:spot_available?, '0')
  end

  def test_spot_is_valid_returns_true_when_spot_is_valid
    assert_equal true, board.send(:spot_valid?, '0')
  end

  def test_spot_is_valid_returns_false_when_spot_is_invalid
    assert_equal false, board.send(:spot_valid?, '99')
  end

end

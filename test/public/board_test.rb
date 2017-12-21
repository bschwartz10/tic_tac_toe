require './test/test_helper'
require './lib/board'
require './lib/player'
require 'o_stream_catcher'

class BoardTest < Minitest::Test
  attr_reader :board

  def setup
    @board = Board.new
  end

  def test_board_initializes_a_spaces_array
    assert_equal ['0', '1', '2', '3', '4', '5', '6', '7', '8'], board.spaces
  end

  def test_board_has_nine_spaces
    assert_equal 9, board.spaces.count
  end

  def test_mark_spot
    board.mark_spot(0, 'O')

    assert_equal ['O', '1', '2', '3', '4', '5', '6', '7', '8'], board.spaces
  end

  def test_check_spot_validity_returns_spot_if_input_is_0_through_8
    assert_equal '0', board.check_spot_validity('0', Player.new('X'))
  end

  def test_check_spot_validity_returns_error_statement_if_input_isnt_0_through_8
    result, stdout, stderr = OStreamCatcher.catch do
      board.check_spot_validity('99', Player.new('X'))
    end
    error_statement = "\nPlease enter a valid spot\nYour available moves are [0, 1, 2, 3, 4, 5, 6, 7, 8]\nPlayer X choose a space: "

    assert_equal error_statement, stdout
  end

  def test_check_board_availability_returns_true_for_available_space
    assert_equal true, board.check_board_availability('0', Player.new('X'))
  end

  def test_check_board_availability_returns_error_statement_for_unavailable_space
    board.spaces = ['X', '1', 'X', '3', 'X', '5', 'O', '7', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      board.check_board_availability('0', Player.new('X'))
    end
    error_statement = "\nPlease choose an available spot\nYour available moves are [1, 3, 5, 7, 8]\nPlayer X choose a space: "

    assert_equal error_statement, stdout
  end

end

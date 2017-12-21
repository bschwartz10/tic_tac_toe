require './test/test_helper'
require './lib/rules'
require './lib/board'

class RulesTest < Minitest::Test
  attr_reader :rules, :board

  def setup
    @rules = Rules
    @board = Board.new
  end

  def test_game_is_over_returns_false_when_there_are_no_winning_combos_or_tie
    assert_equal false, rules.game_is_over?(board)
  end

  def test_game_is_over_method_returns_true_when_there_is_a_winning_combo
    board.spaces = ['X', 'X', 'X', 'X', 'O', 'O', 'O', 'O', 'X']

    assert_equal true, rules.game_is_over?(board)
  end

  def test_game_is_over_returns_true_when_there_is_a_tie
    board.spaces = ['O', 'X', 'O', 'X', 'X', 'O', 'X', 'O', 'X']

    assert_equal true, rules.game_is_over?(board)
  end

  def test_winner_returns_true_when_there_is_a_winning_combo
    board.spaces = ['X', 'X', 'X', 'X', 'O', 'O', 'O', 'O', 'X']

    assert_equal true, rules.winner?(board)
  end

  def test_winner_returns_false_when_there_isnt_a_winning_combo
    board.spaces = ['O', 'X', 'O', 'X', 'X', 'O', 'X', 'O', 'X']

    assert_equal false, rules.winner?(board)
  end

  def test_tie_returns_false_if_game_is_not_a_tie
    board.spaces = ['X', 'X', '2', 'X', 'O', 'O', 'O', 'O', 'X']

    assert_equal false, rules.tie?(board)
  end

  def test_tie_returns_true_if_game_is_a_tie
    board.spaces = ['O', 'X', 'O', 'X', 'X', 'O', 'X', 'O', 'X']

    assert_equal true, rules.tie?(board)
  end

  def test_winner_returns_the_marker_for_the_winning_player
    board.spaces = ['X', 'X', 'X', 'X', 'O', 'O', 'O', 'O', 'X']

    assert_equal 'X', rules.winning_marker(board)
  end

end

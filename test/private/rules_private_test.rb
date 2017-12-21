require './test/test_helper'
require './lib/rules'
require './lib/board'

class RulesTest < Minitest::Test
  attr_reader :rules, :board

  def setup
    @rules = Rules
    @board = Board.new
  end

  def test_winning_combinations_contains_eight_winning_combinations
    assert_equal 8, rules.send(:winning_combinations, board).count
  end

end

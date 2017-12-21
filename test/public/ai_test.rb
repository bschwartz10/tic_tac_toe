require './test/test_helper'
require './lib/ai'
require './lib/player'
require './lib/game'
require 'o_stream_catcher'

class AITest < Minitest::Test
  attr_reader :ai, :player, :game

  def setup
    @ai = AI.new('O')
    @player = Player.new('X')
    @game = Game.new
    @game.settings.game_settings[mode: "Human Vs. Computer"]
    @game.settings.game_settings[:players] = {player_one: player, player_two: ai}
    @game.settings.game_settings[:current_player] = ai
  end

  def test_ai_is_initialized_with_a_marker
    assert_equal 'O', ai.marker
  end

  def test_choose_space_chooses_a_horizontal_win
    game.board.spaces = ['0', 'O', 'O', 'X', 'O', 'X', '6', 'X', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end

    assert_equal ['O', 'O', 'O', 'X', 'O', 'X', '6', 'X', '8'], game.board.spaces
  end

  def test_choose_space_chooses_a_vertical_win
    game.board.spaces = ['O', '1', 'X', '3', 'X', '5', 'O', 'X', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end

    assert_equal ['O', '1', 'X', 'O', 'X', '5', 'O', 'X', '8'], game.board.spaces
  end

  def test_choose_space_chooses_a_diagonal_win
    game.board.spaces = ['X', 'X', 'O', 'X', 'O', '5', '6', '7', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end

    assert_equal ['X', 'X', 'O', 'X', 'O', '5', 'O', '7', '8'], game.board.spaces
  end

  def test_choose_space_blocks_a_horizontal_win
    game.board.spaces = ['0', 'X', 'X', 'O', 'X', 'O', '6', 'O', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end
    assert_equal ['O', 'X', 'X', 'O', 'X', 'O', '6', 'O', '8'], game.board.spaces
  end

  def test_choose_space_blocks_a_vertical_win
    game.board.spaces = ['X', '1', 'O', '3', 'O', '5', 'X', '7', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end
    assert_equal ['X', '1', 'O', 'O', 'O', '5', 'X', '7', '8'], game.board.spaces
  end

  def test_choose_space_blocks_a_diagonal_win
    game.board.spaces = ['O', '1', '2', '3', 'X', '5', 'X', '7', '8']

    result, stdout, stderr = OStreamCatcher.catch do
      ai.choose_space(game)
    end
    assert_equal ['O', '1', 'O', '3', 'X', '5', 'X', '7', '8'], game.board.spaces
  end


end

require './test/test_helper'
require './lib/game'
require 'o_stream_catcher'

class GamePrivateTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_switch_players_changes_the_current_player
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]
    game.send(:switch_players)

    assert_equal game.settings.game_settings[:current_player], game.settings.game_settings[:players][:player_two]
  end

  def test_new_move_for_human_player
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    string_io = StringIO.new
    string_io.puts '0'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:new_move)
    end
    $stdin = STDIN

    assert_equal ['X', '1', '2', '3', '4', '5', '6', '7', '8'], game.board.spaces
  end

  def test_new_move_for_AI_player
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_two]

    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:new_move)
    end

    assert_equal ['O', '1', '2', '3', '4', '5', '6', '7', '8'], game.board.spaces
  end

  def test_play_for_human_vs_human_game_player_one_wins
    game.settings.game_settings[:mode] = 'Human Vs. Human'
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: Player.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    string_io = StringIO.new
    string_io.puts '4'
    string_io.puts '1'
    string_io.puts '0'
    string_io.puts '7'
    string_io.puts '8'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:play)
    end
    game_outcome = stdout.split("\n").last
    $stdin = STDIN

    assert_equal 'Game Over! Player X wins!', game_outcome
  end

  def test_play_for_human_vs_human_game_player_two_wins
    game.settings.game_settings[:mode] = 'Human Vs. Human'
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: Player.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    string_io = StringIO.new
    string_io.puts '1'
    string_io.puts '4'
    string_io.puts '7'
    string_io.puts '0'
    string_io.puts '3'
    string_io.puts '8'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:play)
    end
    game_outcome = stdout.split("\n").last
    $stdin = STDIN

    assert_equal 'Game Over! Player O wins!', game_outcome
  end

  def test_play_for_human_vs_computer_game_computer_wins
    game.settings.game_settings[:mode] = 'Human Vs. Computer'
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    string_io = StringIO.new
    string_io.puts '1'
    string_io.puts '7'
    string_io.puts '3'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:play)
    end
    game_outcome = stdout.split("\n").last
    $stdin = STDIN

    assert_equal 'Game Over! Player O wins!', game_outcome
  end

  def test_play_for_human_vs_computer_game_ends_in_tie
    game.settings.game_settings[:mode] = 'Human Vs. Computer'
    game.settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    string_io = StringIO.new
    string_io.puts '0'
    string_io.puts '8'
    string_io.puts '7'
    string_io.puts '2'
    string_io.puts '3'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:play)
    end
    game_outcome = stdout.split("\n").last
    $stdin = STDIN

    assert_equal "Game Over! It's a tie!", game_outcome
  end

  def test_play_for_computer_vs_computer_game_ends_in_tie
    game.settings.game_settings[:mode] = 'Computer Vs. Computer'
    game.settings.game_settings[:players] = {player_one: AI.new('X'), player_two: AI.new('O')}
    game.settings.game_settings[:current_player] = game.settings.game_settings[:players][:player_one]

    result, stdout, stderr = OStreamCatcher.catch do
      game.send(:play)
    end
    game_outcome = stdout.split("\n").last

    assert_equal "Game Over! It's a tie!", game_outcome
  end


end

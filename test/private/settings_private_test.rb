require './test/test_helper'
require './lib/io'
require './lib/settings'
require './lib/player'
require './lib/ai'
require 'o_stream_catcher'

class SettingsPrivateTest < Minitest::Test
  attr_reader :settings, :io

  def setup
    @settings = Settings.new
  end

  def test_setup_game_type_updates_instance_with_human_vs_comp_game_mode
    string_io = StringIO.new

    string_io.puts '1'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_game_type)
    end
    $stdin = STDIN

    assert_equal 'Human Vs. Computer', settings.game_settings[:mode]
  end

  def test_setup_game_type_updates_instance_with_human_vs_human_game_mode
    string_io = StringIO.new

    string_io.puts '2'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_game_type)
    end
    $stdin = STDIN

    assert_equal 'Human Vs. Human', settings.game_settings[:mode]
  end

  def test_setup_game_type_updates_instance_with_comp_vs_comp_game_mode
    string_io = StringIO.new

    string_io.puts '3'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_game_type)
    end
    $stdin = STDIN

    assert_equal 'Computer Vs. Computer', settings.game_settings[:mode]
  end

  def test_setup_players_updates_instance_with_correct_players_for_human_vs_comp
    settings.game_settings[:mode] = 'Human Vs. Computer'
    string_io = StringIO.new

    string_io.puts 'X'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_players)
    end
    $stdin = STDIN

    assert_kind_of Player, settings.game_settings[:players][:player_one]
    assert_kind_of AI, settings.game_settings[:players][:player_two]
  end

  def test_setup_players_updates_instance_with_correct_players_for_human_vs_human
    settings.game_settings[:mode] = 'Human Vs. Human'
    string_io = StringIO.new

    string_io.puts 'X'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_players)
    end
    $stdin = STDIN

    assert_kind_of Player, settings.game_settings[:players][:player_one]
    assert_kind_of Player, settings.game_settings[:players][:player_two]
  end

  def test_setup_players_updates_instance_with_correct_players_for_comp_vs_comp
    settings.game_settings[:mode] = 'Computer Vs. Computer'
    string_io = StringIO.new

    string_io.puts 'X'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_players)
    end
    $stdin = STDIN

    assert_kind_of AI, settings.game_settings[:players][:player_one]
    assert_kind_of AI, settings.game_settings[:players][:player_two]
  end

  def test_setup_current_player
    settings.game_settings[:mode] = 'Human Vs. Computer'
    settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}
    string_io = StringIO.new

    string_io.puts 'X'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.send(:setup_current_player)
    end
    $stdin = STDIN

    assert_equal settings.game_settings[:players][:player_one], settings.game_settings[:current_player]
  end

  def test_marker_valid_returns_true_if_marker_is_X
    assert_equal true, settings.send(:marker_valid?, 'X')
  end

  def test_marker_valid_returns_true_if_marker_is_O
    assert_equal true, settings.send(:marker_valid?, 'O')
  end

  def test_marker_valid_returns_false_if_marker_isnt_O_or_X
    assert_equal false, settings.send(:marker_valid?, 'S')
  end

  def test_set_player_two_marker_returns_O_if_player_one_marker_is_X
    assert_equal 'O', settings.send(:set_player_two_marker, 'X')
  end

  def test_set_player_two_marker_returns_O_if_player_one_marker_is_O
    assert_equal 'O', settings.send(:set_player_two_marker, 'X')
  end

  def test_initialize_players_creates_correct_players_for_human_vs_computer_mode
    settings.game_settings[:mode] = 'Human Vs. Computer'
    settings.send(:initialize_players, 'X', 'O')

    assert_kind_of Player, settings.game_settings[:players][:player_one]
    assert_equal 'X', settings.game_settings[:players][:player_one].marker
    assert_kind_of AI, settings.game_settings[:players][:player_two]
    assert_equal 'O', settings.game_settings[:players][:player_two].marker
  end

  def test_initialize_players_creates_correct_players_for_human_vs_human_mode
    settings.game_settings[:mode] = 'Human Vs. Human'
    settings.send(:initialize_players, 'X', 'O')

    assert_kind_of Player, settings.game_settings[:players][:player_one]
    assert_equal 'X', settings.game_settings[:players][:player_one].marker
    assert_kind_of Player, settings.game_settings[:players][:player_two]
    assert_equal 'O', settings.game_settings[:players][:player_two].marker
  end

  def test_initialize_players_creates_correct_players_for_computer_vs_computer_mode
    settings.game_settings[:mode] = 'Computer Vs. Computer'
    settings.send(:initialize_players, 'O', 'X')

    assert_kind_of AI, settings.game_settings[:players][:player_one]
    assert_equal 'O', settings.game_settings[:players][:player_one].marker
    assert_kind_of AI, settings.game_settings[:players][:player_two]
    assert_equal 'X', settings.game_settings[:players][:player_two].marker
  end

  def test_select_player_returns_a_player_or_ai_instance_with_corresponding_marker
    settings.game_settings[:players] = {player_one: Player.new('X'), player_two: AI.new('O')}

    assert_equal settings.game_settings[:players][:player_one], settings.send(:select_player, 'X')
  end

end

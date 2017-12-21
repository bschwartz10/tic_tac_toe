require './test/test_helper'
require './lib/io'
require './lib/settings'
require './lib/player'
require './lib/ai'
require 'o_stream_catcher'

class SettingsTest < Minitest::Test
  attr_reader :settings

  def setup
    @settings = Settings.new
  end

  def test_choose_method_updates_instance_with_all_game_settings
    string_io = StringIO.new

    string_io.puts '1' #Human vs. Computer mode
    string_io.puts 'X' #Player 1 chooses X for their symbol
    string_io.puts 'X' #Player 1 chooses to go first
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      settings.choose
    end
    $stdin = STDIN

    assert_equal 'Human Vs. Computer', settings.game_settings[:mode]
    assert_kind_of Player, settings.game_settings[:players][:player_one]
    assert_kind_of AI, settings.game_settings[:players][:player_two]
    assert_equal settings.game_settings[:players][:player_one], settings.game_settings[:current_player]
  end

end

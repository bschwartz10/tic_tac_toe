require './test/test_helper'
require './lib/player'
require './lib/board'
require 'o_stream_catcher'

class PlayerTest < Minitest::Test
  attr_reader :player

  def setup
    @player = Player.new('X')
  end

  def test_player_is_initialized_with_a_marker
    assert_equal 'X', player.marker
  end

  def test_turn_updates_board_with_corresponding_spot
    board = Board.new
    string_io = StringIO.new

    string_io.puts '0'
    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      player.turn(board)
    end
    $stdin = STDIN

    assert_equal ['X', '1', '2', '3', '4', '5', '6', '7', '8'], board.spaces
  end

end

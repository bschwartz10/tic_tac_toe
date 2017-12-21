require './test/test_helper'
require './lib/game'
require 'o_stream_catcher'

class GameTest < Minitest::Test
  attr_reader :game

  def setup
    @game = Game.new
  end

  def test_start_game_ends_with_a_computer_win
    string_io = StringIO.new

    string_io.puts '1' #Human vs. Computer mode
    string_io.puts 'X' #Player 1 chooses X for their symbol
    string_io.puts 'X' #Player 1 chooses to go first
    string_io.puts '1' #Player chooses space 1
    string_io.puts '7' #Player chooses space 7
    string_io.puts '3' #Player chooses space 3

    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.start_game
    end
    game_outcome = stdout.split("\n").last

    $stdin = STDIN

    assert_equal 'Game Over! Player O wins!', game_outcome
  end

  def test_start_game_ends_with_a_human_win
    string_io = StringIO.new

    string_io.puts '2' #Human vs. Human mode
    string_io.puts 'X' #Player 1 chooses X for their symbol
    string_io.puts 'X' #Player 1 chooses to go first
    string_io.puts '4' #Player 1 chooses space 4
    string_io.puts '1' #Player 2 chooses space 1
    string_io.puts '0' #Player 1 chooses space 0
    string_io.puts '7' #Player 2 chooses space 7
    string_io.puts '8' #Player 1 chooses space 8

    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.start_game
    end
    game_outcome = stdout.split("\n").last

    $stdin = STDIN

    assert_equal 'Game Over! Player X wins!', game_outcome
  end

  def test_start_game_ends_in_a_tie
    string_io = StringIO.new

    string_io.puts '3' #Computer vs. Computer mode
    string_io.puts 'X' #Player 1 chooses X for their symbol
    string_io.puts 'X' #Player 1 chooses to go first

    string_io.rewind
    $stdin = string_io
    result, stdout, stderr = OStreamCatcher.catch do
      game.start_game
    end
    game_outcome = stdout.split("\n").last

    $stdin = STDIN

    assert_equal "Game Over! It's a tie!", game_outcome
  end

end

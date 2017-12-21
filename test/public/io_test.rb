require './test/test_helper'
require './lib/io'
require './lib/board'
require './lib/player'
require './lib/ai'

class IoTest < Minitest::Test
  attr_reader :test_obj, :board

  def setup
    @test_obj = Object.new.extend(Io)
    @board = Board.new
  end

  def test_get_input
    string_io = StringIO.new

    string_io.puts 'x'
    string_io.rewind
    $stdin = string_io

    assert_equal 'X', test_obj.get_input
    $stdin = STDIN
  end

  def test_board_output_pick_spot
    raw_output = capture_io do
      test_obj.pick_spot(board, Player.new('X'))
    end
    io_output = raw_output[0]

    assert_equal "Your available moves are [0, 1, 2, 3, 4, 5, 6, 7, 8]\nPlayer X choose a space: ", io_output
  end

  def test_display_board
    raw_output = capture_io do
      test_obj.display_board(board)
    end
    io_output = raw_output[0].strip

    assert_equal "0 | 1 | 2 \n-----------\n 3 | 4 | 5 \n-----------\n 6 | 7 | 8", io_output
  end

  def test_check_spot_validity_returns_error_statement_if_input_is_invalid
    raw_output = capture_io do
      test_obj.invalid_spot
    end
    io_output = raw_output[0].rstrip

    assert_equal "\nPlease enter a valid spot", io_output
  end

  def test_check_board_availability_returns_error_statement_if_space_is_taken
    raw_output = capture_io do
      test_obj.spot_not_available
    end
    io_output = raw_output[0].rstrip

    assert_equal "\nPlease choose an available spot", io_output
  end

  def test_game_mode
    raw_output = capture_io do
      test_obj.game_mode
    end
    io_output = raw_output[0].strip

    assert_equal "Choose your game mode:\n 1: Human vs. Computer\n 2: Human vs. Human\n 3: Computer vs. Computer", io_output
  end

  def test_user_symbol
    raw_output = capture_io do
      test_obj.user_symbol
    end
    io_output = raw_output[0].strip

    assert_equal "Please select either 'X' or 'O' to represent your player", io_output
  end

  def test_select_turn
    raw_output = capture_io do
      test_obj.select_turn
    end
    io_output = raw_output[0].strip

    assert_equal 'Please enter 1 to pick first, or 2 to let your opponent pick first', io_output
  end

  def test_invalid_game_mode
    raw_output = capture_io do
      test_obj.invalid_game_mode
    end
    io_output = raw_output[0].strip

    assert_equal 'Error, please select a valid game mode', io_output
  end

  def test_select_player_one_marker
    raw_output = capture_io do
      test_obj.select_player_one_marker
    end
    io_output = raw_output[0].strip

    assert_equal 'Please enter a marker for player 1 (X or O)', io_output
  end

  def test_assigned_markers_player_one_x_player_two_o
    players = {player_one: Player.new('X'), player_two: AI.new('O')}
    raw_output = capture_io do
      test_obj.assigned_markers(players)
    end
    io_output = raw_output[0].strip

    assert_equal "Player one's marker is X and Player two's marker is O", io_output
  end

  def test_assigned_markers_player_one_o_player_two_x
    players = {player_one: Player.new('O'), player_two: AI.new('X')}
    raw_output = capture_io do
      test_obj.assigned_markers(players)
    end
    io_output = raw_output[0].strip

    assert_equal "Player one's marker is O and Player two's marker is X", io_output
  end

  def test_choose_first_turn
    players = {player_one: Player.new('X'), player_two: AI.new('O')}
    raw_output = capture_io do
      test_obj.choose_first_turn(players)
    end
    io_output = raw_output[0].strip

    assert_equal 'Which player wants to go first X or O?', io_output
  end

  def test_first_turn_confirmation
    player = Player.new('X')
    raw_output = capture_io do
      test_obj.first_turn_confirmation(player)
    end
    io_output = raw_output[0].strip

    assert_equal 'Player X chose to goes first', io_output
  end

  def test_invalid_marker
    raw_output = capture_io do
      test_obj.invalid_marker
    end
    io_output = raw_output[0].strip

    assert_equal 'Error, please enter a valid marker', io_output
  end

  def test_ai_spot_chosen
    spot = 2
    marker = 'O'
    raw_output = capture_io do
      test_obj.ai_spot_chosen(marker, spot)
    end
    io_output = raw_output[0].strip

    assert_equal 'Player O chose spot 2', io_output
  end

  def test_ai_spot_chosen_default
    marker = 'O'
    raw_output = capture_io do
      test_obj.ai_spot_chosen(marker)
    end
    io_output = raw_output[0].strip

    assert_equal 'Player O chose spot 4', io_output
  end

  def test_winner_prints_out_winning_marker
    board.spaces = ['X', 'O', 'O', '3', 'X', '5', '6', '7', 'X']
    marker = 'X'

    raw_output = capture_io do
      test_obj.winner(marker)
    end
    io_output = raw_output[0].strip

    assert_equal 'Game Over! Player X wins!', io_output
  end

  def test_tie
    raw_output = capture_io do
      test_obj.tie
    end
    io_output = raw_output[0].strip

    assert_equal "Game Over! It's a tie!", io_output
  end

end

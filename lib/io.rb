module Io

  def get_input
    gets.chomp.upcase
  end

  def pick_spot(board, player)
    print "Your available moves are #{board.available_spaces.map(&:to_i)}\n"
    print "Player #{player.marker} choose a space: "
  end

  def display_board(board)
    puts "\n"
    puts " #{board.spaces[0]} | #{board.spaces[1]} | #{board.spaces[2]} "
    puts "-----------"
    puts " #{board.spaces[3]} | #{board.spaces[4]} | #{board.spaces[5]} "
    puts "-----------"
    puts " #{board.spaces[6]} | #{board.spaces[7]} | #{board.spaces[8]} "
    puts "\n"
  end

  def invalid_spot
    puts "\nPlease enter a valid spot"
  end

  def spot_not_available
    puts "\nPlease choose an available spot"
  end

  def game_mode
    puts "Choose your game mode:\n 1: Human vs. Computer\n 2: Human vs. Human\n 3: Computer vs. Computer"
  end

  def user_symbol
    puts "Please select either 'X' or 'O' to represent your player"
  end

  def select_turn
    puts "Please enter 1 to pick first, or 2 to let your opponent pick first"
  end

  def invalid_game_mode
    puts "Error, please select a valid game mode"
  end

  def select_player_one_marker
    puts "Please enter a marker for player 1 (X or O)"
  end

  def assigned_markers(players)
    puts "Player one's marker is #{players[:player_one].marker} and Player two's marker is #{players[:player_two].marker}"
  end

  def choose_first_turn(players)
    puts "Which player wants to go first #{players[:player_one].marker} or #{players[:player_two].marker}?"
  end

  def first_turn_confirmation(player)
    puts "Player #{player.marker} chose to goes first"
  end

  def invalid_marker
    puts "Error, please enter a valid marker"
  end

  def ai_spot_chosen(marker, spot=4)
    puts "Player #{marker} chose spot #{spot}"
  end

  def winner(marker)
    puts "Game Over! Player #{marker} wins!"
  end

  def tie
    puts "Game Over! It's a tie!"
  end

end

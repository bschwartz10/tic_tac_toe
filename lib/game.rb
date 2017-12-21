require './lib/board'
require './lib/player'
require './lib/rules'
require './lib/ai'
require './lib/io'
require './lib/settings'

class Game
  include Io
  attr_reader :board, :rules, :settings

  def initialize
    @board = Board.new
    @rules = Rules
    @settings = Settings.new
  end

  def start_game
    settings.choose #dynamically populate game_settings hash with user input
    display_board(board)
    play #start game loop
  end

  def switch_players #switches the current player between each turn
    if settings.game_settings[:current_player] == settings.game_settings[:players][:player_one]
      settings.game_settings[:current_player] = settings.game_settings[:players][:player_two]
    else
      settings.game_settings[:current_player] = settings.game_settings[:players][:player_one]
    end
  end

private

  def play
    loop do
      new_move #perform one move
      display_board(board)
      return winner(rules.winning_marker(board)) if rules.winner?(board) #display winning message if there is a winner
      return tie if rules.tie?(board) #display tieing message if there is a tie
      switch_players #switch current players
    end
  end

  def new_move
    if settings.game_settings[:current_player].is_a?(Player) #if current_player is a instance of Player class
      pick_spot(board, settings.game_settings[:current_player]) #prompt
      settings.game_settings[:current_player].turn(board) #update board with spot
    else
      settings.game_settings[:current_player].choose_space(self) #update board with spot
    end
  end

end

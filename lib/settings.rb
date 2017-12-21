class Settings
  include Io
  attr_reader :game_settings

  def initialize
    @game_settings = {} #dynamically populated with user input settings
  end

  def choose #updates game_settings hash with key value pairs
    setup_game_type
    setup_players
    setup_current_player
  end

private

  def setup_game_type #choose a game type
    game_mode #prompt
    mode = get_input
    if game_modes[mode] #if game mode exists in game_modes hash
      game_settings[:mode] = game_modes[mode] #create mode key/value pair
    else
      invalid_game_mode
      setup_game_type
    end
  end

  def setup_players #choose markers and type of players
    select_player_one_marker #prompt
    marker = get_input
    if marker_valid?(marker) #if marker is X or O
      player_one_marker = marker
      player_two_marker = set_player_two_marker(marker) #set player two marker based off of player one marker
      initialize_players(player_one_marker, player_two_marker)
      assigned_markers(game_settings[:players]) #confirmation output
    else
      invalid_marker
      setup_players
    end
  end

  def setup_current_player #choose which player goes first
    choose_first_turn(game_settings[:players]) #prompt
    marker = get_input
    if marker_valid?(marker)
      game_settings[:current_player] = select_player(marker) #create current_player key/value pair
      first_turn_confirmation(game_settings[:current_player])
    else
      invalid_marker
      setup_current_player
    end
  end

  def game_modes
    {
      '1' => 'Human Vs. Computer',
      '2' => 'Human Vs. Human',
      '3' => 'Computer Vs. Computer'
    }
  end

  def marker_valid?(marker)
    ['X','O'].include?(marker)
  end

  def set_player_two_marker(marker)
    marker == 'X' ? 'O' : 'X'
  end

  def initialize_players(player_one_marker, player_two_marker) #creates players based on game mode and markers
    if game_settings[:mode] == 'Human Vs. Computer'
      game_settings[:players] = {player_one: Player.new(player_one_marker), player_two: AI.new(player_two_marker)}
    elsif game_settings[:mode] == 'Human Vs. Human'
      game_settings[:players] = {player_one: Player.new(player_one_marker), player_two: Player.new(player_two_marker)}
    else
      game_settings[:players] = {player_one: AI.new(player_one_marker), player_two: AI.new(player_two_marker)}
    end
  end

  def select_player(marker) #select player instance based on marker
    game_settings[:players].values.select {|attrs| marker == attrs.marker}.first
  end

end

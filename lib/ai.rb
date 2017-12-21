require './lib/io'

class AI
  include Io
  attr_reader :marker

  MAXIMUM_SCORE = 1000
  MINIMUM_SCORE = -1000
  STARTING_DEPTH = 0

  def initialize(marker)
    @marker = marker #either X or O
  end

  def choose_space(game)
    @best_score = {} #collect the best score for each turn
    negamax(game) #check outcomes for the game
    spot = select_best_spot #select best spot based on best score hash
    game.board.mark_spot(spot, marker)
    ai_spot_chosen(marker, spot)
  end

private

  def score_scenarios(board, rules, depth)
    return 0 if rules.tie?(board) #result for tie
    return MAXIMUM_SCORE / depth if rules.winner?(board) && rules.winning_marker(board) == marker #result for win
    return MINIMUM_SCORE / depth #result for loss
  end

  def negamax(game, depth = STARTING_DEPTH, alpha = MINIMUM_SCORE, beta = MAXIMUM_SCORE, color = 1)
    return color * score_scenarios(game.board, game.rules, depth) if game.rules.game_is_over?(game.board) #base case

    max = MINIMUM_SCORE

    game.board.available_spaces.each do |space|
      game.board.mark_spot(space, game.settings.game_settings[:current_player].marker)
      game.switch_players
      negamax_value = -negamax(game, depth+1, -beta, -alpha, -color) #recursively call negamax with inverse new arguements

      game.board.mark_spot(space, space)
      game.switch_players

      max = [max, negamax_value].max
      @best_score[space] = max if depth == STARTING_DEPTH #add key/value pair at base case
      alpha = [alpha, negamax_value].max
      return alpha if alpha >= beta #break if we have MAXIMUM SCORE
    end

    max #best score for each space
  end

  def select_best_spot
    @best_score.max_by {|key, value| value}[0]
  end

end

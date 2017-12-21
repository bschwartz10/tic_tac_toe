class Rules

  def self.game_is_over?(board) #check winning combos to see if any are all X or O
    winner?(board) || tie?(board)
  end

  def self.winner?(board)
    winning_combinations(board).any? {|wc| wc.uniq.length == 1}
  end

  def self.tie?(board)
    board.available_spaces.empty? && !winner?(board)
  end

  def self.winning_marker(board) #returns the winning marker, either X or O
    winning_combinations(board).select {|wc| wc.uniq.length == 1}.first.first
  end

private

  def self.winning_combinations(board) #all winning combos on a tic tac toe board
    [
      [board.spaces[0], board.spaces[1], board.spaces[2]],
      [board.spaces[3], board.spaces[4], board.spaces[5]],
      [board.spaces[6], board.spaces[7], board.spaces[8]],
      [board.spaces[0], board.spaces[3], board.spaces[6]],
      [board.spaces[1], board.spaces[4], board.spaces[7]],
      [board.spaces[2], board.spaces[5], board.spaces[8]],
      [board.spaces[0], board.spaces[4], board.spaces[8]],
      [board.spaces[2], board.spaces[4], board.spaces[6]]
    ]
  end

end

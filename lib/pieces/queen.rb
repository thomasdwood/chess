class Queen < Piece
  def sym 
    @team == :white ? "♕" : "♛"
  end

  def possible_moves
    moves = []

    moves << @@all_possible_moves[:north]
    moves << @@all_possible_moves[:east]
    moves << @@all_possible_moves[:south]
    moves << @@all_possible_moves[:west]
    moves << @@all_possible_moves[:northwest]
    moves << @@all_possible_moves[:northeast]
    moves << @@all_possible_moves[:southwest]
    moves << @@all_possible_moves[:southeast]
    moves.flatten(1)
  end
end
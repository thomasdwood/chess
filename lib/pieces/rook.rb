class Rook < Piece

  def possible_moves
    moves = []

    moves << @@all_possible_moves[:north]
    moves << @@all_possible_moves[:east]
    moves << @@all_possible_moves[:south]
    moves << @@all_possible_moves[:west]
    moves.flatten(1)
  end
  def sym 
    @team == :white ? "♖" : "♜"
  end
end
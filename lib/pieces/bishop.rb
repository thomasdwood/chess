
class Bishop < Piece

  def sym
    @team == :white ? "♗" : "♝"
  end

  def possible_moves
    moves = []
    moves << @@all_possible_moves[:northwest]
    moves << @@all_possible_moves[:northeast]
    moves << @@all_possible_moves[:southwest]
    moves << @@all_possible_moves[:southeast]
    moves.flatten(1)
  end

end
class Pawn < Piece

  #implement first move double

  def sym 
    @team == :white ? "♙" : "♟"
  end

  def possible_moves
    @@all_possible_moves[:pawn]
  end
end
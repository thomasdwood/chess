class Pawn < Piece
  def sym 
    @team == :white ? "♙" : "♟"
  end
end
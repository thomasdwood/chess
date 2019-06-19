class Rook < Piece
  def sym 
    @team == :white ? "♖" : "♜"
  end
end
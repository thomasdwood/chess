class Knight < Piece
  def sym 
    @team == :white ? "♘" : "♞"
  end
end
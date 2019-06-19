class King < Piece
  def sym
    @team == :white ? "♔" : "♚"
  end
end
class Queen < Piece
  def sym 
    @team == :white ? "♕" : "♛"
  end
end
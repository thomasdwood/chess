
class Bishop < Piece
  def sym
    @team == :white ? "♗" : "♝"
  end
end
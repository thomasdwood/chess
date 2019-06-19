class Rook < Piece

  attr_reader :team
  def sym 
    @team == :white ? "♖" : "♜"
  end
end
class Knight < Piece
  def sym 
    @team == :white ? "♘" : "♞"
  end

  def moves
    moves = {
      :direction => [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]],
      :spaces => 1,
      :special_moves => :none
    }

    moves
  end
end
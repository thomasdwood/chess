class King < Piece

  #Implement Castling

  def sym
    @team == :white ? "♔" : "♚"
  end

  def possible_moves
    @@all_possible_moves[:king]
  end

end
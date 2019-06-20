class King < Piece

  #Implement Castling

  def sym
    @team == :white ? "♔" : "♚"
  end

  def moves
    moves = {
      :direction => [],
      :spaces => 1,
      :special_moves => :castle
    }

    @@directions.each { |key, val| moves[:direction] << val }
    moves
  end

end
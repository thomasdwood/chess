class Knight < Piece
  def sym 
    @team == :white ? "♘" : "♞"
  end

  def possible_moves
    @@all_possible_moves[:knight]
  end
end
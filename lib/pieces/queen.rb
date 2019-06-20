class Queen < Piece
  def sym 
    @team == :white ? "♕" : "♛"
  end
  def moves
    moves = {
      :direction => [],
      :spaces => 7,
      :special_moves => :none
    }

    @@directions.each { |key, val| moves[:direction] << val }
    moves
  end
end
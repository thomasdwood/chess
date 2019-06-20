class Rook < Piece

  def sym 
    @team == :white ? "♖" : "♜"
  end

  def moves
    moves = {
      :direction => [],
      :spaces => 7,
      :special_moves => :none
    }
    
    moves[:direction] << @@directions[:north]
    moves[:direction] << @@directions[:south]
    moves[:direction] << @@directions[:west]
    moves[:direction] << @@directions[:east]
    moves
  end
end
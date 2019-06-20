class Pawn < Piece

  #implement first move double

  def sym 
    @team == :white ? "♙" : "♟"
  end

  def moves
    moves = {
      :direction => [@team == :white ? @@directions[:south] : @@directions[:north]],
      :spaces => 1,
      :special_moves => :first_move_double
    }

    


    
    moves
  end
end
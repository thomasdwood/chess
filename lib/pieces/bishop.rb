
class Bishop < Piece

  def sym
    @team == :white ? "♗" : "♝"
  end

  def moves
    moves = {
      :direction => [],
      :spaces => 7,
      :special_moves => :none
    }
    moves[:direction] << @@directions[:northwest]
    moves[:direction] << @@directions[:northeast]
    moves[:direction] << @@directions[:southwest]
    moves[:direction] << @@directions[:southeast]
    moves
  end

end
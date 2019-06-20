
class Piece
  attr_reader :team

  @@directions = {
    :north => [1,0],
    :south => [-1,0],
    :east => [0,1],
    :west => [0,-1],
    :northeast => [1,1],
    :northwest => [1,-1],
    :southeast => [-1,1],
    :southwest => [-1,-1]
   
  }

  def initialize(team)
    @team = team
  end

  def name
    self.class.name
  end

  def self.directions
    @@directions
  end
end

class Piece
  attr_reader :team

  def initialize(team)
    @team = team
  end

  def name
    self.class.name
  end
end
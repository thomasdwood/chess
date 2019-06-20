class Node
  attr_reader :position, :parent, :dir

  def initialize(pos, parent=nil, dir=nil)

    @position = pos
    @parent = parent
    @dir = dir

  end
end

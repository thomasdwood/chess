require_relative 'pieces/game_piece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Board

  attr_reader :board

  def initialize
    @white_pieces = generate_pieces(:white)
    @black_pieces = generate_pieces(:black)
    @board = generate_board
  end

  def state 
    white = "                        WHITE"
    black = "                        BLACK"
    spacer = "  "
    row_divider = "  |-----+-----+-----+-----+-----+-----+-----+-----|"
    letter_row = spacer
    ("A".."H").each { |l| letter_row += " " + spacer + l + spacer }
    
    puts black
    puts ""
    puts letter_row
    puts row_divider

    rank = 8
    @board.each do |row|
      row_state = "#{rank} |"
      row.each do |piece|
        space = (piece != nil ? piece.sym : " ")
        row_state += spacer + space + spacer + "|" 
      end

      puts row_state
      puts row_divider
      rank -= 1
    end
    puts letter_row
    puts ""
    puts white

  end
  

  private

  def generate_pieces(team)
    pieces = {
      :pawn => [],
      :rook => [],
      :knight => [],
      :bishop => [],
      :king => [],
      :queen => []
    }

    (0..7).each { |p| pieces[:pawn] << Pawn.new(team) }

    pieces[:rook] << Rook.new(team)
    pieces[:knight] << Knight.new(team)
    pieces[:bishop] << Bishop.new(team)
    pieces[:queen] << Queen.new(team)
    pieces[:king] << King.new(team)
    pieces[:bishop] << Bishop.new(team)
    pieces[:knight] << Knight.new(team)
    pieces[:rook] << Rook.new(team)

    pieces 
  end

  def generate_board
    board = []
    blank_row = []
    white_rows = starting_rows(@white_pieces)
    black_rows = starting_rows(@black_pieces)
    8.times { blank_row << nil }
    board << black_rows[0]
    board << black_rows[1]
    4.times { board << blank_row }
    board << white_rows[1]
    board << white_rows[0]
    board   
  end

  def starting_rows(team)
    main_row = [
      team[:rook][0],
      team[:knight][0],
      team[:bishop][0],
      team[:queen][0],
      team[:king][0],
      team[:bishop][1],
      team[:knight][1],
      team[:rook][1]
    ]
    pawn_row = []
    (0..7).each { |p| pawn_row << team[:pawn][p] }

    [main_row, pawn_row]
  end 
  
end


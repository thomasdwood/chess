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

  def to_s
    #this method is only for testing

    @board.each { |row| puts row.to_s } 
    
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

  def submit_move(move, team)
    
    start = translate_user_input(move[0..1])
    finish = translate_user_input(move[-2..-1])

    return invalid_move(:invalid_coordinates) if start.include?(-1) || finish.include?(-1)

    piece = @board[start[0]][start[1]]
    
    return invalid_move(:no_piece) if piece.nil? 
    return invalid_move(:wrong_color) if piece.team != team

    @board[start[0]][start[1]] = nil
    @board[finish[0]][finish[1]] = piece

    return {:valid => true, :message => :normal, :piece => piece}
    
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
    board << black_rows[0]
    board << black_rows[1]
    4.times { board << [nil, nil, nil, nil, nil, nil, nil, nil] }
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
  

  def translate_user_input(input)

    row = -1
    col = -1
    case input[0].to_i
    when 1
      row = 7
    when 2
      row = 6
    when 3
      row = 5
    when 4
      row = 4
    when 5
      row = 3
    when 6
      row = 2
    when 7
      row = 1
    when 8
      row = 0
    end

    case input[1]
    when "a"
      col = 0
    when "b"
      col = 1
    when "c"
      col = 2
    when "d"
      col = 3
    when "e"
      col = 4
    when "f"
      col = 5
    when "g"
      col = 6
    when "h"
      col = 7
    end

    [row, col]

  end

  def invalid_move(message)
    {:valid => false, :message => message}
  end
end


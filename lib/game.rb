require_relative 'board'

class Game

  def initialize
    @board = Board.new
    @white_turn = true

  end

  def game_loop

    loop do
      @board.state
      puts ""
      puts "It is #{turn.to_s}'s turn."
      puts "Please enter a move, type 'help' for help."
      move = gets.chomp.downcase
      move.strip!
      case move
      when 'help'
        get_help
      when nil
        next
      when 'skip'
        @white_turn = !@white_turn
        
      else
        response = @board.submit_move(move, turn)
        interpret(response, move)
      end
    end

  end

  private

  def get_help
    puts 'Enter the coordinates of the pieces you would like to move, row first, followed by the coordinates you would like to move the piece to.'
    puts 'For example, if you wanted to move the piece in the lower left corner to the upper right corner, you would enter "1A8G" or "1A 8G".'
    puts 'If your move is invalid you will be prompted and asked to enter another move.'
  end

  def turn
    @white_turn ? :white : :black
  end

  def interpret(response, move)
    if response[:valid] == false
      case response[:message]
      when :invalid_coordiantes
        puts "One or more of your coordinates were invalid."
      when :no_piece
        puts "There was no piece at coordinates #{move[0]}#{move[1]}. Please enter valid coordinates, starting with the row. For help type 'help'."
      when :wrong_color
        puts "The piece at coordinates #{move[0]}#{move[1]} are not #{turn}. Please enter valid coordinates, starting with the row. For help type 'help'."
      else
        puts "Some error has occured and the move was not recorded. Error code: #{response[:message]}"
      end
      puts  "Please enter valid coordinates, starting with the row. For help type 'help'."
    else 
      message = "Successfully moved #{turn}'s #{response[:piece].name} to #{move[-2]}#{move[-1]}"
      message += " and captured #{turn}'s #{response[:captured].name}'" if response[:message] == :captured
      message += "."
      puts message
      @white_turn = !@white_turn
    end
  end
end

game = Game.new
game.game_loop
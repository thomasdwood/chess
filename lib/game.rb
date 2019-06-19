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
      else
        response = @board.submit_move(move, turn)
        interpret(response, move)
      end

      @board.to_s
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
      end
      puts  "Please enter valid coordinates, starting with the row. For help type 'help'."
    else 
      case response[:message]
      when :normal
        "Successfully moved #{turn}'s #{response[:piece].name} to #{move[-2]}#{move[-1]}"
      end
    end
  end
end

game = Game.new
game.game_loop
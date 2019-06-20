require './lib/board.rb'

RSpec.describe Board do
  test = Board.new
  board = test.instance_variable_get(:@board)
  
  context 'When New Game Started' do
    describe 'places all the black pieces' do
      it 'places only black pieces' do
        (0..1).each do |r|
          (0..7).each do |p|
            expect(board[r][p].team).to eql(:black)
          end
        end
      end

      it 'places the correct black pieces' do
        expect(board[0][0]).to be_a(Rook)
        expect(board[0][1]).to be_a(Knight)
        expect(board[0][2]).to be_a(Bishop)
        expect(board[0][3]).to be_a(Queen)
        expect(board[0][4]).to be_a(King)
        expect(board[0][5]).to be_a(Bishop)
        expect(board[0][6]).to be_a(Knight)
        expect(board[0][7]).to be_a(Rook)
      

        (0..7).each { |p| expect(board[1][p]).to be_a(Pawn) }
      end
    end

    describe 'places all the white pieces' do
      it 'places only white pieces' do
        (6..7).each do |r|
          (0..7).each do |p|
            expect(board[r][p].team).to eql(:white)
          end
        end
      end

      it 'places the correct white pieces' do
        expect(board[7][0]).to be_a(Rook)
        expect(board[7][1]).to be_a(Knight)
        expect(board[7][2]).to be_a(Bishop)
        expect(board[7][3]).to be_a(Queen)
        expect(board[7][4]).to be_a(King)
        expect(board[7][5]).to be_a(Bishop)
        expect(board[7][6]).to be_a(Knight)
        expect(board[7][7]).to be_a(Rook)

        (0..7).each { |p| expect(board[6][p]).to be_a(Pawn) }
      end
    end

    it "doesn't palce anything in the middle four rows" do
      (2..5).each do |r|
        (0..7).each { |c| expect(board[r][c]).to be_nil }
      end
    end
    
  end

  context 'When a move is submitted' do
    it 'correctly identifies gibberish coordinates' do
      response = test.submit_move("what am i doing?", :white)
      expect(response[:valid]).to be false
      response = test.submit_move("1133", :white)
      expect(response[:valid]).to be false
      response = test.submit_move("AGFD", :white)
      expect(response[:valid]).to be false
    end 

    it 'correctly identifies if starting coordinates have no piece' do
      response = test.submit_move("4a4b", :white)
      expect(response[:valid]).to be false
    end
    it "won't move a piece if it isn't that player's turn" do
      response = test.submit_move("7H6H", :white)
      expect(response[:valid]).to be false
      response = test.submit_move("2a3a", :black)
      expect(response[:valid]).to be false
    end
  end

  context 'When moving' do
    describe 'a queen' do
      before(:each) do
        board = create_board([["WQ","33"]])
      end
      describe 'can move one space' do
        it 'north' do
          board.submit_move("5d4d", :white)
          expect(board.instance_variable_get(:@board)[4][3]).to_not be_nil 
        end
        it 'east' do 
          board.submit_move("5d5e", :white)
          expect(board.instance_variable_get(:@board)[3][4]).to_not be_nil
        end
        it 'south' do
          board.submit_move("5d6d", :white)
          expect(board.instance_variable_get(:@board)[2][3]).to_not be_nil
        end
        it 'west' do
          board.submit_move("5d5c", :white)          
          expect(board.instance_variable_get(:@board)[3][2]).to_not be_nil
        end
        it 'southeast' do
          board.submit_move("5d6e", :white)
          expect(board.instance_variable_get(:@board)[2][4]).to_not be_nil
        end
        it 'southwest' do
          board.submit_move("5d6c", :white)
          expect(board.instance_variable_get(:@board)[2][2]).to_not be_nil
        end
        it 'northeast' do
          board.submit_move("5d4e", :white)
          expect(board.instance_variable_get(:@board)[4][4]).to_not be_nil
        end
        it 'northwest' do
          board.submit_move("5d4c", :white)
          expect(board.instance_variable_get(:@board)[4][2]).to_not be_nil
        end
      end
      describe 'can move more than one space' do
        it 'north' do
          board.submit_move("5d2d", :white)
          expect(board.instance_variable_get(:@board)[6][3]).to_not be_nil 
        end
        it 'east' do 
          board.submit_move("5d5g", :white)
          expect(board.instance_variable_get(:@board)[3][6]).to_not be_nil
        end
        it 'south' do
          board.submit_move("5d8d", :white)
          expect(board.instance_variable_get(:@board)[0][3]).to_not be_nil
        end
        it 'west' do
          board.submit_move("5d5a", :white)          
          expect(board.instance_variable_get(:@board)[3][0]).to_not be_nil
        end
        it 'southeast' do
          board.submit_move("5d7f", :white)
          expect(board.instance_variable_get(:@board)[1][5]).to_not be_nil
        end
        it 'southwest' do
          board.submit_move("5d7b", :white)
          expect(board.instance_variable_get(:@board)[1][1]).to_not be_nil
        end
        it 'northeast' do
          board.submit_move("5d2g", :white)
          expect(board.instance_variable_get(:@board)[6][6]).to_not be_nil
        end
        it 'northwest' do
          board.submit_move("5d2a", :white)
          expect(board.instance_variable_get(:@board)[6][0]).to_not be_nil
        end
      end
    end
  end



  def create_board(params)
    pieces = []
    squares = []
    params.each do |pair|
      piece = pair[0].upcase
      squares << pair[1].upcase
      pieces << create_piece(piece)
      
    end

    board = Board.new
    new_board = []
    8.times {new_board << [nil, nil, nil, nil, nil, nil, nil, nil]}
    board.instance_variable_set(:@board, new_board)

    squares.each_with_index { |s, i| board.instance_variable_get(:@board)[s[0].to_i][s[1].to_i] = pieces[i] }
    
    return board 

  end

  def create_piece(piece)
    team = (piece[0] == "W" ? :white : :black)
    case piece[1]
    when "P"
      return Pawn.new(team)
    when "Q"
      return Queen.new(team)
    when "K"
      return King.new(team)
    when "B"
      return Bishop.new(team)
    when "R"
      return Rook.new(team)
    when "N"
      return Knight.new(team)
    end 
  end
end


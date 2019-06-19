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

    it 'correctly identifies if starting coordinates have no piece'
    it "won't move a piece if it isn't that player's turn"
    
  end

end


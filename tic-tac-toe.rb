# A class that implements a playable tic tac toe
class TicTacToe
  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
  end

  def complete?
    @board.each do |row|
      row.each do |cell|
        return false unless (:X, :O).include? cell
      end
    end
    true
  end

end

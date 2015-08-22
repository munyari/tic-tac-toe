# A playable tic tac toe game
module TicTacToe
  class Game
    def initialize
      @board = [[1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]]
        puts "Welcome to tic-tac 3000! Please select a game mode below."
      begin
        puts "1) Computer vs Computer"
        puts "2) Human vs Computer"
        puts "3) Human vs Human"
        raise ArgumentError, "Please enter a valid number between 1 and 3" unless
          (1..3).include?(gets.chomp.to_i)
      rescue ArgumentError=>e
        puts e
        retry
      end
    end

    # checks whether or not the game is complete
    def complete?
      @board.each do |row|
        row.each do |cell|
          return false unless (:X, :O).include? cell
        end
      end
      true
    end

    # draws the current state of the game board
    def draw
      rows_for_display = []
      @board.each do |row|
        rows_for_display << row.join(" | ")
      end
      rows_for_display.join("\n--+---+--\n")
    end
  end

  class Player

  end

  class HumanPlayer < Player

  end

  class ComputerPlayer < Player

  end
end



#== Tic Tac Toe
# A playable tic tac toe game
module TicTacToe
  # Game class defines the template for a game
  class Game
    def initialize
      @board = [[1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]]
      @win = false
      @pos_moves = 9 # the number of moves possible in a game, total
      puts "Welcome to tic-tac 3000! Please select a game mode below."
      begin
        puts "1) Computer vs Computer"
        puts "2) Human vs Computer"
        puts "3) Human vs Human"
        game_choice = gets.chomp.to_i
        raise ArgumentError, "Please enter a valid number between 1 and 3" unless
        (1..3).include?(game_choice)
      rescue ArgumentError=>e
        puts e
        retry
      end
      case game_choice
      when 1
        @p1 = ComputerPlayer.new(self, :X)
        @p2 = ComputerPlayer.new(self, :O)
      when 2
        @p1 = HumanPlayer.new(self, :X)
        @p2 = ComputerPlayer.new(self, :O)
      when 3
        @p1 = HumanPlayer.new(self, :X)
        @p2 = HumanPlayer.new(self, :O)
      end
      play
    end

    # draws the current state of the game board
    def draw
      rows_for_display = []
      @board.each do |row|
        rows_for_display << row.join(" | ")
      end
      puts rows_for_display.join("\n--+---+--\n")
    end

    # validates the availability of a given position
    def valid_move?(pos)
      validate = proc { |i, j| @board[i][j].class == Fixnum }
      case pos
      when 1..3
        validate.call(0, pos-1)
      when 4..6
        validate.call(1, pos-4)
      when 7..9
        validate.call(2, pos-7)
      else
        false
      end
    end

    # mark the game board with the appropriate symbol
    def mark(pos, symbol)
      @pos_moves -= 1
      mark_cell = proc { |i, j| @board[i][j] = symbol }
      case pos
      when 1..3
        mark_cell.call(0, pos-1)
      when 4..6
        mark_cell.call(1, pos-4)
      when 7..9
        mark_cell.call(2, pos-7)
      end
    end

    # checks whether or not the game is complete
    def complete?
      if check_win
        @win = true
        return true
      end

      @pos_moves == 0
    end

    private

    # check if we have a winner
    def check_win
      @board.each           { |row| return true if row.all? { |sym| sym == "X" } }
      @board.each           { |row| return true if row.all? { |sym| sym == "O" } }
      @board.transpose.each { |col| return true if col.all? { |sym| sym == "X" } }
      @board.transpose.each { |col| return true if col.all? { |sym| sym == "O" } }
      @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ||
        @board[2][0] == @board[1][1] && @board[1][1] == @board[0][2]
    end

    # method that controls the game loop
    def play
      current_player = @p1
      begin
        current_player.make_move
        current_player = current_player == @p1 ? @p2 : @p1
      end until complete?
      if @win
        draw
        puts "Player #{current_player == @p1 ? 2 : 1} wins!"
      else
        puts "It's a draw!"
      end
    end

  end

  # a Tic Tac Toe player
  class Player
    # create a new player
    def initialize(game, sym)
      @symbol = sym
      @game = game
    end
  end

  # a human player
  class HumanPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end

    # make a move by prompting the player
    def make_move
      @game.draw
      puts "Where would you like to move?"
      pos = gets.chomp.to_i
      until @game.valid_move?(pos)
        puts "Sorry, that is not a valid move. Please try again."
        pos = gets.chomp.to_i
      end
      @game.mark(pos, @symbol.to_s)
    end
  end

  # a computer player
  class ComputerPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end

    # make a move by taking a random available square
    def make_move
      puts "Computer is playing..."
      sleep(1) # more realistic pacing
      begin
        return if @game.complete?
        pos = Random.rand(10)
      end until @game.valid_move?(pos)
      puts "Computer plays on square #{pos}"
      @game.mark(pos, @symbol.to_s)
    end
  end
end

TicTacToe::Game.new

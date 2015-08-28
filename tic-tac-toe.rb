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

    # checks whether or not the game is complete
    def complete?
      @board.each do |row|
        row.each do |cell|
          return false unless [:X, :O].include? cell
        end
      end
      true
    end

    # check if we have a winner
    def check_win
      # make this DRY, could i use a proc?
      @board.each           { |row| return true if row.all? { |sym| sym == "X" } }
      @board.each           { |row| return true if row.all? { |sym| sym == "O" } }
      @board.transpose.each { |col| return true if row.all? { |sym| sym == "X" } }
      @board.transpose.each { |col| return true if row.all? { |sym| sym == "O" } }
      @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ||
        @board[2][0] == @board[1][1] && @board[1][1] == @board[0][2]
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
      p @board
      case pos
      when 1..3
        return @board[0][pos-1].class == Fixnum
      when 4..6
        return @board[1][pos-4].class == Fixnum
      when 7..9
        return @board[2][pos-7].class == Fixnum
      else
        return false
      end
    end

    # mark the game board with the appropriate symbol
    # TODO: make this and previous method DRY
    def mark(pos, symbol)
      case pos
      when 1..3
        @board[0][pos-1] = symbol
      when 4..6
        @board[1][pos-4] = symbol
      when 7..9
        @board[2][pos-7] = symbol
      end
    end

    # method that controls the game loop
    def play
      current_player = @p1
      loop do
        current_player.make_move
        break if complete?
        current_player = current_player == @p1 ? @p2 : @p1
      end
    end

    public :draw
  end

  class Player
    attr_reader :symbol
    def initialize(game, sym)
      @symbol = sym
      @game = game
    end
  end

  class HumanPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end

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

  class ComputerPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end
    def make_move
      #sleep(3) # more realistic pacing
      begin
        pos = Random.rand(10)
      end until @game.valid_move?(pos)
      @game.mark(pos, @symbol.to_s)
    end
  end
end

# TODO: Valid move setting
TicTacToe::Game.new

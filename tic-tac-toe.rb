# A playable tic tac toe game
class TicTacToe
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
      @p1 = ComputerPlayer.new(:X)
      @p2 = ComputerPlayer.new(:O)
    when 2
      @p1 = HumanPlayer.new(:X)
      @p2 = ComputerPlayer.new(:O)
    when 3
      @p1 = HumanPlayer.new(:X)
      @p2 = HumanPlayer.new(:O)
    end
    play
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

  # validates the availability of a given position
  def valid_move(pos)
    case pos
    when 1..3
      return @board[0][pos-1].integer?
    when 4..6
      return @board[1][pos-4].integer?
    when 7..9
      return @board[2][pos-4].integer? 
    else
      return false
    end
  end

  # method that controls the game loop
  def play
    loop do

    end
  end


  class Player
    attr_reader :symbol
    def initialize(game)
      @symbol = sym
    end
  end

  class HumanPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end

    def make_move
      @game.draw
      puts "Where would you like to move?"
      pos = gets.chomp
      until @game.valid_move?(pos)
        puts "Sorry, that is not a valid move. Please try again."
        pos = gets.chomp
      end
      pos
    end
  end

  class ComputerPlayer < Player
    def initialize(game, sym)
      super(game, sym)
    end
    def make_move
      begin
        pos = Random.rand(10)
      end until @game.valid_move?(pos)
      pos
    end
  end
end



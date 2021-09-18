# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins.

# Nouns: board, player, square, grid
# Verbs: play, mark

# Spike:
# Board
# Square
# Player
# - mark
# - play

# Write the play method first, using methods that haven't yet been
# defined. This provides the general flow of the program.

require "pry"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  attr_accessor :squares

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    squares[key].marker = marker
  end

  def [](key)
    squares[key].marker
  end

  def available_square_keys
    squares.keys.select { |key| squares[key].unmarked_key? }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts
    puts "       |       |       "
    puts "   #{squares[1]}   |   #{squares[2]}   |   #{squares[3]}   "
    puts "      1|      2|      3"
    puts "-------+-------+-------"
    puts "       |       |       "
    puts "   #{squares[4]}   |   #{squares[5]}   |   #{squares[6]}   "
    puts "      4|      5|      6"
    puts "-------+-------+-------"
    puts "       |       |       "
    puts "   #{squares[7]}   |   #{squares[8]}   |   #{squares[9]}   "
    puts "      7|      8|      9"
    puts
    sleep(TTTGame::SHORT_SLEEP_LENGTH)
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def full?
    available_square_keys.empty?
  end

  def someone_won?
    !!detect_winning_marker
  end

  def detect_winning_marker
    WINNING_LINES.each do |line|
      # binding.pry
      first_marker = squares[line[0]].marker
      second_marker = squares[line[1]].marker
      third_marker = squares[line[2]].marker

      next if first_marker == Square::INITIAL_MARKER
      return first_marker if (first_marker == second_marker) &&
                             (second_marker == third_marker)
    end
    nil
  end

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    self.marker = marker
  end

  def unmarked_key?
    marker == INITIAL_MARKER
  end

  def to_s
    marker
  end
end

class Player
  attr_reader :marker
  attr_accessor :score, :name

  include Comparable

  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end

  def five_wins?
    score == 5
  end

  def <=>(other)
    score <=> other.score
  end

  def to_s
    name
  end
end

class TTTGame # This is the game engine.
  LONG_SLEEP_LENGTH = 2.5
  SHORT_SLEEP_LENGTH = 1

  private

  attr_reader :board, :human, :computer
  attr_accessor :current_player, :first_to_move

  def initialize
    @board = Board.new
  end

  # rubocop:disable Naming/AccessorMethodName
  def get_computer_name
    computer_name = nil
    loop do
      puts "What do you want the computer to be named?"
      computer_name = gets.chomp.capitalize
      break unless computer_name.empty?
    end

    clear
    computer_name
  end

  def get_computer_marker
    puts "What would you like computer's marker to be?"
    puts "Any single character will work"
    computer_marker = nil
    loop do
      computer_marker = gets.chomp
      break unless computer_marker.empty? || computer_marker.size > 1
      puts "Hmmm...please enter one character to set as your marker."
    end
    clear
    computer_marker
  end

  def get_human_name
    human_name = nil
    loop do
      puts "What's your name?"
      human_name = gets.chomp.capitalize
      break unless human_name.empty?
    end
    clear
    human_name
  end

  def get_human_marker
    puts "What would you like your marker to be?"
    puts "Any single character will work."
    human_marker = nil
    loop do
      human_marker = gets.chomp
      break unless human_marker.empty? || human_marker.size > 1
      puts "Hmmm...please enter one character to set as your marker."
    end
    clear
    human_marker
  end
  # rubocop:enable Naming/AccessorMethodName

  def set_names_and_markers
    @human = Player.new(get_human_name, get_human_marker)
    @computer = Player.new(get_computer_name, get_computer_marker)
  end

  def set_first_player
    first = nil
    loop do
      puts "Who should go first? Enter 1 for #{@human} or 2 for #{@computer}?"
      puts "(Or enter 'IDK' if you want me to choose for you)"
      first = gets.chomp.upcase
      break if ["1", "2", "IDK"].include?(first)
    end
    first = ["1", "2"].sample if first == "IDK"
    self.current_player = human.marker if first == "1"
    self.current_player = computer.marker if first == "2"
  end

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
    puts "First to win 5 games wins!"
    sleep(LONG_SLEEP_LENGTH)
    clear
  end

  def display_goodbye_message
    display_final_score
    puts "Thanks for playing Tic-Tac-Toe!"
    puts "Goodbye."
  end

  def display_result
    clear_screen_and_display_board
    case board.detect_winning_marker
    when human.marker
      winner_message = "#{human} won this round!"
      human.score += 1
    when computer.marker
      winner_message = "#{computer} won this round!"
      computer.score += 1
    else
      winner_message = "Nobody won! It's a tie!"
    end
    puts winner_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp[0].downcase
      break if %w(y n).include?(answer)
    end
    answer == "y"
  end

  def display_current_score
    puts "Current Score:"
    puts "#{human} has #{human.score} points."
    puts "#{computer} has #{computer.score} points."
  end

  def display_final_score
    clear
    puts "Final Score:"
    puts "#{human}: #{human.score}"
    puts "#{computer}: #{computer.score}"
    sleep(LONG_SLEEP_LENGTH)
  end

  def display_board
    puts "#{human} is #{human.marker}"
    puts "#{computer} is #{computer.marker}"
    puts
    display_current_score
    puts
    board.draw
  end

  def clear_screen_and_display_board
    clear
    display_board
    sleep(SHORT_SLEEP_LENGTH)
  end

  def join_or(array)
    last = array.pop
    array.join(", ") + ", or #{last}"
  end

  def human_move
    puts "Choose a square: (#{join_or(board.available_square_keys)})."
    puts "(Check out the board to see each square's number.)"
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if board.available_square_keys.include?(choice)
      puts "Oops! That's not a valid choice."
    end
    board[choice] = human.marker
  end

  def computer_move
    if square_five_available?
      board[5] = computer.marker
    elsif opportunity?
      board[computer_opportunity_response(opportunity?)] = computer.marker
    elsif threat?
      board[computer_threat_response(threat?)] = computer.marker
    else
      board[board.available_square_keys.sample] = computer.marker
    end
  end

  def square_five_available?
    board[5] == Square::INITIAL_MARKER
  end

  def threat?
    Board::WINNING_LINES.each do |line|
      first_marker = board.squares[line[0]].marker
      second_marker = board.squares[line[1]].marker
      third_marker = board.squares[line[2]].marker
      markers = [first_marker, second_marker, third_marker]
      return line if markers.count(human.marker) == 2 &&
                     markers.count(Square::INITIAL_MARKER) == 1
    end
    nil
  end

  def computer_threat_response(line)
    line.select { |key| board[key] == Square::INITIAL_MARKER }[0]
  end

  def current_player_moves
    case current_player
    when human.marker
      human_move
      self.current_player = computer.marker
    when computer.marker
      computer_move
      self.current_player = human.marker
    end
  end

  def opportunity?
    Board::WINNING_LINES.each do |line|
      first_marker = board.squares[line[0]].marker
      second_marker = board.squares[line[1]].marker
      third_marker = board.squares[line[2]].marker
      markers = [first_marker, second_marker, third_marker]
      return line if markers.count(computer.marker) == 2 &&
                     markers.count(Square::INITIAL_MARKER) == 1
    end
    nil
  end

  def computer_opportunity_response(line)
    line.select { |key| board[key] == Square::INITIAL_MARKER }[0]
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def clear
    system "clear"
  end

  def five_round_winner?
    human.five_wins? || computer.five_wins?
  end

  def overall_winner
    [human, computer].max.to_s
  end

  def declare_overall_winner
    clear
    puts "#{overall_winner} has 5 points...#{overall_winner} wins!"
    sleep(LONG_SLEEP_LENGTH)
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break declare_overall_winner if five_round_winner?
      break unless play_again?
      reset
    end
  end

  def reset
    clear
    puts "Let's play again!"
    puts
    board.reset
    sleep(SHORT_SLEEP_LENGTH)
    clear
    set_first_player
  end

  public

  def play
    clear
    display_welcome_message
    set_names_and_markers
    set_first_player
    main_game
    display_goodbye_message
  end
end

game = TTTGame.new
game.play

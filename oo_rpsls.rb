class RPSgame
  attr_accessor :human, :computer, :all_moves, :round_count

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round_count = 1
    @all_moves = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human}!"
    puts "First to 10 wins!"
  end

  def display_goodbye_message
    puts "Thanks for playing, #{human}! Goodbye!"
  end

  def log_moves
    @all_moves << "Round #{round_count}: #{computer}: #{computer.move}.
      #{human}: #{human.move}"
  end

  def next_round
    @round_count += 1
  end

  def display_winner
    puts "#{human} chose #{human.move}"
    puts "#{computer} chose #{computer.move}"
    determine_round_winner
  end

  def display_score(final: false)
    score_type = final ? "Final" : "Current"
    puts "#{score_type} Score:"
    puts "#{computer}: #{computer.score}"
    puts "#{human}: #{human.score}"
  end

  def determine_round_winner
    if human.move > computer.move
      puts "#{@human} won! #{@computer} lost!"
      human.increment_score
    elsif computer.move > human.move
      puts "#{@human} lost! #{@computer} won!"
      computer.increment_score
    else
      puts "It's a tie!"
    end
  end

  def detect_ten_winner
    human.score == 10 || computer.score == 10
  end

  def display_final_winner
    puts "#{human.name} wins!" if human.score == 10
    puts "#{computer.name} wins!" if computer.score == 10
    display_score(final: true)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? Y/N?"
      answer = gets.chomp.upcase
      break if ["Y", "N"].include?(answer[0])
      puts "Hmmm...not sure what you mean #{human}"
    end
    answer == "Y"
  end

  def display_all_moves?
    answer = nil
    loop do
      puts "Would you like to see a summary of all rounds?"
      answer = gets.chomp.upcase
      break if ["Y", "N"].include?(answer[0])
      puts "Hmmm...not sure what you mean #{human}"
    end
    puts all_moves if answer[0] == "Y"
  end

  def play
    display_welcome_message
    loop do
      display_score
      human.choose_move
      computer.choose_move
      determine_round_winner
      log_moves
      next_round
      break display_final_winner if detect_ten_winner
      break unless play_again?
    end
    display_all_moves?
    display_goodbye_message
  end
end

class Move
  include Comparable

  attr_reader :choice

  CHOICES = ["ROCK", "PAPER", "SCISSORS", "LIZARD", "SPOCK"]

  def initialize(choice)
    @choice = choice
  end

  def to_s
    @choice
  end
end

class Rock < Move
  def >(other)
    other.instance_of?(Scissors) || other.instance_of?(Lizard)
  end
end

class Paper < Move
  def >(other)
    other.instance_of?(Rock) || other.instance_of?(Spock)
  end
end

class Scissors < Move
  def >(other)
    other.instance_of?(Paper) || other.instance_of?(Lizard)
  end
end

class Lizard < Move
  def >(other)
    other.instance_of?(Paper) || other.instance_of?(Spock)
  end
end

class Spock < Move
  def >(other)
    other.instance_of?(Scissors) || other.instance_of?(Rock)
  end
end

def create_move(choice)
  case choice
  when "ROCK" then Rock.new(choice)
  when "PAPER" then Paper.new(choice)
  when "SCISSORS" then Scissors.new(choice)
  when "LIZARD" then Lizard.new(choice)
  when "SPOCK" then Spock.new(choice)
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = 0
  end

  def to_s
    name.capitalize
  end

  def increment_score
    @score += 1
  end
end

def human?
  @player_type == :human
end

class Human < Player
  def set_name
    loop do
      puts "What is your name?"
      self.name = gets.chomp
      break unless name.empty?
      puts "C'mon, I need a name!"
    end
  end

  def choose_move
    choice = nil
    loop do
      puts "Please choose: ROCK, PAPER, SCISSORS, LIZARD, or SPOCK"
      choice = gets.chomp.upcase
      break if Move::CHOICES.include?(choice)
      puts "Sorry, that's an valid choice."
    end
    self.move = create_move(choice)
  end
end

class Computer < Player
  def set_name
    self.name = "Computer"
  end

  def choose_move
    self.move = create_move(Move::CHOICES.sample)
  end
end

RPSgame.new.play

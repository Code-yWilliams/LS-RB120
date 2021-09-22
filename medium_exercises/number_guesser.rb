# Create an object-oriented number guessing class for numbers
# in the range 1 to 100, with a limit of 7 guesses per game.
# The game should play like this:

# game = GuessingGame.new
# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game
# with a new number to guess with each call to #play.

class GuessingGame

  private

  def initialize
    self.remaining_guesses = 7
    self.winning_number = (1..100).to_a.sample
  end

  attr_accessor :winning_number, :remaining_guesses, :current_guess

  def display_remaining_guesses
    puts() unless remaining_guesses == 7
    puts "You have #{remaining_guesses} guesses remaining."
  end

  def player_guess
    print "Enter a number between 1 and 100: "
    guess = nil
    loop do
      guess = gets.chomp
      break if between_1_and_100?(guess) && integer?(guess)
      print"Invalid guess. Enter a number between 1 and 100: "
    end
    self.current_guess = guess.to_i
  end

  def between_1_and_100?(guess)
    (0..100).cover?(guess.to_i)
  end

  def integer?(guess)
    guess.to_i.to_s == guess
  end

  def win?
    current_guess == winning_number
  end

  def player_wins
    puts "That's the number!"
    puts
    puts "You won!"
  end

  def evaluate_guess
    output = if current_guess > winning_number
               "Your guess is too high."
             else
               "Your guess is too low."
             end
    puts output
  end

  def decrement_remaining_guesses
    self.remaining_guesses -= 1
  end

  def player_loses
    puts "You have no more guesses. You lost!"
  end

  def out_of_guesses?
    remaining_guesses == 0
  end

  public

  def play
    system "clear"
    initialize
    loop do
      display_remaining_guesses
      player_guess
      break player_wins if win?
      evaluate_guess
      decrement_remaining_guesses
      break player_loses if out_of_guesses?
    end
  end

end

game = GuessingGame.new
game.play

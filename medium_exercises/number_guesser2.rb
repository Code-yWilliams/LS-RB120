# In the previous exercise, you wrote a number guessing game that determines
# a secret number between 1 and 100, and gives the user 7 opportunities to guess the number.

# Update your solution to accept a low and high value when you create a
# GuessingGame object, and use those values to compute a secret number for the game.
# You should also change the number of guesses allowed so the user can always win if
# she uses a good strategy. You can compute the number of guesses with:

class GuessingGame

  private

  def initialize(lower_limit, upper_limit)
    self.lower_limit = lower_limit
    self.upper_limit = upper_limit
    self.range = (lower_limit..upper_limit)
    reset
  end

  attr_accessor :winning_number, :range, :upper_limit, :lower_limit, :remaining_guesses, :current_guess

  def display_remaining_guesses
    puts() unless remaining_guesses == (Math.log2(range.count).to_i + 1)
    puts "You have #{remaining_guesses} guesses remaining."
  end

  def player_guess
    print "Enter a number between #{lower_limit} and #{upper_limit}: "
    guess = nil
    loop do
      guess = gets.chomp
      break if within_range?(guess) && integer?(guess)
      print"Invalid guess. Enter a number between #{lower_limit} and #{upper_limit}: "
    end
    self.current_guess = guess.to_i
  end

  def within_range?(guess)
    range.cover?(guess.to_i)
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

  def reset
    self.winning_number = range.to_a.sample
    self.remaining_guesses = (Math.log2(range.count).to_i + 1)
  end

  public

  def play
    system "clear"
    reset
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

game = GuessingGame.new(501, 1500)
game.play

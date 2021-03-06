class Game21
  SHORT_SLEEP = 1.5
  LONG_SLEEP = 3

  attr_accessor :player, :dealer, :game_score, :deck

  def initialize
    self.player = Player.new
    self.dealer = Player.new
    self.game_score = 0
    self.deck = Deck.new
  end

  class Player
    include Comparable

    attr_accessor :score, :hand, :name, :initial_hand

    def initialize
      self.score = 0
      self.hand = Hand.new
    end

    class Hand
      attr_reader :cards, :initial
      attr_accessor :value

      def initialize
        @cards = []
        @value = 0
        @initial = Card.new("?", "?", 0)
      end

      def aces_last
        cards.partition { |card| card.name != :Ace }.flatten
      end

      def update_value
        self.value = calculate_value
      end

      def calculate_value # Too many lines
        val = 0
        aces_last.each do |card|
          val += case card.name
                 when :Ace
                   if val + 11 > 21
                     1
                   else
                     11
                   end
                 else
                   card.value[0]
                 end
        end
        val
      end

      def busted?
        value > 21
      end

      def display
        cards.each do |card|
          card.display
          sleep(SHORT_SLEEP)
        end
      end
    end

    def display_initial_hand
      puts "#{self} has:"
      sleep(SHORT_SLEEP)
      initial_hand.each do |card|
        card.display
        sleep(SHORT_SLEEP)
      end
    end

    def set_initial_hand
      init_hand = []
      case name
      when "Dealer"
        init_hand << hand.cards[0] << hand.initial
      else
        init_hand = hand.cards[0..1]
      end
      self.initial_hand = init_hand
    end

    def get_move
      move = nil
      loop do
        puts "Would you like to 'hit' or 'stay'?"
        move = gets.chomp.downcase
        break if %w(hit stay).include?(move)
        puts "I don't know what that means..."
      end
      move
    end

    def bust
      puts "#{self} busted!"
      puts
      sleep(SHORT_SLEEP)
    end

    def to_s
      name
    end

    def <=>(other_player)
      hand.calculate_value <=> other_player.hand.calculate_value
    end

    def hand_reset
      self.hand = Hand.new
    end
  end

  class Deck
    CARDS = { "A" => [1, 11], "2" => [2], "3" => [3], "4" => [4],
              "5" => [5], "6" => [6], "7" => [7], "8" => [8],
              "9" => [9], "10" => [10], "J" => [10], "Q" => [10], "K" => [10] }

    SUITS = %w(??? ??? ??? ???)

    attr_accessor :cards

    def initialize
      self.cards = []
      SUITS.each do |suit|
        CARDS.each do |name, value|
          cards << Card.new(name, suit, value)
        end
      end
      cards
    end

    def shuffle
      puts "Shuffling!"
      puts
      cards.shuffle!
      sleep(LONG_SLEEP)
    end

    def deal_to(player, card_count = 1)
      puts "Dealing #{card_count} to #{player}!"
      puts
      card_count.times do
        player.hand.cards << cards.pop
      end
      player.hand.update_value
      player.set_initial_hand unless card_count == 1
      sleep(LONG_SLEEP)
    end
  end

  class Card
    attr_accessor :name, :suit, :value

    def initialize(name, suit, value)
      self.name = name
      self.suit = suit
      self.value = value
    end

    def to_s
      "#{name} of #{suit}"
    end

    def display
      if name == "10"
        display_ten
      else
        display_non_ten
      end
      puts self
      puts
    end

    def display_non_ten
      puts " ____   "
      puts "|#{name}   |  "
      puts "|    |  "
      puts "|   #{suit}|  "
      puts " ????????????"
    end

    def display_ten
      puts " _____   "
      puts "|#{name}   |  "
      puts "|     |  "
      puts "|    #{suit}|  "
      puts " ???????????????"
    end
  end

  def welcome # Too many lines
    clear
    puts "Welcome to 21!"
    sleep(LONG_SLEEP)
    initialize_names
    explain_rules if rules?
    puts
    puts "Press 'enter' to begin"
    loop do
      break if gets.chomp
    end
    clear
  end

  def get_name # Too many lines
    clear
    puts "What is your name?"
    name = nil
    loop do
      name = gets.chomp.capitalize
      break unless name.empty?
      puts "Um, excuse me. Can you please enter your name?"
    end
    puts "Thanks, #{name}."
    sleep(SHORT_SLEEP)
    name
  end

  def explain_rules
    clear
    puts "Ok; here's how it works:"
    sleep(SHORT_SLEEP)
    puts <<-FFF

    The goal of 21 is to amount your card values as close to 21 as
    possible without exceeding, or 'busting' it.

    Moreover, you have to beat whatever hand the dealer has drawn;
    if they have 20 and you have 19, you lose the hand.

    When it is your turn:
    'Hit' if you want to take one card from the deck.
    'Stay' if not.

    Card Values:
    Ace: 1 or 11
    Two through Ten: Face Value
    Jack King Queen: 10

    Good Luck!

    FFF
  end

  def rules?
    puts "Would you like to read the rules? (y/n)"
    puts
    response = nil
    loop do
      response = gets.chomp.downcase[0]
      break if %w(y n).include?(response)
      "Hmm....I don't understand. (y/n)???"
    end
    response == "y"
  end

  def display_initial_hands
    dealer.display_initial_hand
    player.display_initial_hand
  end

  def initialize_names
    player.name = get_name
    dealer.name = "Dealer"
    sleep(SHORT_SLEEP)
    clear
  end

  def player_turn # Too many lines, ABC too high
    loop do
      sleep(SHORT_SLEEP)
      clear
      break player.bust if player.hand.busted?
      if player.get_move == "hit"
        puts "#{player} chose to hit!"
        puts
        sleep(SHORT_SLEEP)
        deck.deal_to(player, 1)
        sleep(SHORT_SLEEP)
        puts "#{player} has:"
        player.hand.display
      else
        puts "#{player} chose to stay!"
        puts
        sleep(SHORT_SLEEP)
        break
      end
    end
    clear
  end

  def dealer_turn # Too many lines, ABC too high
    loop do
      break dealer.bust if dealer.hand.busted?
      if dealer.hand.value >= 17
        puts "#{dealer} chose to stay!"
        puts
        sleep(SHORT_SLEEP)
        break
      else
        puts "#{dealer} chose to hit!"
        puts
        sleep(SHORT_SLEEP)
        deck.deal_to(dealer, 1)
        sleep(SHORT_SLEEP)
      end
    end
  end

  def find_winner # Too many lines, ABC too high
    if player.hand.busted?
      dealer.score += 1
      dealer.to_s
    elsif dealer.hand.busted?
      player.score += 1
      plsyer.to_s
    elsif player == dealer
      "Tie! Nobody"
    else
      w = [player, dealer].max.to_s
      w == player ? player.score += 1 : dealer.score += 1
      w
    end
    winner
  end

  def display_results
    puts "#{find_winner} wins!"
    puts
    answer = nil
    loop do
      puts "Would you like to see the final hands? (y/n)"
      puts
      answer = gets.chomp.downcase[0]
      break if %w(y n).include?(answer)
    end
    display_final_hands if answer == "y"
  end

  def display_round_scores
    clear
    sleep(SHORT_SLEEP)
    puts "Final hand values:"
    puts
    puts "#{dealer}: #{dealer.hand.value}"
    puts
    puts "#{player}: #{player.hand.value}"
    puts
    sleep(LONG_SLEEP)
  end

  def display_final_hands
    clear
    puts "Final hands:"
    puts
    sleep(SHORT_SLEEP)
    puts "#{dealer} had:"
    dealer.hand.display
    sleep(SHORT_SLEEP)
    puts "#{player} had:"
    player.hand.display
    puts
  end

  def play_again?
    puts "Would you like to play another round? (y/n)"
    answer = nil
    loop do
      answer = gets.chomp.downcase[0]
      break if %w(y n).include?(answer)
    end
    answer == "y"
  end

  def clear
    system "clear"
  end

  def reset
    player.hand_reset
    dealer.hand_reset
    self.deck = Deck.new
  end

  def main_game # Too many lines, ABC too high
    loop do
      clear
      deck.shuffle
      deck.deal_to(player, 2)
      deck.deal_to(dealer, 2)
      clear
      display_initial_hands
      player_turn
      dealer_turn unless player.hand.busted?
      display_round_scores
      display_results
      break unless play_again?
      reset
    end
  end

  def play
    welcome
    main_game
  end
end

game = Game21.new
game.play

module Formatable
  private

  def joinand(arr, delimiter=', ', word='&')
    case arr.size
    when 0 then ''
    when 1 then arr.last.to_s
    when 2 then arr.join(" #{word} ")
    else
      arr[0..-2].join(delimiter) + " #{word} #{arr[-1]}"
    end
  end
end

module Retreivable
  private

  def fetch(prompt, responses)
    answer = nil
    loop do
      puts prompt
      answer = gets.chomp.downcase.strip
      break if responses.include? answer
      puts "Sorry. That's not a valid response."
    end
    answer
  end
end

module Displayable
  private

  def display_welcome(game_name)
    clear
    spacer
    puts "====== Welcome to #{game_name}! ======"
  end

  def display_goodbye
    clear
    puts "Thanks for playing! Goobye!"
  end

  def spacer
    puts ''
  end

  def clear
    system 'clear'
  end

  def display_you_win
    puts "You win!"
  end

  def display_opponent_win
    puts "#{dealer.name} wins!"
  end

  def display_you_busted
    puts "You busted! #{dealer.name} wins."
  end

  def display_opponent_busted
    puts "#{dealer.name} busted! You win!"
  end

  def display_tie
    puts "It's a tie!"
  end
end

class Participant
  include Displayable

  attr_reader :name, :hand, :score

  def initialize
    @name = choose_name
    @hand = Hand.new
    @score = 0
  end

  def busted?
    hand.total > TwentyOne::GOAL_TOTAL
  end

  def >(other_player)
    hand.total > other_player.hand.total
  end

  def score_point
    self.score += 1
  end

  def reset_score
    self.score = 0
  end

  private

  attr_writer :hand, :score

  def hit(deck)
    hand << deck.deal
    hand.add_up
    spacer
    hand.display(name)
  end
end

class Player < Participant
  include Retreivable

  def turn(deck)
    until busted? || stay?
      puts 'You chose hit!'
      hit(deck)
    end
    puts "You stayed at #{hand.total}." unless busted?
  end

  private

  def choose_name
    answer = nil
    spacer
    loop do
      puts "What's your name?"
      answer = gets.chomp.strip
      break if valid_name?(answer)
      puts "Sorry. That's not a valid name."
    end
    answer
  end

  def valid_name?(answer)
    !answer.delete(' ').empty? && !Dealer::NAMES.include?(answer)
  end

  def stay?
    %w(s stay).include? choose_move
  end

  def choose_move
    spacer
    answer = fetch("Would you like to [h]it or [s]tay?", %w(h hit s stay))
    spacer
    answer
  end
end

class Dealer < Participant
  DEALER_MIN = 17
  NAMES = %w(Sonny Wall-E C3PO Ultron Hal BB-8 CHAPPiE)

  def turn(deck)
    puts "#{name}'s turn..."
    until stay?
      spacer
      puts "#{name} hit!"
      sleep(1.5)
      hit(deck)
    end
    spacer
    puts "#{name} stayed at #{hand.total}." unless busted?
    sleep(3)
  end

  private

  def choose_name
    NAMES.sample
  end

  def stay?
    hand.total >= DEALER_MIN
  end
end

class Hand
  include Formatable

  attr_reader :cards, :total

  def initialize
    @cards = []
    @total = nil
  end

  def <<(obj)
    cards << obj
  end

  def display(name)
    puts "#{name}'s hand:"
    puts "#{joinand(cards)} totaling: #{total}"
  end

  def display_one(name)
    puts "#{name}'s hand:"
    puts "#{cards.first} & [???]"
  end

  def add_up
    self.total = cards.map(&:point_value).reduce(:+)
    adjust_aces
  end

  def reset
    self.cards = []
  end

  private

  attr_writer :cards, :total

  def adjust_aces
    count_aces.times { self.total -= 10 if total > TwentyOne::GOAL_TOTAL }
  end

  def count_aces
    cards.count { |card| card.value == 'A' }
  end
end

class Deck
  SUITS = ["\u2663", "\u2660", "\u2665", "\u2666"]
  VALUES = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

  def initialize
    @cards = nil
    reset
  end

  def reset
    @cards = SUITS.product(VALUES).map { |s, v| Card.new(s, v) }.shuffle
  end

  def deal
    @cards.shift
  end
end

class Card
  ACE_VALUE = 11
  FACE_CARD_VALUE = 10

  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def point_value
    if %w(J Q K).include? @value
      FACE_CARD_VALUE
    elsif @value == 'A'
      ACE_VALUE
    else
      @value.to_i
    end
  end

  def to_s
    "[#{@value} #{@suit}]"
  end
end

class TwentyOne
  FIRST_CARDS_NUM = 2
  GOAL_TOTAL = 21
  SCORE_TO_WIN = 3

  include Displayable, Retreivable

  def initialize
    display_welcome('Twenty-One')
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @exit_early = false
  end

  def start
    display_welcome('Twenty-One')
    display_rules
    continue_or_quit
    play_match unless exit_early
    display_goodbye
  end

  private

  attr_reader :deck, :player, :dealer
  attr_accessor :exit_early

  def display_rules
    spacer
    puts "- Get as close to #{GOAL_TOTAL} as possible without going over."
    puts "- First to #{SCORE_TO_WIN} wins the match!"
  end

  def play_match
    loop do
      play_round
      break if exit_early
      display_champ
      break unless play_again?
      reset_match
    end
  end

  def play_round
    loop do
      deal_cards
      take_turns
      show_result
      update_score
      break if champ?
      continue_or_quit
      break if exit_early
      reset_round
    end
  end

  def champ?
    [player, dealer].map(&:score).include? SCORE_TO_WIN
  end

  def take_turns
    show_initial_hands
    player.turn(deck)
    sleep(2)
    clear
    dealer.turn(deck) unless player.busted?
    show_final_hands
  end

  def reset_round
    player.hand.reset
    dealer.hand.reset
    deck.reset
  end

  def reset_match
    reset_round
    player.reset_score
    dealer.reset_score
  end

  def deal_cards
    FIRST_CARDS_NUM.times do
      player.hand << deck.deal
      dealer.hand << deck.deal
    end
    total_hands
  end

  def total_hands
    player.hand.add_up
    dealer.hand.add_up
  end

  def show_initial_hands
    dealer.hand.display_one(dealer.name)
    spacer
    player.hand.display(player.name)
  end

  def show_final_hands
    clear
    puts "===================="
    dealer.hand.display(dealer.name)
    spacer
    player.hand.display(player.name)
    puts "===================="
    spacer
  end

  def show_result
    if player.busted?
      display_you_busted
    elsif dealer.busted?
      display_opponent_busted
    elsif player > dealer
      display_you_win
    elsif dealer > player
      display_opponent_win
    else display_tie
    end
  end

  def update_score
    increment_score
    show_score
  end

  def increment_score
    if player.busted? || (dealer > player && !dealer.busted?)
      dealer.score_point
    elsif dealer.busted? || player > dealer
      player.score_point
    end
  end

  def show_score
    spacer
    puts "#{player.name}'s score: #{player.score}"
    puts "#{dealer.name}'s score: #{dealer.score}"
  end

  def continue_or_quit
    spacer
    answer = fetch("Press enter to continue, or q to quit.", ['', 'q', 'quit'])
    clear
    self.exit_early = !answer.empty?
  end

  def display_champ
    spacer
    puts "=================================================="
    case SCORE_TO_WIN
    when player.score then puts "You've won the match!!".center(50)
    else puts "#{dealer.name} won the match. Better luck next time!".center(50)
    end
    puts "=================================================="
  end

  def play_again?
    spacer
    answer = fetch("Would you like to play again? (y / n)", %w(y yes n no))
    clear
    answer == 'y' || answer == 'yes'
  end
end

TwentyOne.new.start

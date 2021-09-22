# In the previous two exercises, you developed a Card class and a Deck class.
# You are now going to use those classes to create and evaluate poker hands.
# Create a class, PokerHand, that takes 5 cards from a Deck of Cards and
# evaluates those cards as a Poker hand. If you've never played poker before,
# you may find this overview of poker hands useful.

# You should build your class using the following code skeleton:

# Include Card and Deck classes from the last two exercises.

class Card
  attr_reader :rank, :suit, :value

  include Comparable

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = find_value
  end

  def find_value
    value = case rank
            when "Ace" then 14
            when "King" then 13
            when "Queen" then 12
            when "Jack" then 11
            else rank 
            end
    value
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :cards

  def initialize
    reset
  end

  def draw
    card = cards.pop
    initialize if cards.empty?
    card
  end

  private

  def reset
    self.cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
end

class PokerHand
  HIGH_STRAIGHT_VALUES = [[7, 8, 9, 10, "Jack"], [8, 9, 10, "Jack", "Queen"],
  [9, 10, "Jack", "Queen", "King"], [10, "Jack", "Queen", "King", "Ace"]]

  attr_accessor :deck, :hand_cards

  def initialize(hand)
    if hand.instance_of?(Deck)
      self.hand_cards = hand.cards.sample(5)
    else
      self.hand_cards = hand
    end
  end

  def print
    hand_cards.each { |card| puts card}
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def to_s
    hand_cards
  end

  private

  def royal_flush?
    royals = [10, "Jack", "Queen", "King", "Ace"]
    (royals.all? { |rank| (hand_cards.count { |card| card.rank == rank }) == 1 }) &&
    flush?
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    flag = nil
    Deck::RANKS.each do |rank|
      flag = true if (hand_cards.count { |card| card.rank == rank }) == 4 
    end
    flag
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    (hand_cards.map { |card| card.suit }.uniq.count) == 1
  end

  def straight?
    ascending_values? ||
    (HIGH_STRAIGHT_VALUES.any? do |straight_array|
      hand_cards.all? { |card| straight_array.include?(card.rank) }
    end)
  end

  def ascending_values?
    sorted_hand = hand_cards.sort
    ((sorted_hand[0].value + 1) == (sorted_hand[1].value)) &&
    ((sorted_hand[1].value + 1) == (sorted_hand[2].value)) &&
    ((sorted_hand[2].value + 1) == (sorted_hand[3].value)) &&
    ((sorted_hand[3].value + 1) == (sorted_hand[4].value))
  end

  def three_of_a_kind?
    flag = nil
    Deck::RANKS.each do |rank|
      flag = true if (hand_cards.count { |card| card.rank == rank }) == 3
    end
    flag
  end

  def two_pair?
    flag = 0
    Deck::RANKS.each do |rank|
      flag += 1 if (hand_cards.count { |card| card.rank == rank }) == 2
    end
    flag == 2
  end

  def pair?
    flag = nil
    Deck::RANKS.each do |rank|
      flag = true if (hand_cards.count { |card| card.rank == rank }) == 2
    end
    flag
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
# Using the Card class from the previous exercise, create a Deck class
# that contains all of the standard 52 playing cards.
# Use the following code to start your work:

# The Deck class should provide a #draw method to deal one card.
# The Deck should be shuffled when it is initialized and, if it
# runs out of cards, it should reset itself by generating a new
# set of 52 shuffled cards.

# deck = Deck.new
# drawn = []
# 52.times { drawn << deck.draw }
# drawn.count { |card| card.rank == 5 } == 4
# drawn.count { |card| card.suit == 'Hearts' } == 13

# drawn2 = []
# 52.times { drawn2 << deck.draw }
# drawn != drawn2 # Almost always.

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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.

hand = 
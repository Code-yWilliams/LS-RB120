class Card
  SUIT_RANKS = {"Diamonds" => 1, "Clubs" => 2, "Hearts" => 3, "Spades" => 4} # FURTHER EXPLORATION

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
    if rank == other.rank # FURTHER EXPLORATION
      SUIT_RANKS[suit] <=> SUIT_RANKS[other.suit]
    else
      value <=> other.value
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new("Ace", "Diamonds"), Card.new("Ace", "Clubs")]
puts cards.min

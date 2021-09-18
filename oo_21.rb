=begin

A deck of 52 cards
The deck is made up of four sets of 13 cards
The four sets are: King, Queen, Spades, Clubs
Each set contains the cards:
Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
Cards Two through Ten are face value
Cards Jack, Queen, Kind are valued at 10
Card Ace is valued at 1 OR 11. If a value of 11 will case a player to bust, the value should be 1.

At game play:
Each player is dealt 2 cards. 
On each player's turn, they consider the values of their two cards and decide if they 
want to hit (receive one more card from the deck), or stay (receive no additional cards)
and submit their current hand to go against the other player's hand.
A player can hit as many times as they want until 1. they decide to stay and submit
their value, or 2. the value of they're hand is more than 21, in which case they "bust" and automatically lose
the round. 

If both players submit their final hand values (stay, not bust) - then the values are
compared and they player whose hand had the highest value wins the round.
If the values are even, then it is a tie and nobody wins.
The winner's score is incremented after each round.

THe game can be replayed until one of the player's score reaches 5.
The player who reaches 5 wins the game.

Nouns (classes): Game, Deck, Card (Card Name, Suit, Value), Player (Dealer and Human), Hand_Value, Score, Result
Verbs: (methods): Play, Initialize_Deck, Shuffle, Deal, Consider, Hit, Stay, Submit, Compare, Increment_Score, Give_Result
Adjectives (boolean return values): busted? higher?

=end

class Game21
  SHORT_SLEEP = 1.5
  LONG_SLEEP = 3

  attr_accessor :player, :dealer, :game_score, :deck

  def initialize
    self.player = Player.new("You")
    self.dealer = Player.new("Dealer")
    self.game_score = 0
    self.deck = Deck.new
  end

  class Player
    attr_accessor :score, :hand, :name
    def initialize(name)
      self.name = name
      self.score = 0
      self.hand = Hand.new
    end

    class Hand
      attr_reader :cards, :value

      def initialize
        @cards = []
        @value = 0
      end

      def aces_last
        cards.partition { |card| card.name != :Ace }.flatten
      end

      def update_value
        self.value = calculate_value
      end

      def calculate_value
        val = 0
          aces_last.each do |card|
            case card.name
            when :Ace
              if (val + 11 > 21)
                val += 1
              else
                val += 11
              end
            else
              val += card.value
            end
          end
          val
      end

      def busted?
        value > 21
      end

      def increment_score
        self.score += 1
      end
    end

    def to_s
      name
    end

  end

  class Deck
    CARDS = { Ace: [1, 11], Two: [2], Three: [3], Four: [4],
          Five: [5], Six: [6], Seven: [7], Eight: [8],
          Nine: [9,] Ten: [10J, Jack: [10] Queen: [10], King: [10]) }

    SUITS = %w(Hearts Diamonds Clubs Spades)

    attr_reader :cards

    def initialize
      self.cards = initialize_deck
    end

    def initialize_deck
      deck = []
      SUITS.each do |suit|
        CARDS.each do |name, value|
          deck << Card.new(name, suit, value)
        end
      end
      deck
    end

    def shuffle
      puts "Shuffling!"
      self.cards.shuffle!
      sleep(LONG_SLEEP)
    end

    def deal_to(player, card_count = 1)
      puts "Dealing #{card_count} to #{player}!"
      card_count.times do 
        player.hand.cards << cards.pop
      end
      player.update_value
      sleep(SHORT_SLEEP)
    end
    
  end

  class Card
    attr_accessor :name, :suit, :value

    def initialize(name, suit, value)
      self.name = name
      self.suit = suit
      self.value = value
    end

  end

  def main_game
    shuffle
    deal_to(player, 2)
    deal_to(dealer, 2)
    display_initial_hands
    player_turn
    dealer_turn
    compare_hands
    display_results
  end

  def play
    welcome
    get_name
    rules?
    main_game
  end

end

game = Game21.new
game.play

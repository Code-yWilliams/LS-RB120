# # We discovered Gary Bernhardt's repository for finding out
# # whether something rocks or not, and decided to adapt it for a simple example.

# class AuthenticationError < Exception; end

# # A mock search engine
# # that returns a random number instead of an actual count.
# class SearchEngine
#   def self.count(query, api_key)
#     unless valid?(api_key)
#       raise AuthenticationError, 'API key is not valid.'
#     end

#     rand(200_000)
#   end

#   private

#   def self.valid?(key)
#     key == 'LS1A'
#   end
# end

# module DoesItRock
#   API_KEY = 'LS1A'

#   class NoScore; end

#   class Score
#     def self.for_term(term)
#       positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
#       negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

#       positive / (positive + negative)
#     rescue Exception
#       NoScore
#     end
#   end

#   def self.find_out(term)
#     score = Score.for_term(term)

#     case score
#     when NoScore
#       "No idea about #{term}..."
#     when 0...0.5
#       "#{term} is not fun."
#     when 0.5
#       "#{term} seems to be ok..."
#     else
#       "#{term} rocks!"
#     end
#   rescue Exception => e
#     e.message
#   end
# end

# # Example (your output may differ)

# puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
# puts DoesItRock.find_out('Rain')        # Rain is not fun.
# puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

# In order to test the case when authentication fails, we can simply set API_KEY
# to any string other than the correct key. Now, when using a wrong API key, we
# want our mock search engine to raise an AuthenticationError, and we want the find_out
# method to catch this error and print its error message API key is not valid.

# Is this what you expect to happen given the code?

# And why do we always get the following output instead?

#   Sushi rocks!
#   Rain rocks!
#   Bug hunting rocks!

class AuthenticationError < StandardError; end # SOLUTION: don't have your custom exceptions
# inherit from Exception - have them inherit from StandardError instead to avoid issues
# (Exception is too broa and its errors are important - we don't want to rescue them)

# A mock search engine
# that returns a random number instead of an actual count:
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    rescue ZeroDivisionError # SOLUTION: we want the AuthenticationError
      # to reach the DoesItRock::find_out class method so that it can be rescued, but
      # it won't if we just rescue the general Exception class. But we still want to rescue 
      # any ZeroDivisionError errors, so we do. 
      NoScore.new # SOLUTION: the case statement in Score::find_out uses === to test for equivalence.
      # so when it tests to see if the Score::for_term return value captured by the score local variable 
      # is NoScore, it is really asking "does score point to an instance of class NoScore?"
      # Which can only be true if the return value of the ZeroDivisionError is a NoScore object
      # (returning the class itself like in the original solution will result in the case statement
      # determining that score !=== NoScore). So we rescue the ZeroDivisionError with a new instance of
      # class NoScore
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue StandardError => e # SOLUTION: our AuthenticationError inherits from StandardError
    # which makes it an exception class. The default for the message method on a custom exception
    # is a string version of the exception name.  In this case, this is what is outputted if
    # there is an authentication error (which can be raised in the SearchEngine::count class method)
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!
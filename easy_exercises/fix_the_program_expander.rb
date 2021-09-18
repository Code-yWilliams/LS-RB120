# What is wrong with the following code? What fix(es) would you make?

# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     self.expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

# expander = Expander.new('xyz')
# puts expander

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# After ruby 2.7, nothing is wrong because you can call a private
# method using .self (explicit caller). For versions prior to 2.7,
# this code would only wokr if you call the private method without
# .self within the to_s method definition
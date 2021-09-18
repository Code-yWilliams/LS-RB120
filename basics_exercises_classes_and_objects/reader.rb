# Using the code from the previous exercise (Hello Sophie 2),
# add a getter method named #name and invoke it in place of @name in #greet.

# class Cat
#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{@name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

class Cat
  attr_reader :cat
  def initialize(name)
    @name = name
  end
  def greet
    puts "Hello! My name is #{name}!"
  end
end
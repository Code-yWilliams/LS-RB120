# Using the code from the previous exercise, add a parameter to
# initialize that provides a name for the Cat object.
# Use an instance variable to print a greeting with the provided name.
# (You can remove the code that displays I'm a cat!.)

# class Cat
#   def initialize
#     puts "I'm a cat!"
#   end
# end

# kitty = Cat.new('Sophie')

class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #@name!"
  end
end

sophie = Cat.new("Sophie")
# Using the following code, create a class named Cat that
# prints a greeting when #greet is invoked.
# The greeting should include the name and color of the cat.
# Use a constant to define the color.

# kitty = Cat.new('Sophie')
# kitty.greet

class Cat
  attr_accessor :name

  COLOR = "purple"

  def initialize(name)
    self.name = name
  end

  def greet
    "Hello! My name is #{self.name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
p kitty.greet
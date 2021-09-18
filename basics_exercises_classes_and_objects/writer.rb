# Using the code from the previous exercise (Reader), add a setter method named
# #name=. Then, rename kitty to 'Luna' and invoke #greet again.

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  def name=(name) # this manually created a setter. could also just use attr_writer
    @namr = name
  end
  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = "Luna"
kitty.greet
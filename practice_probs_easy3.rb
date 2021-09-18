# 1
# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

hello = Hello.new
hello.hi

# ANSWER:
# The hi method is invoked, which invokes greet("Hello").
# Ruby looks for a greet method and finds one in the
# Greeting superclass, which calls puts with the argument
# as an argument to puts. This outputs "Hello"

hello = Hello.new
hello.bye

# ANSWER:
# This raises an exception becayse the bye method is defined
# in the Goodbye class only. The Hello class - which is what hello
# is an instance of - does not inherit from Goodbye. We get 
# NoMethodError

hello = Hello.new
hello.greet

# ANSWER:
# This raises an ArgumentError exception. greet is called on 
# the hello object. Ruby finds the greet method in the Greeting
# superclass. But this method requires one argument which is passes
# as an argument to the puts method. greet is not called with an
# argument, so we get the error.

hello = Hello.new
hello.greet("Goodbye")

# ANSWER:
# This prints "Goodbye" to the console. greet is called on the
# hello object and Ruby finds the method within the Greeting
# superclass. It passes in "Goodbye" as an argument, and the
# method proceeds to pass the argument to the puts method,
# printing it out.

Hello.hi

# ANSWER:
# This raises a NoMethodError exception. We are calling a hi method
# directly on the Hello class. But the Hello class does not have
# any class methods defined within it - only instance methods. This
# code would only run if there were a class method named hi defined within
# Hello


# 2
# In the last question we had the following classes:
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message.
# How would you fix this?

# Answer:
# We fix this by defining a class method called hi as
# follows:
class Hello < Greeting
  def self.hi
    Hello.new.greet("Hello")
  end
end
# We cannot just invoke greet("Hello") within the class method
# definition because the greet method is only available to instances
# of the class - not the class itself.


# 3
# When objects are created they are a separate realization of a
# particular class. Given the class below, how do we create two
# different instances of this class with separate names and ages?
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# ANSWER:
first = AngryCat.new(14, "Fluffy")
second = AngryCat.new(3, "Princess")


# 4
# Given the class below, if we created a new instance of the class
# and then called to_s on that instance we would get something like
# "#<Cat:0x007ff39b356d30>"
class Cat
  def initialize(type)
    @type = type
  end
end

# How could we go about changing the to_s output on this method to look like this:
# I am a tabby cat? (assuming "tabby" is the type we passed in during instantiation).

class Cat
  attr_reader :type
  def initialize(type)
    @type = type
  end
  def to_s
    "I'm a #{type} cat"
  end
end


# 5
# If I have the following class:
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer # ANSWER: undefined method - we don't have an instance
# method called manufacturer to call on tv - only a class method
# called manufacturer exists
tv.model # ANSWER: the model is outputted (or whatever the model
# instance method does)

Television.manufacturer # ANSWER: the manufacturer is outputted
# (or whatever the manufacturer class method does)
Television.model # ANSWER: NoMethodError - we don't have a class
# method called model - we only have an instance method called model
# and it can't be called on a class


# 6
# If we have a class such as the one below:
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
# In the make_one_year_older method we have used self.
# What is another way we could write this method so we don't have to use the self prefix?

# ANSWER:
def make_one_year_older
  @age += 1
end


# 7
# What is used in this class but doesn't add any value?
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# ANSWER:
# For now, we don't use the getter or setter methods created by 
# attr_accessor, so that is not adding any value. BUT it does
# ass potential value in case we need to get/set the instance
# variables later on.
# The most useless part of this code is the return keyword within
# the definition of the information class method. Methods
# automatically return the value of the last expression evaluated
# within the method, so there is no need to explicitly return using the
# return key word. You can just implicitly return the string by
# leaving it as the last line of the method.
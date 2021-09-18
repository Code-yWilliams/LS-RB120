# 1
# You are given the following code:
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:

oracle = Oracle.new
oracle.predict_the_future

# ANSWER:
# This code returns "You will X" where X is one of the elements in
# ["eat a nice lunch", "take a nap soon", "stay at work late"]
# the element is chosen randomly thanks to the Array#sample method



# 2
# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:
trip = RoadTrip.new
trip.predict_the_future

# ANSWER:
# This code returns "You will X" where X is one of the elements in
# ["visit Vegas", "fly to Fiji", "romp in Rome"]
# the element is chosen randomly thanks to the Array#sample method.
# Since we are calling predict_the_future on an instance of Roadtrip,
# Ruby will start in Roadtrip when trying to resolve method names. So even though
# it runs the method found in the Oracle class, it still looks in the Roadtrip class
# first when trying to resolve the invocation of the choices method


# 3
# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# ANSWER:
# To find where Ruby will look for a method when that method is called,
# call the #ancestors method on the class of the calling object
# (not the calling object itself - that won't work).
# The lookup chain / path for Orange is:
# [Orange, Taste, Object, PP::ObjectMixin, Kernel, BasicObject]
# The lookup chain / path for HotSauce is:
# [HotSauce, Taste, Object, PP::ObjectMixin, Kernel, BasicObject].
# Note: if the method appears nowhere in the chain, a NoMethodError exception is raised


# 4
# What could you add to this class to simplify it and remove two methods
# from the class definition while still maintaining the same functionality?
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# ANSWER:
# This class has a getter method for the @type instance variable, and a
# setter methof for the @type instance variable.
# We could remove both of these and just add attr_accessor :type
# at the top. The attr_accessor method automatically provides a getter
# and setter method for the instance variable matching the symbol
# passed to it as an argument. Once there is a getter method for an
# instance variable, it is best practice to use it any time
# you reference the instance variable associated with it. That way
# if you change the way in which the getter method dislpays the value,
# you don't have to adjust your code anywhere but within the getter method
# definition. So in the body of describe_type, we should replace
# @type with type (the getter method call)


# 5
There are a number of variables listed below.
What are the different types and how do you know which is which?

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

# ANSWER:
# excited_dog is a local variable. it is just a plain variable name
# @excited_dog is an instance variable as denoted by one @ symbol
# at its beginning
# @@excited_dog is a class variable as denoted by two @ symbols at
# its beginning
# variable prefix - or lack thereof - indicates its type


# 6
# If I have the following class:
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know?
# How would you call a class method?

# ANSWER:
# manufacturer is a class method. We can tell from the prefix self.
# in the method definition. The self key word in the body of a class
# indicates the class itself. So a method defined with self. indicates
# a method that will be called directly on the class.  (a class method).
# To call a class method, call it directly on the class.
# e.g. Television.manufacturer
# This invocation should NOT include the self keyword because that part
# is only necessary in the method definition to show the class that it
# is a class method instead of an instance variable


# 7
# If we have a class such as the one below:
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works.
# What code would you need to write to test your theory?

# ANSWER:
# @@cats_count is a class variable that tracks how many
# instances of class Cat are created. Each time an object
# of class Cat is instantiated, the initialize method
# is run, which increments the value of @@cats_count by 1.
# To test this, we would need to instantiate a Cat object
# and then run the cats_count class method to see the value of
# the class variable:
kitty = Cat.new
puts Cat.cats_count # we could build this into the initialize
# method so that the current number of cat objects is printed
# during each instantiation from class Cat


# 8
# If we have this class:
class Game
  def play
    "Start the game!"
  end
end

# And another class:
class Bingo
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to allow it to inherit
# the play method from the Game class?

# ANSWER:
# To have a class inherit from another, we need to indicate
# the inheritance on the top line of the class definition.
# The super class goes to the right of the sub class,
# with both of them separated by a < sumbol as follows:
class Bingo < Game
  def rules_of_play
    #rules of play
  end
end


# 9
# If we have this class:
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to the Bingo class,
# keeping in mind that there is already a method of this name
# in the Game class that the Bingo class inherits from.

# ANSWER:
# If we define a play method in the Bingo class, then that method
# will override the play method in the Game superclass. This means
# that any time .play is called on an object of class Bingo, the
# new method will be run and the original method from class Game will
# be ignored. As soon as Ruby finds a method that matches the
# name of a method call, it uses that method and stops looking.
# So Ruby will never get to class Game when looking for the play method
# since there is one within the Bingo class.


# 10
# What are the benefits of using Object Oriented Programming in Ruby?
# Think of as many as you can.

# 1. Hides parts of a program from parts of the program that don't need it.
# 2. Allows us to use code that mirrors real-life because we can design
#    our own data types. This is easier to conceptualize.
# 3. Allows for modular code that can be adjusted without impacting other
#    parts of the program.
# 4. Allows us to use the same methods on many different object types.
# 5. Allows us to mirror real-life relationships in code.
# 6. Allows us to think about code more abstractly.
# 7. Provides common functionality without code duplication.
# 8. Code is easier to organize
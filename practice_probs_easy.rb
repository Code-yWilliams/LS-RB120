# 1
# Which of the following are objects in Ruby?
# If they are objects, how can you find out what class they belong to?

# ANSWER:
# They are all objects. To find out what classes they belong to, just call .class on
# each of them


# 2
# If we have a Car class and a Truck class and we want to be able to go_fast,
# how can we add the ability for them to go_fast using the module Speed?
# How can you check if your Car or Truck can now go fast?
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

#ANSWER:
# to add the ability from a module, just include the module
# in the classes you want to provide the functionality to.
# to see if an object will respond to a method, use .respond_to()
# and pass it a symbol representation of the method you are checking.
# OR you can just instntiate an object and run the method in question


# 3
# In the last question we had a module called Speed which contained
# a go_fast method. We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

# When we called the go_fast method from an instance of the Car class
# (as shown below) you might have noticed that the string printed when
# we go fast includes the name of the type of vehicle we are using.
# How is this done?

# ANSWER:
# The #class method returns the name of the class of the calling object. 
# self returns the calling object. So when an object of the Car class invoked the 
# go_fast method from the Speed module, self returns the car object, and the
# invocation of #class on that object returns its class: Car. This value is
# interpolated in the string output. This is why the vehicle type of capitalized in
# the output - it is just a string representation of the object's class


# 4
# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# ANSWER:
# Initialize an object of a class with the #new class method:
# kitty = AngryCat.new


# 5
# Which of these two classes has an instance variable and how do you know?
  class Fruit
    def initialize(name)
      name = name
    end
  end
  
  class Pizza
    def initialize(name)
      @name = name
    end
  end

  # ANSWER:
  # class Pizza has an instance variable. We can identify instance
  # variables by the presence of an @ at their beginning. 
  # ALSO you can ask an object to list its instance variables with: .instance_cariables


  # 6
  # What could we add to the class below to access the instance variable @volume?
  class Cube
    def initialize(volume)
      @volume = volume
    end
  end

  # ANSWER:
  # You can add an attr_reader if you just want to read the variable's value.
  # OR you can add attr_accessor if you want to read and write its value.
  # OR you can deinfe your own getter method
  # OR you can get the value of an initialized instance variable with:
  # object.instance_variable_get("@instance_variable_name") NOTE: Don't do this


  # 7
  # What is the default return value of to_s when invoked on an object?
  # Where could you go to find out if you want to be sure?

  # ANSWER:
  # The default return value of #to_s when invoked on an object is a
  # string representation of the object's class name and and encoding of its object id.
  # If you want to be sure, check google, ruby documentation, or test it out in irb


  # 8
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

  # ANSWER:
  # self refers to an instance of the Cat class that called the
  # make_one_year_older method. The attr_accessor method defined a
  # setter method for the instance variable @age. We are using that
  # method in the body of the make_one_year_older method. To make it
  # clear that we are actually using the setter method for @age,
  # we call .age on self. self references the calling object, so when we
  # call .age on that, Ruby then knows that age is a method, not a local
  # variable (initializing a local variable with self
  # just wouldn't make sense, and Ruby knows this)


  # 9
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

  # In the name of the cats_count method we have used self.
  # What does self refer to in this context?

  # ANSWER:
  # In this context, self refers to the class in which the method is defined. 
  # This defines a class method which is called on the class directly, unlike
  # an instance method which is called on instances of the class


  # 10
  # If we have the class below, what would you need to call to create a
  # new instance of this class.
  class Bag
    def initialize(color, material)
      @color = color
      @material = material
    end
  end

  # ANSWER
  # You would need to call .new with arguments which will then be passed
  # to the initialize instance method which sets the initial state of the object
  # upon instantiation:
  louis_v = Bag.new("brown", "leather")
# 1
# Ben asked Alyssa to code review the following code:
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Alyssa glanced over the code quickly and said - "It looks fine, except
# that you forgot to put the @ before balance when you refer to the balance
# instance variable in the body of the positive_balance? method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not
# missing an @!"

# Who is right, Ben or Alyssa, and why?

# ANSWER:
# Ben is right. The attr_reader method provides a getter method for the value
# of the instance variable @balance. This getter method is what is called in the
# body of positive_balance?, so the code is correct.


# 2.
# Alan created the following code to keep track of items for
# a shopping cart application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa looked at the code and spotted a mistake.
# "This will fail when update_quantity is called", she says.
# Can you spot the mistake and how to address it?

# ANSWER:
# First, there is no setter method defined in InvoiceEntry.
# So in order to assign a value to the @quantity instance 
# variable, we have to add an @ in front of quantity so that we
# are assigning the variable itself. Or, we can change attr_reader
# to attr_accessor, which provides a setter method. But then,
# the intention of the code would be to call the setter method
# for @quantity using Ruby's syntactical sugar. However, 
# within a method definition, this syntax of quantity = 
# makes Ruby think that we are initializing a local variable
# within the method. The local variable quantity is set to the
# value of update_count if the value is positive, but then nothing
# is done with the return value. Instead, we need to put self. in
# front of quality so that Ruby knows that we are calling the setter
# method.


# 3
# In the last question Alan showed Alyssa this code which
# keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa noticed that this will fail when update_quantity is called.
# Since quantity is an instance variable, it must be accessed with the
# @quantity notation when setting it. One way to fix this is to change
# attr_reader to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# It works fine, but it exposes the setter method publicly which
# may not be best for your program. You may prefer to minimize the
# public interface so that the value can only be set using a different,
# more-restrictive public method call


# 4
# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single instance method
# called greet that takes a string argument and prints that argument
# to the terminal.

# Now create two other classes that are derived from Greeting:
# one called Hello and one called Goodbye. The Hello class should
# have a hi method that takes no arguments and prints "Hello".
# The Goodbye class should have a bye method to say "Goodbye".
# Make use of the Greeting class greet method when implementing
# the Hello and Goodbye classes - do not use any puts in the
#   Hello or Goodbye classes.

# ANSWER:
class Greeting
  def greet(string)
    puts string
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


# 5
# You are given the following class that has been implemented:
class KrispyKreme
  attr_accessor :filling_type, :glazing
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end

# And the following specification of expected behavior:
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"

# Write additional code for KrispyKreme such that the puts
# statements will work as specified above.

# ANSWER:
class KrispyKreme
  attr_accessor :filling_type, :glazing
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    filling = (filling_type ? filling_type : "Plain")
    glaze = (glazing ? " with #{glazing}" : "")
    filling + glaze
  end
end


# 6
# If we have these two methods in the Computer class:
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?
# In the first Computer class, the create_template method 
# sets the value of instance variable @template by
# referencing the variable itself and assigning a string 
# to it. The show_template method calls a getter method template
# which is provided by attr_accessor and returns the value of the
# @templace instance variable
# In the second Computer class, the create_template method
# sets the value of the @template instance variable using the
# setter method provided by attr_accessir. Sicne this setter is 
# being called within a method definition, self. is prefixed to the
# method call to specify that this is a method call and not
# a local variable initialization. THe show_template method uses
# the getter method provided by attr_accessor to return the value
# of instance variable @template. It is prefixed by .self to
# specify the method call, but there is no need for this. The method can
# be called without self since Ruby does not think this is 
# a local variable initialization. THe other syntax is only necessary
# for setter calls within method definitions.


# 7
# How could you change the method name below so that the method name is
# more clear and less repetitive?
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

# The class name is Light, so we would place its objects in variables like
# living_room_light. And when we call light_status on a variable like that, 
# it starts to look confusing: living_room_light.light_status.
# It would be better to change the name of light_status to just status
# so its calling is more intuitive: living_room_light.status
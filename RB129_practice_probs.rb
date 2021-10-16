1.
class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name


# What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

# This code outputs `nil`. On line 10, an object of class Person is instantiated using the `new` method. This object is then assigned
# to local variable `bob`. On `line 11`, the `name` public getter method is called on the object referenced by local variable `bob`, which is meant
# to return the value of the `@name` instance method thanks to the invocation of the `attr_reader` method with `:name` as its argument
# within the `Person` class. However, this getter method returns `nil` because the `@name` instance variable has not yet been initialized or given a value.
# The `set_name` instance method within the `Person` class would initialize the `@name` instance variable with a string value of 'Bob' if it were to be called,
# but it has not yet been called when the `name` getter method is invoked on `line 11`. Instance variables are different from local variables in that they can
# be referenced before they are initialized with a value. Doing so will return `nil.` On the other hand, referencing an uninitialized local variable will result
# in a NameError --> "undefined local variable or method"

2.
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim   


# What is output and why? What does this demonstrate about instance variables?

# This code outputs `nil`. On `line 40`, an object of class `Dog` is instantiated and stored in local variable `teddy`. On `line 41`,
# the `swim` instance method is called on the object referenced by local variable `teddy`. On `line 25`, this `swim` method is defined
# to return the string `swimming!` if instance variable `@can_swim` is truthy / evaluates to `true`. However, when the `swim` instance method is
# invoked, the `@can_swim` instance variable is not yet initialized, so it has a value of nil and is therefore falsy. The `Swimmable` module
# provides an instance method called `enable_swimming` which initializes and/or assigns the instance variable `@can_swim` to a boolean value of `true` when invoked.
# On `line 33`, the `include` method is invoked with the `Swimmable` module as its argument, which mixes the module into the `Dog` class, giving the
# class access to the module's methods. However, the `enable_swimming` method is never invoked, which explains the nil value of `@can_swim` when the `swim`
# instance method is called on the Dog instance that isstored within local variable `teddy`. Thus, the `swim` instance method returns `nil` instead of `"swimming!",
# and this nil value is what is passed to the `p` method when it is invoked on `line 41`. This results in `nil` being printed to the console. This code demonstrated
# the fact that in ruby, instance variables can be referenced before they are initialized with a value. Doing so will retun `nil`

3. 
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

# `Line 82` outputs `4`. The `sides` class method is called on the `Square` class. Ruby then traverses the
# method lookup path until it finds a class method named `sides` in the `Shape` class and invokes it. Within the
# method, `self` is called, which references the `Square` class. `self` is appended with ::SIDES, which tells Ruby to
# search for the constant `SIDES` within the `Square` class. The constant cannot be found within the class' lexical scope,
# so Ruby searches for the constant in the class' ancestors. It finds the constant within the `Quadrilateral` superclass with
# and it references integer `4`. `4` is returned and this is was is passed to the `p` method invocation on `line 82`, so 4 is
# printed to the console.

# `Line 83` outputs `4`. The `new` method is called on the `Square` class, which instantiates a new object of class 
# `Square`. Then, the `sides` instance method is invoked on this object. Ruby traverses the method lookup path until
# it finds an instance method named `sides` within the `Shape` class and invokes it. Within the method, `self` is called,
# which references the calling object: the Square object instantiated on `line 83`. the `class` instance method
# is called on this object, which returns the `Square` class. `::SIDES` is appended to this, which tells ruby to
# search for constant `SIDES` within the `Square` class. Ruby does not find the constant in lexical scope, so it
# searches the ancestors of `Square` for a constant named `SIDES`. It finds the constant within the `Quadrilateral` superclass with
# and it references integer `4`. `4` is returned and this is was is passed to the `p` method invocation on `line 83`, so 4 is
# printed to the console.

# `Line 84` outputs nothing and raises a NameError -> "uninitialized constant". The `new` method is called on the
# `Square` class, which instantiates an object of class `Square`. Then, the `describe_shape` instance method is invoked
# on the object. Ruby searches for the `describe_shape` by traversing the `Square` class and its ancestors. It
# finds the method within the `Describable` module which is mixed into the `Shape` superclass of class `Square`.
# Ruby invokes the method, which is meant to return a string with two interpolated values. The first interpolated
# value is `self.class` - in this case, `self` refers to the calling object (the instance of class `Square` instantiated
# on `line 84`). The `class` instance method is called on it, which returns `Square`. The second interpolated value
# is the constant `SIDES`, so ruby searches for it within the lexical scope of th module. It finds nothing, and the module
# has no ancestors that Ruby can traverse to find the constant. As a result, the error is raised and no string can be returned.

4.
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes 


# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of
# `AnimalClass#+` to be more in line with what we'd expect the method to return?

# This code outputs an array that contains all of the Animal objects from the AnimalClass instances stored in local variables `mammals`
# and `birds`. `Line 143` instantiates an object of class `AnimalClass` with a name of `Mammals`. Lines `144 - 146` use the instance method
# `<<` to add instances of class Animal with names 'Human', 'Dog', and 'Cat' to the array referenced by instance variable `@animals` within
# the AnimalClass object referenced by local variable `mammals`. Line `148` instantiates an object of class `AnimalClass` with a name of
# `Birds`. Lines `149 - 151` use the instance method `<<` to add instaces of class Animal with names 'Eagle', 'Blue Jay', and 'Penguin',
# respectively, to the array referenced by instance variable `@animals` within the object of class AnimalClass that is referenced by local
# variable `birds`. On `line 153`, the `+` instance method is invoked on the object referenced by local variable `mammals` and the object
# referenced by local variable `birds` is passed in as an argument. The `+ method is defined on `lines 130 - 132` to add together the arrays
# stored within the `@animals` instance variable of both objects. This returns a new array of all Animal objects from both instances. This
# is not exactly what we would expect when using `AnimalClass#+` because we would expect that adding two objects of a type
# results in a new object of the same type. For this to happen, we need to amend the definition of the `+` instance method within class 
# `AnimalClass` to instantiate a new object of class `AnimalClass`. Doing so will require a name, which can perhaps be a combination of the 
# names of the objects that are being added together: e.g. using "@{self.name}#{other_class.name}" as the argument to the `new` method when invoking it
# on class `AnimalClass`. Once the `+` method has added together the Animal object arrays stored in the `@animals` instance variable of each
# `AnimalClass` object, the new array must be stored in the `@animals` instance variable of the new instance of AnimalClass. This object
# can be returned by the new `+` instance method to achieve the result we would expect from such a method.

5.
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.


# We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

# The `change_info` method does not work as expected because Ruby interprets `lines 89 - 191` as local variable initializations. It therefore
# initializes three variables that are local to the `change_info` method: `name`, `height`, and `weight`. These variables are successfully
# assigned to the values stored in parameters `n`, `h`, and `w` respectively, but these local variables are inaccessible outside the method definition
# so nothing is done with the values. To fix this, we need to disambiguate `lines 89 - 191` and specify that we want to set the instance variables
# `@name`, `@height`, and `@weight` using their setter methods provided by the `attr_accessor` method on `line 180`. Do to that, we use the explicit caller
# `self` before each method invocation. This tells ruby that `lines 189 - 191` are setter method invocations, not local variable initializations. This will
# result in the `change_info` instance method successfully updating the object's attributes, and the expected output will be displayed after the call to `puts`
# on `line 201`

6.
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name 
bob.change_name
p bob.name


# In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`? 

# This code raises an error because on `line 225`, Ruby thinks we are initializing a local variable `name`. When we invoke the `upcase` method on `name`,
# RUby attempts to invoke it on the newly-initialized local variable. However, it has not been assigned to a value, so it references `nil` when `upcase`
# is called on it. There is no `upcase` method for `nil`, so we get a NoMethodError. We can fix this in two ways: 1. prepend `name` with `self` to specify
# to Ruby that we are calling a setter method and wish to use `name.upcase` as the argument for it. Or, 2. amend the body of the `change_name` method
# to name.upcase! which will use the getter method to return the value of the `@name` instance variable and then use the `upcase!` method to mutate it to its
# uppercased version.

7.
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           
p Vehicle.wheels                              

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels                           
p Car.wheels     


# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using
# class variables when working with inheritance?

=begin
Line 253 outputs 4 because the Vehicle class initializes the class variable @@wheels with a value of 4.
Class Motorcycle inherits from class Vehicle which means they share the same copy of the class variable
@@wheels. On line 256, the class variable is assigned to an integer value of 2, which means that the
value of @@wheels is 2 for class Vehicle, class Motorcycle, and any other descendents of class Vehicle
(i.e. class Car in this case). Nowhere else in this code amends the value of the class variable @@wheels,
so lines 259, 260, 264, 265, and 266 all output the value of 2 (because they all reference the shared class variable)

=end

8.
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")       
p bruno


# What is output and why? What does this demonstrate about `super`?

=begin
This code outputs a string that captures the following information on the 
object referenced by local variable `bruno`: class name (GoodDog), an encoding of its object id, 
and the object's instance variables along with their values. In this case, the instance variable
information is as follows @name="brown", @color="brown". On line 298, an object of class GoodDog is 
instantiated using the `new` class method with the string "brown" as its argument. The new object's
`initialize` method gets invoked with "brown" as its argument. On `line 293`, the `super` keyword
is called with no arguments. As a result, Ruby looks in the object's inheritance hierarchy for an
`initialize` method and invokes it, passing the same arguments to it ("brown" in this case). This 
resuts in the `@name` instance variable being assigned to a value of "brown". On `line 294`, the 
`@color` instance variable is also assigned to the argument of the initialize method ("brown"). As a result, both
of the object's instance variables now have a string value of "brown". This explains the output explained above.
This demonstrates the fact that calling the `super` key word within an enclosing method without passing any arguments
to it will send the enclosing method's arguments up the inheritance hierarchy to the method with the same name as
the enclosing method. 
=end

9.
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")        


# What is output and why? What does this demonstrate about `super`?

=begin
This outputs an error. The super keyword is used in the `Bear#initialize` method without any arguments, which passes all of the enclosing
method's arguments up the method lookup path to the method `Animal#initialize`. This method is defined to take no arguments, so when the Ruby tries to
pass in "black" as an argument, the exception is raised.

=end



10.
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk


# What is the method lookup path used when invoking `#walk` on `good_dog`?

=begin
The method lookup path used when invoking `#walk` on `good_dog` is as follows:
  GoodGod
  Danceable
  Swimmable
  Animal
  Walkable
=end

11.
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end


# What is output and why? How does this code demonstrate polymorphism? 

=begin
This code outputs:
"I eat"
"I eat plankton"
"I eat kibble"

This is the output because on `lines 422 - 424`, the `each` method is used to 
iterate over an array of objects (of class Animal, Fish, and Dog, respectively). On
each iteration, the current object is passed as an argument to the `feed_animal` method, which
invokes the `eat` instance method on the object. The method name is the same for each iteration,
the outputs are different for each object type because of polymorphism. Each object's class
has a unique implementation of the `eat` instance method which Ruby finds first when traversing the method lookup path.
Even though the Dog` and `Fosh` classes inherit from class `Animal`, their unique `eat` methods get invoked
thanks to the common interface. This is how the code demonstrates polymorophism.
=end


12.
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud                     

bob.pets.jump 


# We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?  

=begin
An error is raised because on `line 474`, we invoke the `pets` getter method on the object of class Person referenced by local variable
`bob`. This returns the value of local variable `@pets`, which is an array of pets (specifically, one element is an object of class Cat and
the other is of class Bulldog). We then proceed to call the instance method `jump` on this array. However, arrays do not have access to a method
called `jump`. This causes the error. To fix this, we would need to iterate over the array referenced by the instance variable `@pets` and 
call a `jump` method on each object accordingly. `kitty` and `bud` represent the pets owned by a person named `bob`, who is represented by an object of class
Person. More specifically, `kitty` and `bud` are collaborator objects for `bob`. Collaborator objects are objects that are used as state for another
object. They are used to represent relationships in code. 
=end

13.
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name   


# What is output and why?

=begin
this code outputs "bark! bark!  bark! bark!"
On `line 504` we instantiate an object of class Dog and pass the string "Teddy" to the `new` method
which passes it to the object's `initialize` as an argument. The `initialize` method within the Dog class
does nothing with this argument, so the `@name` instance variable is not initialized and it thus returns nil when
referenced. On `line 505`, the `dog_name` instance method is invoked on the Dog object referenced by local variable `teddy`,
which interpolates the value of instance variable `@name` within a string. However, since the instance variable is uninitialized,
it has a value of `nil`, which gets interpolated as an empty string (interpolation automatically calls the Kernel#`to_s` method on the
value, which returns "" for nil). This empty string is placed in between "bark! bark! " and " bark! bark!", and this final value is passed to
the `p` method as an argument, which causes it to be outputted to the console with quotation marks (`p` calls `inspect`, which keeps quotation marks
in the output when given a string as an argument.)
=end

14.
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true


# In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`.
# How could we return `true` on `line 11`? 

# Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s
# `@name` instance variables are the same object? How could we prove our case?

=begin
We can have `line 534` return `true` by defining our own `Person#==` instance method that compares the value of a Person object's `@name`
instance variable with that of another object that is passed to the method as an argument:

def ==(other_person)
  name == other.name
end

The fact that al.name == alex.name` returns `true` does not suggest that the two string objects are the same. The `String#==` method returns `true`
if two string objects have the same value, regardless of whether or not they are the same object. We can prove this by using the `equal?` method, or
by comparing the obejct id of each object as follows:

al.name.equal?(alex.name)

or

al.name.object_id == alex.name.object_id

Both of these will return `false`, proving the claim above.

=end

15.
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name


# What is output on `lines 14, 15, and 16` and why?

=begin

Line 579: "Bob"
Line 580: "My name is BOB"
Line 581: "BOB"

On line 578, we instantiate an object of class Person with the `new` class method, amd pass it an argument of string value "Bob".
This argument is passed to the Person#initialize method, where it is assigned to local variable `name`. The method then assigns the object's
instance variable `@name` to the value of local variable `name` - or "Bob". This object gets stored in local variable `bob`. 
On line  579, we call the instance method `name` on the Person object stored in local variable `bob`. This is a getter method for retrieving
the valuabe of the object's instance variable `@name`. In this case, it is "Bob", and this is passed to the `puts` method for output to the
console. On line 580, we call puts and pass the object itself to it as an argument. The method calls `Person#to_s` on it, which interpolates
the return value of calling `upcase!` on the value of instance variable `@name` ("BOB") into a string. The string is passed to the `puts` method
and "My name is BOB" is outputted to the console. On line 581, we again call the instance method `name` on the Person object stored in local
variable `bob`. This time, the value of the variable has been mutated by the previous call to the destructive `upcase!` method on `line 580`. As a result, 
`line 581`. This value is passed to the `puts` method and "BOB" is printed to the console.

=end


 16.
# Why is it generally safer to invoke a setter method (if available) vs. referencing the
# instance variable directly when trying to set an instance variable within the class? Give an example.

=begin
It is generally safer to invoke a setter method (if available) over referencing the instance variable directly
because a typo in a setter method will raise an error whereas a typo in instance variable format (prepended with an @ sigil)
will not raise an error and will be harder to debug. Lastly, if we need to add any functionality when setting a variable's value
(e.g. a logger of when data is written, or a data validation prior to setting the variable's value), we can add the functionality
to the setter method instead of adding the same code throughout the program. A setter method may be used just to set the value of an
instance variable today, but might require extra functionality tomorrow. It is best to maintain the consistency of using setter methods
over setting the instance variable directly.

Example: Our code validates that a person's social security number has nine digits before it is saved to an object's instance variable.
Tomorrow, the format of a social security number has changed: it can be either nine OR ten digits. If we set the variable by directly referencing it in
our code, then we need to adjust the validation code anywhere the value is set / reset. If we set the value using a setter method, then we only
have to change the validation code within the setter method definition.

=end

17.
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

=begin
It would make sense to manually write a custom getter method vs using `attr_reader` if you want to add execute functionality
whenever the variable's data is accessed. Perhaps you want to format a social security number so that only its last four digits are shown
within the program, or perhaps you want to activate a logger any time a variable's data is accessed. These are cases in which a manual method is better
than the simple default provided by `attr_reader`.

=end

18. 
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end


# What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

19.
# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.
20.
# What is the difference between states and behaviors?
21. 
# What is the difference between instance methods and class methods?
22.
# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.
23.
# How and why would we implement a fake operator in a custom class? Give an example.
24.
# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.
25.
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"


 # What does the above code demonstrate about how instance variables are scoped?

26.
# How do class inheritance and mixing in modules affect instance variable scope? Give an example.
27.
# How does encapsulation relate to the public interface of a class?

28.
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky


# What is output and why? How could we output a message of our choice instead?

=begin
This code outputs a string containing the following information: the class name of the object stored in local variable`sparky` (GoodDog),
and an encoding of the object's object_id. On `line 725`, we instantiate an object of class GoodDog using the `new` method, passing in "Sparky"
and integer 4 as arguments. These arguments get passed to the GoodDog#initialize method where they are assigned to instance variables @name and @aage,
respectively. On `line 726`, we invoke the Kernel#puts method, which in turn calls invoked `Object#to_s` on the object referenced by `sparky`. `Object#to_s`
returns a string that contains the object's class name (GoodDog) and an encoding of the object's object_id. This string is then outputted to the console. 
TO output a message of choice instead of this output, we could define a `GoodDog#to_s` method to override `Object#to_s`. Then, whenever `puts` is invoked with 
an object of class GoodDdg as the argument, the new `to_s` will be invoked and the output will be as desired.
=end

# How is the output above different than the output of the code below, and why?

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky


=begin
This code outputs a string that includes the same information as the output above, AND information on the object's state. Specifically, it
also displays the value of any of the object's initialized instance variables (#<GoodDog:930471398x73 @name="Sparky", @age=4>). The reason for this difference
that to output the information, the `Kernel#p` method was invoked and given the object referenced by `sparky` as its argument. The `p` method calls `inspect` on the
object before outputting the result, and by default, the `inspect` method returns the format described above. This value is printed to the console.
=end

29.
# When does accidental method overriding occur, and why? Give an example.
30.
# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.
31.
# Describe the distinction between modules and classes.
32.
# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.
33.
# What is encapsulation, and why is it important in Ruby? Give an example.
34.
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk

kitty = Cat.new("Kitty")
p kitty.walk


# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?
35.
# What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?

36.
# What is the relationship between classes and objects in Ruby?
37.
# When should we use class inheritance vs. interface inheritance?
38.
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new


# If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?
39.
class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end


# Describe the inheritance structure in the code above, and identify all the superclasses.
40.
module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly


# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.
41.
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak


# What does this code output and why?

42.
class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")


# Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.

43.
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
  
  def change_grade(new_grade)
    grade = new_grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade 


# In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?
44.
class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new


# What does each `self` refer to in the above code snippet?

45.
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end 
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">


# Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?
46.
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name 
p sir_gallant.speak 


# What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`? 

47. 
class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak
p Lamb.new.speak
p Cow.new.speak 


# What is output and why? 
48.
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)


# What are the collaborator objects in the above code snippet, and what makes them collaborator objects?
49.
number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end


# What methods does this `case` statement use to determine which `when` clause is executed?

50.
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# What are the scopes of each of the different variables in the above code?
51.
# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.

52. 
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


# In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?
53.
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive


# What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?
54.
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive


# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?




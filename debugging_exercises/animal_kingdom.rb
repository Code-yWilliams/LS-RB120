# The code below raises an exception.
# Examine the error message and alter the
# code so that it runs without error.

# class Animal
#   def initialize(diet, superpower)
#     @diet = diet
#     @superpower = superpower
#   end

#   def move
#     puts "I'm moving!"
#   end

#   def superpower
#     puts "I can #{@superpower}!"
#   end
# end

# class Fish < Animal
#   def move
#     puts "I'm swimming!"
#   end
# end

# class Bird < Animal
# end

# class FlightlessBird < Bird
#   def initialize(diet, superpower)
#     super
#   end

#   def move
#     puts "I'm running!"
#   end
# end

# class SongBird < Bird
#   def initialize(diet, superpower, song)
#     super
#     @song = song
#   end

#   def move
#     puts "I'm flying!"
#   end
# end

# # Examples

# unicornfish = Fish.new(:herbivore, 'breathe underwater')
# penguin = FlightlessBird.new(:carnivore, 'drink sea water')
# robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower) # SOLUTION
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# Further Exploration:
# Is the FlightlessBird#initialize method necessary? Why or why not?
# NO, it is not necessary. It just calls super, which tells Ruby to look
# for the initialize method in the class' superclass. Instead, we could just
# not include an initialize method. When an object of class FlightlessBird
# is instantiated, Ruby will look in the method lookup chain for a method
# called initialize and then invoke it, which effectively has the same
# effect.
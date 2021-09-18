# Given the below usage of the Person class, code the class definition.

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

# Modify the class definition from above to facilitate the following methods.
# Note that there is no name= setter method now.

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

class Person
  attr_accessor :name, :first_name, :last_name
  def initialize(name)
    @first_name = (name.split[0])
    @last_name = (name.split[1])
  end
  def name
    !!last_name ? (first_name + " " + last_name) : first_name
  end
end

# Now create a smart name= method that can take just a first name or
# a full name, and knows how to set the first_name and last_name appropriately.

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'

class Person
  attr_accessor :first_name, :last_name
  def initialize(name)
    set_first_last(name)
  end
  def name
    (self.first_name + " " + self.last_name).strip
  end
  def name=(name)
    set_first_last(name)
  end
  private
  def set_first_last(name)
    self.first_name = name.split[0]
    self.last_name = !!name.split[1] ? name.split[1] : ""
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
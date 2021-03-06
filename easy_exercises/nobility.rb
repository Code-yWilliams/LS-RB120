# Now that we have a Walkable module, we are given a new challenge.
# Apparently some of our users are nobility, and the regular way of
# walking simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:

# byron = Noble.new("Byron", "Lord")
# p byron.walk
# # => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other purposes that we aren't showing here.

# byron.name
# => "Byron"
# byron.title
# => "Lord"

module Walkable
  def walk
    "#{self} #{self.gait} forward"
  end
  def to_s
    self.name
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

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{self.title} #{self.name}"
  end

  private

  def gait
    "struts"
  end
end

  mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk

byron = Noble.new("Byron", "Lord")
p byron.walk

# OR, could have defined a get_name method that gets the regular name for everyone but
# instead gets the FULL name (title and name) for nobility

# OR, could have used class inheritance
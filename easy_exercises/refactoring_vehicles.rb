# Consider the following classes:

# class Car
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def wheels
#     4
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Motorcycle
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def wheels
#     2
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Truck
#   attr_reader :make, :model, :payload

#   def initialize(make, model, payload)
#     @make = make
#     @model = model
#     @payload = payload
#   end

#   def wheels
#     6
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# Refactor these classes so they all use a common superclass, and inherit behavior as needed.

class Vehicle
  attr_accessor :make, :model, :wheels
  def initialize(make, model, wheels)
    self.make = make
    self.model = model
    self.wheels = wheels
  end
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
end

class Motorcycle < Vehicle
end

class Truck < Vehicle
  attr_accessor :payload
  def initialize(make, model, wheels, payload)
    super(make, model, wheels)
    @payload = payload
  end
end

jp = Motorcycle.new("Harley Davidson", "Motorboik", 2)
p [jp.make, jp.model, jp.wheels]
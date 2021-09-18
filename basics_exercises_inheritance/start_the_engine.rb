# Change the following code so that creating a new Truck
# automatically invokes #start_engine.

# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def start_engine
    puts 'Ready to go!'
  end
  def initialize(year)
    super(year) # don't need the parameter here - if you don't put paremtheses on super,
    # Ruby will pass all arguments to the super method
    start_engine
  end
end

truck1 = Truck.new(1994)
puts truck1.year
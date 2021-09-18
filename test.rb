class Vehicle
  attr_accessor :speed, :heading
  attr_writer :fuel_efficiency, :fuel_capacity

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle < Vehicle 
  attr_reader :tires
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
end

class Motorcycle < WheeledVehicle
end

class Watercraft < Vehicle
  attr_reader :propeller_count, :hull_count
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count= num_hulls
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Watercraft
end

class Motorboat < Watercraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

mb = Motorboat.new(10, 10)
p mb.propeller_count
p mb.hull_count
p mb

ctmrn = Catamaran.new(4, 2, 15, 20)
p ctmrn.propeller_count
p ctmrn.hull_count
p ctmrn

car = Auto.new([30, 32, 30, 32], 25, 20)
car.inflate_tire(3, 45)
p car.tires
p car
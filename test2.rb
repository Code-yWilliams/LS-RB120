class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end
                            

class Motorcycle < Vehicle
  @@wheels = 2
end

p Vehicle.wheels    

# p Motorcycle.wheels                           
# p Vehicle.wheels                              

# class Car < Vehicle; end

# p Vehicle.wheels
# p Motorcycle.wheels                           
# p Car.wheels     
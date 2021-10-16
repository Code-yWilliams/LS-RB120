# Mixins allow us to mimic multiple inheritance in Ruby. Ruby will only allow a class to inherit from one class. To provide
# additional access to reusable code within a class that already has one superclass, we can have it include a module or multiple
# modules, which provides the additional functionality as if it were inheriting from multiple classes. However, modules are different in
# that objects cannot be instantiated from modules and modules to not have any ancestors themselves as they are standalone code. 

# Modules also allow for namespacing, which involves grouping related methods, classes, and/or constants within a module. This allows us
# to organize our code into groupings that are easier to understand within the larger context of the program. Another benefit is that 
# namespacing helps to prevent collisions within code. If two classes share a name, the only way to effectively use them in a program is
# to differentiate between them using a particular namespace so that Ruby explicitly knows which one to use.

# Lastly, modules allow us to
# implement "has-a" or "can" relationships within our code. Class inheritance allows us to mimic "is a" relationships, which leads to
# subclasses inheriting the functionality of a superclass. But sometimes, we do not want ALL of a class' descendents to access a particular
# method. In this case, we can use modules/mixins to provide functionality to some subclasses while leaving irrelevant subclasses out of the
# interface inheritance. 

# Namespacing involves grouping related classes within a module so that their purpose and functionslity within the larger program is easier to understand


module Gadgets
  module WirelessChargeable
    def wireless_charge
      puts "Charging via the Chi standard."
    end
  end

  class Smartphone
    attr_accessor :storage_capacity, :network_generation

    def initialize(storage_capacity_in_gb, network_generation)
      @storage_capacity = storage_capacity
      @network_generation = network_generation
    end

    def identify
      "I am a #{network_generation} smartphone with #{storage_capacity}gb of storage"
    end
  end

  class Iphone < Smartphone
    def identify
      super + " running iPhone OS"
    end
  end

  class Android < Smartphone
    def identify
      super + " running Android OS"
    end
  end

  class Iphone13Pro < Iphone
    include WirelessChargeable
  end

  class SamsungGalaxyS21 < Android
    include WirelessChargeable
  end
end

module Cameras
  class Iphone13Pro
    def identify
      "Lidar scanner, ultra-wide lens, wide lens, telephoto lens"
    end
  end
end

a = Gadgets::Iphone13Pro.new(128, "5G")
b = Cameras::Iphone13Pro.new

puts a.identify
puts b.identify